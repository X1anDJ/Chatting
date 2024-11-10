//
//  RegisterView.swift
//  WA8_<Xian>_<5969>
//
//  Created by 刘逸飞 on 2024/11/9.
//

import Foundation
import UIKit

class RegisterView: UIView {
    let nameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let confirmPasswordField = UITextField()
    let registerButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        style()
        layout()
    }
    
    private func style() {
        nameField.placeholder = "Name"
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        confirmPasswordField.placeholder = "Confirm Password"
        
        nameField.borderStyle = .roundedRect
        emailField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        confirmPasswordField.borderStyle = .roundedRect
        
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [nameField, emailField, passwordField, confirmPasswordField, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
