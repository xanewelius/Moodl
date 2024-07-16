//
//  PillsProvider.swift
//  Moodl
//
//  Created by Max Kuzmin on 10.07.2024.
//

import Foundation

public final class PillsProvider: Provider {
    public var pills: [Pill] = []
    
    public override init() {}
    
    public override func preloaded() async {
        do {
            let url = URL(string: "http://127.0.0.1:5000/get")!
            let request = URLRequest(url: url)
            let response = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode([Pill].self, from: response.0)
            pills = result
        } catch {
            print("Preloaded error")
        }
    }
}

extension PillsProvider {
    public func delete(id: String) async throws {
        do {
            let url = URL(string: "http://127.0.0.1:5000/delete/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let _ = try await URLSession.shared.data(for: request)
        } catch {
            print("Delete error")
        }
    }
}
