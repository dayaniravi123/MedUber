//
//  AppSession.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//
//

import SwiftUI
import Combine
import Foundation
import Security

final class AppSession: ObservableObject {
    enum Destination { case dashboard, search }

    @Published var isLoggedIn: Bool = false
    @Published var destination: Destination = .search
    @Published var user: User = .empty
    @Published var showBanner: Bool = false
    @Published var bannerMessage: String = ""

    @AppStorage("hasSignedUp") private var hasSignedUp: Bool = false
    @AppStorage("userEmail") private var storedEmail: String = ""
    @AppStorage("firstName") private var storedFirstName: String = ""
    @AppStorage("lastName") private var storedLastName: String = ""

    // MARK: - Bootstrap
    func bootstrap() {
        if hasSignedUp && !storedEmail.isEmpty {
            // Assume logged in (could also persist a session flag)
            user = User(firstName: storedFirstName,
                        lastName: storedLastName,
                        email: storedEmail,
                        planType: "NYSHIP",
                        memberID: "W1440432200",
                        groupID: "22652",
                        planEffective: Date())
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }

    // MARK: - Auth
    func signup(first: String, last: String, email: String, password: String) {
        // Prevent duplicate signup
        guard !hasSignedUp else {
            showError("An account already exists.")
            return
        }

        // Save locally
        savePasswordToKeychain(email: email, password: password)
        storedEmail = email
        storedFirstName = first
        storedLastName = last
        hasSignedUp = true

        user = User(firstName: first, lastName: last, email: email,
                    planType: "NYSHIP", memberID: "W1440432200",
                    groupID: "22652", planEffective: Date())

        isLoggedIn = true
        showSuccess("Account created locally")
    }

    func login(email: String, password: String) {
        guard hasSignedUp, email == storedEmail else {
            showError("No account found.")
            return
        }

        if let savedPassword = getPasswordFromKeychain(email: email),
           savedPassword == password {
            user = User(firstName: storedFirstName, lastName: storedLastName, email: email,
                        planType: "NYSHIP", memberID: "W1440432200",
                        groupID: "22652", planEffective: Date())
            isLoggedIn = true
            showSuccess("Logged in locally")
        } else {
            showError("Invalid credentials.")
        }
    }

    func logout() {
        isLoggedIn = false
        destination = .search
        user = .empty
    }

    // MARK: - Keychain Helpers
    private func savePasswordToKeychain(email: String, password: String) {
        let data = password.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary) // remove old
        SecItemAdd(query as CFDictionary, nil)
    }

    private func getPasswordFromKeychain(email: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }

    // MARK: - Banners
    func showSuccess(_ text: String) {
        bannerMessage = text
        withAnimation { showBanner = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { withAnimation { self.showBanner = false } }
    }
    func showError(_ text: String) {
        bannerMessage = text
        withAnimation { showBanner = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { withAnimation { self.showBanner = false } }
    }
}
