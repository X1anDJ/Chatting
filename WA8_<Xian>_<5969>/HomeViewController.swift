// HomeViewController.swift
// WA8_<Xian>_<5969>
//
// Created by 刘逸飞 on 2024/11/9.

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let homeView = HomeView()
    private var users: [String] = []

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self

        // Fetch all registered users
        fetchUsers()
    }

    func fetchUsers() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                var usersList: [String] = []
                for document in querySnapshot!.documents {
                    if let email = document.data()["email"] as? String {
                        usersList.append(email)
                    }
                }
                self.updateUserList(usersList)
            }
        }
    }

    func updateUserList(_ usersList: [String]) {
        self.users = usersList
        DispatchQueue.main.async {
            self.homeView.tableView.reloadData()
        }
    }

    @objc func logoutTapped() {
        do {
            try Auth.auth().signOut()
            showAlert(message: "Logout successful!", completion: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        } catch let signOutError as NSError {
            print("Error details: \(signOutError.localizedDescription)")
            showAlert(message: "Logout failed: \(signOutError.localizedDescription)")
        }
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
}
