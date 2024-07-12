//
//  PillsGrid.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import UIKit

internal final class PillsGrid: Grid {
    static var id: String = "pillsGrid"
    
    override func setup() {
        super.setup()
        setupUI()
        layout()
    }
    
    public func configure() {
        
    }
    
    private func setupUI() {
        backgroundColor = .black
    }
    
    private func layout() {
        
    }
}
