//
//  SettingsView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var session: AppSession
    @Environment(\.dismiss) private var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var planType: String = ""
    @State private var memberID: String = ""
    @State private var groupID: String = ""
    @State private var effectiveDate: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Personal")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
            }
            Section(header: Text("Plan")) {
                TextField("Plan Type", text: $planType)
                TextField("Member ID", text: $memberID)
                TextField("Group ID", text: $groupID)
                DatePicker("Effective", selection: $effectiveDate, displayedComponents: .date)
            }
            
            Section {
                Button {
                    session.user.firstName = firstName
                    session.user.lastName  = lastName
                    session.user.email     = email
                    session.user.planType  = planType
                    session.user.memberID  = memberID
                    session.user.groupID   = groupID
                    session.user.planEffective = effectiveDate
                    session.showSuccess("Profile updated")
                    dismiss()
                } label: {
                    Text("Save Changes").frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            firstName = session.user.firstName
            lastName  = session.user.lastName
            email     = session.user.email
            planType  = session.user.planType
            memberID  = session.user.memberID
            groupID   = session.user.groupID
            effectiveDate = session.user.planEffective
        }
    }
}
