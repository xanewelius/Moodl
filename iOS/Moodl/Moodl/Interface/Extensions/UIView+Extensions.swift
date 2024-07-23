//
//  UIView+Extensions.swift
//  Moodl
//
//  Created by Max Kuzmin on 23.07.2024.
//

import UIKit

extension UIView {
    public var auto: Bool {
        get { translatesAutoresizingMaskIntoConstraints }
        set { translatesAutoresizingMaskIntoConstraints = newValue}
    }
    
    public func add(_ subview: UIView, auto: Bool = false) {
        subview.translatesAutoresizingMaskIntoConstraints = auto
        addSubview(subview)
    }
    public func box(in view: UIView, inset: CGFloat, safe: Bool = false) {
        box(in: view, insets: .init(top: inset, left: inset, bottom: inset, right: inset), safe: safe)
    }
    public func box(in view: UIView, insets: UIEdgeInsets = .zero, safe: Bool = false) {
        topAnchor.constraint(equalTo: safe ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor, constant: insets.top).isActive = true
        leadingAnchor.constraint(equalTo: safe ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor , constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: safe ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor, constant: -insets.right).isActive = true
        bottomAnchor.constraint(equalTo: safe ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    public func center(in view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    public func size(width: CGFloat, height: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
