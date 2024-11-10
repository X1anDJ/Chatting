//
//  LoginView.swift
//  WA8_<Xian>_<5969>
//
//  Created by 刘逸飞 on 2024/11/9.
//

import Foundation
import UIKit

class LoginView: UIView {
    let emailField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton(type: .system)
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
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        emailField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton, registerButton])
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
