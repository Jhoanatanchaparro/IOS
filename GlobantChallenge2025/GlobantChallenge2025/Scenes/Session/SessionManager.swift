//
//  SessionManager.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 29/07/25.
//
import Foundation

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""

    private let emailKey = "user_email"

    init() {
        if let savedEmail = UserDefaults.standard.string(forKey: emailKey) {
            self.email = savedEmail
            self.isLoggedIn = true
        }
    }

    func login(with email: String) {
        self.email = email
        self.isLoggedIn = true
        UserDefaults.standard.set(email, forKey: emailKey)
    }

    func logout() {
        self.email = ""
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: emailKey)
    }
}
