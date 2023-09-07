//
//  ColorViewController.swift
//  ColorView
//
//  Created by Matvei Khlestov on 15.07.2023.
//

import UIKit

class ColorViewController: UIViewController {
    
    // MARK: - Public Properties
    var delegate: ColorViewControllerDelegate!
    var viewColor: UIColor!
    
    // MARK: - Private Properties
    private let colorView = UIView()
    
    private let redColorLabel = UILabel()
    private let greenColorLabel = UILabel()
    private let blueColorLabel = UILabel()
    
    private let redValueLabel = UILabel()
    private let greenValueLabel = UILabel()
    private let blueValueLabel = UILabel()
    
    private let redTextField = UITextField()
    private let greenTextField = UITextField()
    private let blueTextField = UITextField()
    
    private let doneButton = UIButton()
    
    private let redSlider = UISlider()
    private let greenSlider = UISlider()
    private let blueSlider = UISlider()
    
    private let stackViewForColorLabels = UIStackView()
    private let stackViewForValueLabels = UIStackView()
    private let stackViewForSliders = UIStackView()
    private let stackViewForTextFields = UIStackView()
    private let mainStackView = UIStackView()
    
    // MARK: - Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private Methods
extension ColorViewController {
    private func configure() {
        view.backgroundColor = UIColor(named: "viewColor")
        
        setupSubviews()
        
        colorViewConfigure()
        
        labelsConfigure()
        
        slidersConfigure()
        
        textFieldsConfigure()
        
        stackViewsConfigure()
        
        doneButtonConfigure()
        
        setSliders()
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func setupSubviews() {
        setupSubviews(
            colorView,
            mainStackView,
            doneButton
        )
        
        setupSubviewsFor(
            stackViewForColorLabels,
            subviews: redColorLabel, greenColorLabel, blueColorLabel
        )
        setupSubviewsFor(
            stackViewForValueLabels,
            subviews: redValueLabel, greenValueLabel, blueValueLabel
        )
        setupSubviewsFor(
            stackViewForSliders,
            subviews: redSlider, greenSlider, blueSlider
        )
        setupSubviewsFor(
            stackViewForTextFields,
            subviews: redTextField, greenTextField, blueTextField)
        
        setupSubviewsFor(
            mainStackView,
            subviews: stackViewForColorLabels,
            stackViewForValueLabels, stackViewForSliders, stackViewForTextFields
        )
    }
    
    private func setupSubviewsFor(_ stackView: UIStackView, subviews: UIView...) {
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
    
    private func setValue(for textFields: UITextField...) {
        for textField in textFields {
            switch textField {
            case redTextField:
                textField.text = string(from: redSlider)
            case greenTextField:
                textField.text = string(from: greenSlider)
            default:
                textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func colorViewConfigure() {
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = viewColor
        colorView.translatesAutoresizingMaskIntoConstraints = false
        setConstraintsForColorView()
    }
    
    private func labelsConfigure() {
        redColorLabel.text = "Red"
        greenColorLabel.text = "Green"
        blueColorLabel.text = "Blue"
        
        setupConfiguresFor(
            redColorLabel,
            greenColorLabel,
            blueColorLabel,
            redValueLabel,
            greenValueLabel,
            blueValueLabel
        )
    }
    
    private func setupConfiguresFor(_ labels: UILabel...) {
        for label in labels {
            label.font = .systemFont(ofSize: 17)
            label.textColor = .white
            label.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func setupConfiguresFor(_ textFields: UITextField...) {
        for textField in textFields {
            textField.font = .systemFont(ofSize: 17)
            textField.borderStyle = .roundedRect
            textField.placeholder = "1.00"
            textField.adjustsFontSizeToFitWidth = true
            textField.delegate = self
        }
    }
    
    private func slidersConfigure() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        addTarget(redSlider, greenSlider, blueSlider)
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func addTarget(_ sliders: UISlider...) {
        for slider in sliders {
            slider.addTarget(self, action: #selector(sliderColorChanged), for: .valueChanged)
        }
    }
    
    @objc private func sliderColorChanged(_ slider: UISlider) {
        
        switch slider {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueTextField)
        }
        
        setColor()
    }
    
    private func textFieldsConfigure() {
        setupConfiguresFor(
            redTextField,
            greenTextField,
            blueTextField
        )
    }
    
    private func doneButtonConfigure() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 30)
        doneButton.titleLabel?.textColor = .white
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraintsForDoneButton()
    }
    
    @objc private func doneButtonPressed() {
        delegate?.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
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
            case stackViewForTextFields:
                stackView.axis = .vertical
                stackView.alignment = .fill
                stackView.distribution = .fill
                stackView.spacing = 10
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
            stackViewForTextFields,
            mainStackView
        )
        
        stackViewForColorLabels.translatesAutoresizingMaskIntoConstraints = false
        stackViewForValueLabels.translatesAutoresizingMaskIntoConstraints = false
        stackViewForTextFields.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraintsFor(stackViewForColorLabels, constant: 44)
        setConstraintsFor(stackViewForValueLabels, constant: 30)
        setConstraintsFor(stackViewForTextFields, constant: 50)
        setConstraintsForMainStackView()
    }
}

// MARK: - Alert Controller
extension ColorViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

// MARK: - Constraints
extension ColorViewController {
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
    
    private func setConstraintsFor(_ stackView: UIStackView, constant: CGFloat) {
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
    
    private func setConstraintsForDoneButton() {
        NSLayoutConstraint.activate(
            [
                doneButton.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
                doneButton.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -53
                )
            ]
        )
    }
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redValueLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenValueLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueValueLabel)
            }
            
            setColor()
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.keyboardType = .decimalPad
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}


