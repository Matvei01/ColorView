//
//  MainViewController.swift
//  ColorView
//
//  Created by Matvei Khlestov on 29.05.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(for color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.viewColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - ColorDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColor(for color: UIColor) {
        view.backgroundColor = color
    }
}
