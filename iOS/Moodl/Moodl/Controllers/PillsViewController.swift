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
    
    override func setupUI() {
        super.setupUI()
        self.title = "Лекарства"
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
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PillsGrid.id, for: indexPath) as? PillsGrid else { return UICollectionViewCell() }
        cell.controller = self
        cell.configure()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 48) / 2, height: 105)
    }
}
