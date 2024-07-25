//
//  TagView.swift
//  Moodl
//
//  Created by Max Kuzmin on 24.07.2024.
//

import UIKit

final class TagView: UIView {
    private let stackView = UIStackView()
    private let label     = UILabel()
    
    init(tag: Tag) {
        super.init(frame: .zero)
        setupUI()
        layout()
        configure(for: tag)
    }
    required init?(coder: NSCoder) { nil }
    
    func configure(for tag: Tag) {
        label.text = tag.text
    }
    
    private func setupUI() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.662745098, green: 0.6705882353, blue: 0.7176470588, alpha: 1) //A9ABB7
        
        layer.cornerRadius = 5
        layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.6705882353, blue: 0.7176470588, alpha: 1) //A9ABB7
        layer.borderWidth = 1
    }
    
    private func layout() {
        stackView.addArrangedSubview(label)
        add(stackView)
        stackView.box(in: self, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override var intrinsicContentSize: CGSize {
        let width = label.intrinsicContentSize.width + 20
        let height: CGFloat = 27
        return CGSize(width: width, height: height)
    }
}
