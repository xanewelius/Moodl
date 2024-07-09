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
        logging.error(f'Error processing section: {e}')
        return None

@app.route('/search', methods=['GET'])
def search():
    search_string = request.args.get('q', '')
    if not search_string:
        return jsonify({'error': 'Query parameter "q" is required'}), 400
    
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
        logging.error(f'Error with WebDriver: {e}')
        return jsonify({'error': 'Internal Server Error'}), 500

if __name__ == '__main__':
    app.run(debug=True)

