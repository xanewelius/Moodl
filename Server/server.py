import os
import uuid
import json
import logging
from flask import Flask, request, jsonify
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from concurrent.futures import ThreadPoolExecutor

app = Flask(__name__)

# Настройка логирования
logging.basicConfig(level=logging.INFO)

# Пул потоков для параллельной обработки
executor = ThreadPoolExecutor(max_workers=4)

def fetch_data(section):
    """
    Получает данные о секции на странице.

    Аргументы:
        section (WebElement): Секция на странице.

    Возвращает:
        dict или None: Словарь с данными о секции или None, если произошла ошибка.
    """
    try:
        img = section.find_element(By.CSS_SELECTOR, 'div.listing-card__img > a.listing-card__link > img')
        title = section.find_element(By.CSS_SELECTOR, 'h5.listing-card__title')
        link = section.find_element(By.CSS_SELECTOR, 'div.listing-card__img > a.listing-card__link')
        return {
            'img': img.get_attribute('src'),
            'link': link.get_attribute('href'),
            'title': title.text
        }
    except Exception as e:
        logging.error(f'Ошибка при обработке секции: {e}')
        return None

@app.route('/search', methods=['GET'])
def search():
    """
    Поиск товаров на сайте аптеки по запросу.

    Аргументы:
        q (str): Запрос для поиска товаров.

    Возвращает:
        JSON: Словарь с результатами поиска.
    """
    search_string = request.args.get('q')
    if not search_string:
        return jsonify({'error': 'Необходимо указать запрос в параметре "q"'}), 400
    
    url = f'https://www.eapteka.ru/search/?q={search_string}'
    options = Options()
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=640,480')
    
    try:
        with webdriver.Chrome(options=options) as driver:
            driver.get(url)
            sections = driver.find_elements(By.CSS_SELECTOR, 'section.listing-card')
            result = []
            seen = set()

            future_to_section = {executor.submit(fetch_data, section): section for section in sections}
            for future in future_to_section:
                data = future.result()
                if data and (data['title'], data['img']) not in seen:
                    result.append(data)
                    seen.add((data['title'], data['img']))
        
        return jsonify({'result': result})
    except Exception as e:
        logging.error(f'Ошибка с WebDriver: {e}')
        return jsonify({'error': 'Внутренняя ошибка сервера'}), 500

def generate_unique_id():
    """
    Генерирует уникальный идентификатор.

    Возвращает:
        str: Уникальный идентификатор.
    """
    return str(uuid.uuid4())

@app.route('/add', methods=['POST'])
def add():
    """
    Добавление нового товара в базу данных.

    Аргументы:
        new_entry (dict): Словарь с данными о товаре.

    Возвращает:
        JSON: Словарь с результатом добавления товара.
    """
    new_entry = request.get_json()
    required_fields = ["name", "img", "expiryDate", "category", "dosage"]

    if not new_entry:
        return jsonify({'error': 'Некорректный ввод, требуется JSON'}), 400
    
    missing_fields = [field for field in required_fields if field not in new_entry]
    if missing_fields:
        return jsonify({'error': f'Отсутствуют необходимые поля: {", ".join(missing_fields)}'}), 400
    
    new_entry['id'] = generate_unique_id()
    file_path = 'data.json'
    
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
    else:
        data = []
    
    data.append(new_entry)
    
    with open(file_path, 'w', encoding='utf-8') as file:
        json.dump(data, file, ensure_ascii=False, indent=4)
    
    return jsonify({'status': 'success', 'data': new_entry}), 201

@app.route('/get', methods=['GET'])
def get_data():
    """
    Отображает все данные из файла data.json.

    Возвращает:
        JSON: Словарь с данными из файла.
    """
    file_path = 'data.json'
    
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
    else:
        return jsonify({'error': 'Файл data.json не найден'}), 404
    
    return jsonify(data)

@app.route('/clear', methods=['GET'])
def clear_data():
    """
    Очищает файл data.json.

    Возвращает:
        JSON: Словарь с результатом очистки.
    """
    file_path = 'data.json'

    if os.path.exists(file_path):
        with open(file_path, 'w', encoding='utf-8') as file:
            json.dump([], file, ensure_ascii=False, indent=4)
        return jsonify({'status': 'success'}), 200
    else:
        return jsonify({'error': 'Файл data.json не найден'}), 404

@app.route('/delete/<string:item_id>', methods=['DELETE'])
def delete_item(item_id):
    """
    Удаляет товар из базы данных по его уникальному идентификатору.

    Аргументы:
        item_id (str): Уникальный идентификатор товара.

    Возвращает:
        JSON: Словарь с результатом удаления товара.
    """
    file_path = 'data.json'
    
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
        
        data = [item for item in data if item['id'] != item_id]
        
        with open(file_path, 'w', encoding='utf-8') as file:
            json.dump(data, file, ensure_ascii=False, indent=4)
        
        return jsonify({'status': 'success'}), 200
    else:
        return jsonify({'error': 'Файл data.json не найден'}), 404

if __name__ == '__main__':
    app.run(debug=True)
