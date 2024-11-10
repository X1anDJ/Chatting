//
//  RegisterViewController.swift
//  WA8_<Xian>_<5969>
//
//  Created by 刘逸飞 on 2024/11/9.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    private let registerView = RegisterView()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Bind the register button to the action
        registerView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc func registerTapped() {
        guard let name = registerView.nameField.text, !name.isEmpty,
              let email = registerView.emailField.text, !email.isEmpty,
              let password = registerView.passwordField.text, !password.isEmpty,
              let confirmPassword = registerView.confirmPasswordField.text, !confirmPassword.isEmpty else {
            showAlert(message: "All fields must be filled")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "Invalid email format")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error as NSError? {
                // Handle different registration errors
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    self.showAlert(message: "The email address is already in use.")
                case .weakPassword:
                    self.showAlert(message: "The password is too weak.")
                case .invalidEmail:
                    self.showAlert(message: "Invalid email format.")
                default:
                    self.showAlert(message: "Registration failed: \(error.localizedDescription)")
                }
                return
            }
            
            // Save the user details to Firestore
            let db = Firestore.firestore()
            db.collection("users").document(email).setData([
                "name": name,
                "email": email
            ]) { error in
                if let error = error {
                    print("Error details: \(error.localizedDescription)")
                    self.showAlert(message: "Failed to save user data: \(error.localizedDescription)")
                } else {
                    // Automatically sign in the user after successful registration
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("Error during sign-in: \(error.localizedDescription)")
                            self.showAlert(message: "Sign-in failed: \(error.localizedDescription)")
                            return
                        }
                        // Navigate to HomeViewController after successful sign-in
                        let homeVC = HomeViewController()
                        homeVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(homeVC, animated: true)
                    }
                }
            }
        }
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
