//
//  PillsGrid.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import UIKit

internal final class PillsGrid: Grid {
    static var id: String = "pillsGrid"
    private var pill: Pill?
    
    private var image    = UIImageView()
    private var name     = UILabel()
    private var category = UILabel()
    private var date     = UILabel()
    
    private var options = UIButton()
    
    override func setup() {
        super.setup()
        setupUI()
        layout()
    }
    
    public func configure(pill: Pill) {
        self.pill = pill
        image.loadImage(pill.img ?? "")
        name.text = pill.name
        category.text = pill.category?.first
        date.text = pill.expiryDate
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.4823529412, blue: 0.4470588235, alpha: 1) //147B72
        layer.cornerRadius = 24
        
        image.layer.cornerRadius = 16
        image.backgroundColor = #colorLiteral(red: 0, green: 0.5803921569, blue: 0.5294117647, alpha: 1) //009487
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        name.textColor = .white
        //name.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4352941176, blue: 0.4039215686, alpha: 1) //126F67
        
        options.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        options.tintColor = .white
        options.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        category.textColor = .white
        //category.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3843137255, blue: 0.3568627451, alpha: 1) //0E625B
        category.numberOfLines = 2
        
        date.textColor = .white
    }
    
    private func layout() {
        add(image)
        add(name)
        add(options)
        add(category)
        add(date)
        
        image.size(width: 92, height: 92)
        image.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        name.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: options.leadingAnchor, constant: -12).isActive = true
        
        options.size(width: 24, height: 21)
        options.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        options.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        category.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        category.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        
        date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    @objc
    private func tapped() {
        guard let pill = self.pill else { return }
        (self.controller as? PillsViewController)?.presentAlert(pill: pill)
    }
}
