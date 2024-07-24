//
//  CategoryGrid.swift
//  Moodl
//
//  Created by Max Kuzmin on 23.07.2024.
//

import UIKit

internal final class CategoryGrid: Grid {
    static var id: String = "categoryGrid"
    
    private var label = UILabel()
    
    override func setup() {
        super.setup()
        setupUI()
        layout()
    }
    
    public func configure(category: String) {
        self.label.text = category
    }
    
    private func setupUI() {
        layer.cornerRadius = 5
        layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.6705882353, blue: 0.7176470588, alpha: 1) //A9ABB7
        layer.borderWidth = 1
        
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black.withAlphaComponent(0.5)
        label.numberOfLines = 1
    }
    
    private func layout() {
        add(label)
        label.box(in: self, insets: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
}

