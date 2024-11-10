// HomeView.swift
// WA8_<Xian>_<5969>
//
// Created by 刘逸飞 on 2024/11/9.

import Foundation
import UIKit

class HomeView: UIView {
    let welcomeLabel = UILabel()
    let logoutButton = UIButton(type: .system)
    let tableView = UITableView()

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
        welcomeLabel.text = "Welcome to the Home Page!"
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 5
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
    }

    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, logoutButton, tableView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        tableView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}
