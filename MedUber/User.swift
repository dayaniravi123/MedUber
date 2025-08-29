//
//  User.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/29/25.
//


import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var planType: String
    var memberID: String
    var groupID: String
    var planEffective: Date
    
    static var empty: User {
        return User(
            firstName: "",
            lastName: "",
            email: "",
            planType: "",
            memberID: "",
            groupID: "",
            planEffective: Date()
        )
    }
}
