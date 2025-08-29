//
//  LoginView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: AppSession
    @State private var email = ""
    @State private var password = ""
    var onSwitch: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Log In").font(.largeTitle.bold())
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding().background(.gray.opacity(0.1)).cornerRadius(10)
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .padding().background(.gray.opacity(0.1)).cornerRadius(10)
            
            Button {
                session.login(email: email, password: password)
            } label: {
                Text("Log In")
                    .font(.headline).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding()
                    .background(Color.blue).cornerRadius(10)
            }.disabled(email.isEmpty || password.isEmpty)
            
            Spacer()
            HStack {
                Text("Don't have an account?")
                Button("Sign Up", action: onSwitch)
                    .fontWeight(.bold)
            }
        }
    }
}

struct SignupView: View {
    @EnvironmentObject var session: AppSession
    @State private var firstName = ""
    @State private var lastName  = ""
    @State private var email     = ""
    @State private var password  = ""
    var onSwitch: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up").font(.largeTitle.bold())
            
            TextField("First Name", text: $firstName)
                .textContentType(.givenName)
                .autocapitalization(.words)
                .padding().background(.gray.opacity(0.1)).cornerRadius(10)
            
            TextField("Last Name", text: $lastName)
                .textContentType(.familyName)
                .autocapitalization(.words)
                .padding().background(.gray.opacity(0.1)).cornerRadius(10)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding().background(.gray.opacity(0.1)).cornerRadius(10)
            
            SecureField("Password", text: $password)
                .textContentType(.newPassword)
                .padding().background(.gray.opacity(0.1)).cornerRadius(10)
            
            Button {
                session.signup(first: firstName, last: lastName, email: email, password: password)
            } label: {
                Text("Create Account")
                    .font(.headline).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding()
                    .background(Color.green).cornerRadius(10)
            }.disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty)
            
            Spacer()
            HStack {
                Text("Already have an account?")
                Button("Log In", action: onSwitch)
                    .fontWeight(.bold)
            }
        }
    }
}
