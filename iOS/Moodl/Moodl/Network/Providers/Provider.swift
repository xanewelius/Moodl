//
//  Provider.swift
//  Moodl
//
//  Created by Max Kuzmin on 16.07.2024.
//

import Foundation

open class Provider {
    public init() {}
    public func setup(completion: @escaping () -> Void) {
        Task {
            await preloaded()
            completion()
        }
    }
    
    public func preloaded() async {}
}
