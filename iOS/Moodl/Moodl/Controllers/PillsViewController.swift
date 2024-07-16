//
//  PillsViewController.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import UIKit

final class PillsViewController: ViewController {
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func recieve() {
        super.recieve()
        collection.reloadData()
    }
    
    override func setupBar() {
        super.setupBar()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 82, height: view.frame.height))
        titleLabel.text = "Лекарства"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        navigationItem.titleView = titleLabel

        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 28))
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "plus"), for: .normal)
        rightButton.frame = CGRect(x: 8, y: 0, width: 28, height: 28)
        buttonContainer.addSubview(rightButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonContainer)
    }
    
    override func setupUI() {
        super.setupUI()
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(PillsGrid.self, forCellWithReuseIdentifier: PillsGrid.id)
    }
    
    override func layout() {
        super.layout()
        view.addSubview(collection)
        
        collection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension PillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (provider as? PillsProvider)?.pills.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PillsGrid.id, for: indexPath) as? PillsGrid, let pill = (provider as? PillsProvider)?.pills[indexPath.row] else { return UICollectionViewCell() }
        cell.controller = self
        cell.configure(pill: pill)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 124)
    }
}
