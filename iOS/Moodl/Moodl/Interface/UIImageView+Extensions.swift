//
//  UIImageView+Extensions.swift
//  Moodl
//
//  Created by Max Kuzmin on 16.07.2024.
//

import UIKit

extension UIImageView {
    func loadImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
