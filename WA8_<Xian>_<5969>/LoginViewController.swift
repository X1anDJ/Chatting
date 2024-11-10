//
//  LoginViewController.swift
//  WA8_<Xian>_<5969>
//
//  Created by 刘逸飞 on 2024/11/9.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        guard let email = loginView.emailField.text, !email.isEmpty,
              let password = loginView.passwordField.text, !password.isEmpty else {
            showAlert(message: "All fields must be filled")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "Invalid email format")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .userNotFound:
                    self.showAlert(message: "The email address is not registered.")
                case .wrongPassword:
                    self.showAlert(message: "Incorrect password.")
                case .invalidEmail:
                    self.showAlert(message: "Invalid email format.")
                default:
                    self.showAlert(message: "Login failed: \(error.localizedDescription)")
                }
                return
            }
            
            self.showAlert(message: "Login successful!", completion: {
                let homeVC = HomeViewController()
                self.navigationController?.pushViewController(homeVC, animated: true)
            })
        }
    }
    
    @objc func registerTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
