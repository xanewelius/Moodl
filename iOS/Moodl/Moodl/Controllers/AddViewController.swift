//
//  AddViewController.swift
//  Moodl
//
//  Created by Max Kuzmin on 17.07.2024.
//

import UIKit

final class AddViewController: ViewController {
    private var iconCollection: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        return collection
    }
    private var categoryCollection: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        return collection
    }
    
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
        
        iconCollection.delegate = self
        categoryCollection.delegate = self
        iconCollection.dataSource = self
        categoryCollection.dataSource = self
    }
    override func layout() {
        super.layout()
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        iconCollection.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
        category.translatesAutoresizingMaskIntoConstraints = false
        categoryCollection.translatesAutoresizingMaskIntoConstraints = false
        dosage.translatesAutoresizingMaskIntoConstraints = false
        specification.translatesAutoresizingMaskIntoConstraints = false
        save.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        scroll.addSubview(stack)
        view.addSubview(scroll)
        
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        stack.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 0).isActive = true
        stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -20).isActive = true
        stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 0).isActive = true
        
        name.topAnchor.constraint(equalTo: stack.topAnchor, constant: 16).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        nameField.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
        nameField.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
        iconCollection.heightAnchor.constraint(equalToConstant: 156).isActive = true
        dateField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        categoryCollection.heightAnchor.constraint(equalToConstant: 196).isActive = true
        specification.heightAnchor.constraint(equalToConstant: 300).isActive = true
        save.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
