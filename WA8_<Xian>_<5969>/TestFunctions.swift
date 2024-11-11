//
//  TestFunctions.swift
//  WA8_<Xian>_<5969>
//
//  Created by jun ye on 2024/11/10.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TestFunctions {
    
    static func createMockUsers() {
        let db = Firestore.firestore()
        let mockUsers = [
            ["name": "Alice", "email": "alice@example.com", "password": "password123"],
            ["name": "Bob", "email": "bob@example.com", "password": "password123"],
            ["name": "Charlie", "email": "charlie@example.com", "password": "password123"]
        ]
        
        for user in mockUsers {
            Auth.auth().createUser(withEmail: user["email"]!, password: user["password"]!) { authResult, error in
                if let error = error {
                    print("Error creating user \(user["email"]!): \(error.localizedDescription)")
                } else {
                    db.collection("users").document(user["email"]!).setData([
                        "name": user["name"]!,
                        "email": user["email"]!
                    ]) { error in
                        if let error = error {
                            print("Error saving user data: \(error.localizedDescription)")
                        } else {
                            print("User \(user["email"]!) created successfully.")
                        }
                    }
                }
            }
        }
    }
    
    static func insertMockChatData() {
        let db = Firestore.firestore()
        let mockChats = [
            ["senderName": "Alice", "messageText": "Hi, Bob!", "timestamp": Date(), "senderEmail": "alice@example.com"],
            ["senderName": "Bob", "messageText": "Hello, Alice!", "timestamp": Date(), "senderEmail": "bob@example.com"],
            ["senderName": "Charlie", "messageText": "Hi everyone!", "timestamp": Date(), "senderEmail": "charlie@example.com"]
        ]
        
        for chat in mockChats {
            db.collection("messages").addDocument(data: chat) { error in
                if let error = error {
                    print("Error adding chat message: \(error.localizedDescription)")
                } else {
                    print("Mock chat message added successfully.")
                }
            }
        }
    }
    
    static func testFetchUsers() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    print("User: \(document.data())")
                }
            }
        }
    }
    
    static func testFetchChats() {
        let db = Firestore.firestore()
        db.collection("messages").order(by: "timestamp").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching chat messages: \(error.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    print("Message: \(document.data())")
                }
            }
        }
    }
}
