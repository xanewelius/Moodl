//
//  MultilineFlowLayout.swift
//  Moodl
//
//  Created by Max Kuzmin on 24.07.2024.
//

import UIKit

final class MultilineFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}
