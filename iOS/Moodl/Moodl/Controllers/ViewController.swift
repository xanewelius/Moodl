//
//  ViewController.swift
//  Moodl
//
//  Created by Max Kuzmin on 09.07.2024.
//

import UIKit

public class ViewController: UIViewController {
    public var provider: Provider?
    
    public init(provider: Provider? = Provider()) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        provider?.setup() { [weak self] in
            DispatchQueue.main.async {
                self?.recieve()
            }
        }
    }
    
    public func recieve() {
        setupUI()
        layout()
    }
    
    public func setupUI() {}
    public func layout() {}
}
