//
//  MainViewController.swift
//  ColorView
//
//  Created by Matvei Khlestov on 03.09.2023.
//

import UIKit

protocol ColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavController()
    }
    
    private func setupNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped)
        )
    }
    
    @objc private func settingsButtonTapped() {
        let colorVC = ColorViewController()
        colorVC.delegate = self
        colorVC.viewColor = view.backgroundColor
        colorVC.modalPresentationStyle = .fullScreen
        
        present(colorVC, animated: true)
    }
}

// MARK: - ColorDelegate
extension MainViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
