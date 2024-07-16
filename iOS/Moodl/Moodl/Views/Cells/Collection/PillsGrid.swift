//
//  PillsGrid.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import UIKit

internal final class PillsGrid: Grid {
    static var id: String = "pillsGrid"
    
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
        
        category.textColor = .white
        //category.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3843137255, blue: 0.3568627451, alpha: 1) //0E625B
        category.numberOfLines = 2
        
        date.textColor = .white
    }
    
    private func layout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        options.translatesAutoresizingMaskIntoConstraints = false
        category.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        addSubview(name)
        addSubview(options)
        addSubview(category)
        addSubview(date)
        
        image.widthAnchor.constraint(equalToConstant: 92).isActive = true
        image.heightAnchor.constraint(equalToConstant: 92).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        name.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: options.leadingAnchor, constant: -12).isActive = true
        
        options.widthAnchor.constraint(equalToConstant: 24).isActive = true
        options.heightAnchor.constraint(equalToConstant: 21).isActive = true
        options.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        options.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        category.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        category.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        
        date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
