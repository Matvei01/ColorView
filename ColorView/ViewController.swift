//
//  ViewController.swift
//  ColorView
//
//  Created by Matvei Khlestov on 15.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let colorView = UIView()
    
    private let redColorLabel = UILabel()
    private let greenColorLabel = UILabel()
    private let blueColorLabel = UILabel()
    
    private let redValueLabel = UILabel()
    private let greenValueLabel = UILabel()
    private let blueValueLabel = UILabel()
    
    
    private let redSlider = UISlider()
    private let greenSlider = UISlider()
    private let blueSlider = UISlider()
    
    private let stackViewForColorLabels = UIStackView()
    private let stackViewForValueLabels = UIStackView()
    private let stackViewForSliders = UIStackView()
    private let mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSubviews()
        
        setColor()
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        colorViewConfigure()
        
        labelsConfigure()
        
        slidersConfigure()
        
        stackViewsConfigure()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func setupSubviews() {
        setupSubviews(
            colorView,
            redColorLabel,
            greenColorLabel,
            blueColorLabel,
            redValueLabel,
            greenValueLabel,
            blueValueLabel,
            redSlider,
            greenSlider,
            blueSlider,
            stackViewForColorLabels,
            stackViewForSliders,
            mainStackView
        )
    }
    
    private func setupSubviews(stackView: UIStackView, subviews: UIView...) {
        for subview in subviews {
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        for label in labels {
            
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider)
            case greenValueLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func colorViewConfigure() {
        colorView.layer.cornerRadius = 15
        colorView.translatesAutoresizingMaskIntoConstraints = false
        setConstraintsForColorView()
    }
    
    private func labelsConfigure() {
        redColorLabel.text = "Red"
        greenColorLabel.text = "Green"
        blueColorLabel.text = "Blue"
        
        setFontForLabels(
            redColorLabel,
            greenColorLabel,
            blueColorLabel,
            redValueLabel,
            greenValueLabel,
            blueValueLabel
        )
    }
    
    private func setFontForLabels(_ labels: UILabel...) {
        for label in labels {
            label.font = .systemFont(ofSize: 14)
        }
    }
    
    private func slidersConfigure() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setColorForThumbs(redSlider, greenSlider, blueSlider)
        
        addTarget(redSlider, greenSlider, blueSlider)
    }
    
    private func setColorForThumbs(_ sliders: UISlider...) {
        for slider in sliders {
            slider.thumbTintColor = .lightGray
        }
    }
    
    private func addTarget(_ sliders: UISlider...) {
        for slider in sliders {
            slider.addTarget(self, action: #selector(sliderColorChanged), for: .valueChanged)
        }
    }
    
    @objc private func sliderColorChanged(_ slider: UISlider) {
        setColor()
        
        switch slider {
        case redSlider:
            setValue(for: redValueLabel)
        case greenSlider:
            setValue(for: greenValueLabel)
        default:
            setValue(for: blueValueLabel)
        }
    }
    
    private func stackViewsLayouts(_ stackViews: UIStackView...) {
        for stackView in stackViews {
            
            switch stackView {
            case stackViewForColorLabels, stackViewForValueLabels:
                stackView.axis = .vertical
                stackView.alignment = .fill
                stackView.distribution = .fill
                stackView.spacing = 25
            case stackViewForSliders:
                stackView.axis = .vertical
                stackView.alignment = .fill
                stackView.distribution = .fill
                stackView.spacing = 12
            default:
                stackView.axis = .horizontal
                stackView.alignment = .center
                stackView.distribution = .fill
                stackView.spacing = 8
            }
        }
    }
    
    private func stackViewsConfigure() {
        
        stackViewsLayouts(
            stackViewForColorLabels,
            stackViewForValueLabels,
            stackViewForSliders,
            mainStackView
        )
        
        stackViewForColorLabels.translatesAutoresizingMaskIntoConstraints = false
        stackViewForValueLabels.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraintsForLabelStackView(stackViewForColorLabels, constant: 44)
        setConstraintsForLabelStackView(stackViewForValueLabels, constant: 30)
        setConstraintsForMainStackView()
        
        setupSubviews(
            stackView: stackViewForColorLabels,
            subviews: redColorLabel, greenColorLabel, blueColorLabel
        )
        setupSubviews(
            stackView: stackViewForValueLabels,
            subviews: redValueLabel, greenValueLabel, blueValueLabel
        )
        setupSubviews(
            stackView: stackViewForSliders,
            subviews: redSlider, greenSlider, blueSlider
        )
        setupSubviews(
            stackView: mainStackView,
            subviews: stackViewForColorLabels, stackViewForValueLabels, stackViewForSliders
        )
    }
    
    private func setConstraintsForColorView() {
        NSLayoutConstraint.activate(
            [
                colorView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 34
                ),
                colorView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
                colorView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
                colorView.heightAnchor.constraint(
                    equalToConstant: 128
                )
            ]
        )
    }
    
    private func setConstraintsForLabelStackView(_ stackView: UIStackView, constant: CGFloat) {
        NSLayoutConstraint.activate(
            [
                stackView.widthAnchor.constraint(
                    equalToConstant: constant
                )
            ]
        )
    }
    
    private func setConstraintsForMainStackView() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor.constraint(
                    equalTo: colorView.bottomAnchor,
                    constant: 53
                ),
                mainStackView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
                mainStackView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                )
            ]
        )
    }
}
