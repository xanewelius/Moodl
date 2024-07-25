//
//  TagListView.swift
//  Moodl
//
//  Created by Max Kuzmin on 24.07.2024.
//

import UIKit

final class TagListView: UIView {
    private var tagViews: [TagView] = []
    private let tagHeight: CGFloat = 27
    private let tagSpacingX: CGFloat = 16
    private let tagSpacingY: CGFloat = 16
    
    func configure(for tags: [Tag]) {
        tagViews.forEach { $0.removeFromSuperview() }
        tagViews = tags.map { TagView(tag: $0) }
        tagViews.forEach { addSubview($0) }
        layoutTags()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTags()
    }
    
    private func layoutTags() {
        let containerWidth = bounds.width
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        
        for tagView in tagViews {
            let tagWidth = tagView.intrinsicContentSize.width
            
            if currentOriginX + tagWidth > containerWidth {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            
            tagView.frame = CGRect(x: currentOriginX, y: currentOriginY, width: tagWidth, height: tagHeight)
            
            currentOriginX += tagWidth + tagSpacingX
        }
    }
}

