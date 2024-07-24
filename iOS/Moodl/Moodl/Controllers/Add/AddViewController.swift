//
//  AddViewController.swift
//  Moodl
//
//  Created by Max Kuzmin on 17.07.2024.
//

import UIKit

final class AddViewController: ViewController {
    private let iconCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    private let categoryCollection: UICollectionView = {
        let layout = MultilineFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private let icon = ["", "", "", ""]
    private let _category = ["Пищеварение", "Противоаллергенное", "Анальгетик", "Противозастудное", "Противовоспалительное", "Антибиотик", "Антибактериальные"]
    
    private let scroll        = UIScrollView()
    private let stack         = UIStackView()
    private let name          = UILabel()
    private let nameField     = UITextField()
    private let date          = UILabel()
    private let dateField     = UIDatePicker()
    private let category      = UILabel()
    private let dosage        = UISegmentedControl()
    private let specification = UITextView()
    private let save          = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBar() {
        super.setupBar()
        title = "Добавление"
    }
    
    override func setupUI() {
        super.setupUI()
        
        scroll.alwaysBounceVertical = true
        scroll.insetsLayoutMarginsFromSafeArea = false
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = false
        
        stack.axis = .vertical
        stack.spacing = 16
        
        name.text = "Название лекарства"
        name.font = .systemFont(ofSize: 17)
        
        nameField.placeholder = "Название"
        nameField.layer.cornerRadius = 16
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: .zero))
        nameField.leftViewMode = .always
        nameField.layer.borderWidth = 1
        
        date.text = "Срок годности"
        date.font = .systemFont(ofSize: 17)
        
        dateField.datePickerMode = .date
        dateField.preferredDatePickerStyle = .wheels
        
        category.text = "Категории применения"
        category.font = .systemFont(ofSize: 17)
        
        specification.layer.borderWidth = 1
        specification.backgroundColor = .white
        specification.layer.borderColor = UIColor.black.cgColor
        specification.layer.cornerRadius = 16
        //specification.placeholder = "Опишите вашу проблему"
        specification.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        specification.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        specification.textContainer.maximumNumberOfLines = 14
        specification.textContainer.lineBreakMode = .byTruncatingTail
        specification.isUserInteractionEnabled = true
        
        save.setTitle("Сохранить", for: .normal)
        save.setTitleColor(.black, for: .normal)
        save.layer.borderColor = UIColor.black.cgColor
        save.layer.cornerRadius = 16
        save.layer.borderWidth = 1
        
        iconCollection.backgroundColor = .clear
        iconCollection.delegate = self
        iconCollection.dataSource = self
        iconCollection.register(IconsGrid.self, forCellWithReuseIdentifier: IconsGrid.id)
        
        categoryCollection.backgroundColor = .clear
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(CategoryGrid.self, forCellWithReuseIdentifier: CategoryGrid.id)
    }
    override func layout() {
        super.layout()
        
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(nameField)
        stack.addArrangedSubview(iconCollection)
        stack.addArrangedSubview(date)
        stack.addArrangedSubview(dateField)
        stack.addArrangedSubview(category)
        stack.addArrangedSubview(categoryCollection)
//        stack.addArrangedSubview(dosage)
        stack.addArrangedSubview(specification)
        stack.addArrangedSubview(save)
        
        scroll.add(stack)
        view.add(scroll)
        
        scroll.box(in: view, safe: true)
        
        stack.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        stack.box(in: scroll)
        
        name.topAnchor.constraint(equalTo: stack.topAnchor, constant: 16).isActive = true
        name.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
        
        nameField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        nameField.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        nameField.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
        
        iconCollection.heightAnchor.constraint(equalToConstant: 124).isActive = true
        iconCollection.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0).isActive = true
        iconCollection.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0).isActive = true

        date.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        date.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
        
        dateField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateField.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        dateField.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
        
        category.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        category.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
        
        categoryCollection.heightAnchor.constraint(equalToConstant: 156).isActive = true
        categoryCollection.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0).isActive = true
        categoryCollection.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0).isActive = true
        
        specification.heightAnchor.constraint(equalToConstant: 300).isActive = true
        specification.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        specification.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
        
        save.heightAnchor.constraint(equalToConstant: 50).isActive = true
        save.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16).isActive = true
        save.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -16).isActive = true
    }
}

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case iconCollection:
            return 4
        case categoryCollection:
            return _category.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case iconCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconsGrid.id, for: indexPath) as? IconsGrid else { return UICollectionViewCell() }
            cell.controller = self
            return cell
        case categoryCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryGrid.id, for: indexPath) as? CategoryGrid else { return UICollectionViewCell() }
            cell.configure(category: _category[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case iconCollection:
            return CGSize(width: 106, height: 124)
        case categoryCollection:
            let category = _category[indexPath.row]
            let width = category.width(withConstrainedHeight: 27, font: UIFont.systemFont(ofSize: 17)) + 20
            return CGSize(width: width, height: 27)
        default:
            return CGSize.zero
        }
    }
}
