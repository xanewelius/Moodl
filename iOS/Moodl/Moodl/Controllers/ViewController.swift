//
//  ViewController.swift
//  Moodl
//
//  Created by Max Kuzmin on 09.07.2024.
//

import UIKit

public class ViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Лекарства"
        recieve()
    }
    
    public func recieve() {
        setupUI()
        layout()
    }
    
    public func setupUI() {}
    public func layout() {}
}
