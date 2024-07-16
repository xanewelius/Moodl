//
//  PillsGrid.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import UIKit

internal final class PillsGrid: Grid {
    static var id: String = "pillsGrid"
    
    private var image = UIImageView()
    private var name  = UILabel()
    
    override func setup() {
        super.setup()
        setupUI()
        layout()
    }
    
    public func configure(pill: Pill) {
        image.loadImage(pill.img ?? "")
        name.text = pill.name
    }
    
    private func setupUI() {
        backgroundColor = .black
        layer.cornerRadius = 12
        
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        name.textColor = .white
    }
    
    private func layout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        addSubview(name)
        
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
