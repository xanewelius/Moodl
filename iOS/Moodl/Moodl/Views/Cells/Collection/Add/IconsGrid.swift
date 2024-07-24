//
//  IconsGrid.swift
//  Moodl
//
//  Created by Max Kuzmin on 23.07.2024.
//

import UIKit

internal final class IconsGrid: Grid {
    static var id: String = "iconsGrid"
    
    private var image = UIImageView()
    
    override func setup() {
        super.setup()
        setupUI()
        layout()
    }
    
    public func configure(image: UIImage) {
        self.image.image = image
    }
    
    private func setupUI() {
        layer.cornerRadius = 16
        layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.6705882353, blue: 0.7176470588, alpha: 1) //A9ABB7
        layer.borderWidth = 1
        
        image.layer.cornerRadius = 16
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    }
    
    private func layout() {
        add(image)
        
        image.size(width: 92, height: 92)
        image.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}

