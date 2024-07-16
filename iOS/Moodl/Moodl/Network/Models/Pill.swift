//
//  Pills.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import Foundation

public struct Pill: Codable {
    let category: [String]?
    let description: String?
    let dosage: String?
    let expiryDate: String?
    let id: String?
    let img: String?
    let name: String?
}
