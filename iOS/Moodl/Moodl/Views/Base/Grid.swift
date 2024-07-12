//
//  Grid.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import UIKit

public class Grid: UICollectionViewCell {
    public let content = UIView()
    
    public weak var controller: ViewController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
        setup()
    }
    required init?(coder: NSCoder) { nil }
    
    public func setup() {}
    private func setupContent() {
        contentView.addSubview(content)
        
        content.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
