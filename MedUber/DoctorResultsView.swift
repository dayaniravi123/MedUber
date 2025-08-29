//
//  DoctorResultsView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//

import SwiftUI

// MARK: - Mock Data

// This is a mock array of common medical specialties.
let mockSpecialties = [
    "Cardiology",
    "Neurology",
    "Dermatology",
    "Oncology",
    "Pediatrics",
    "Orthopedics",
    "Gastroenterology",
    "Psychiatry"
]



// MARK: - DoctorResultsView

// This is the main landing view after a user logs in.
// It now includes navigation logic to other views.
struct DoctorResultsView: View {
    let userName: String
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Hello \(userName.uppercased()),")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
            
            Text("What are you searching for today?")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 20) {
                // NavigationLink for "Doctors by name"
                NavigationLink(destination: DoctorNameSearchView(doctors: mockDoctors)) {
                    OptionCard(title: "Doctors by name", systemImage: "person.text.rectangle")
                }
                
                // NavigationLink for "Doctors by specialty"
                NavigationLink(destination: SpecialistListView()) {
                    OptionCard(title: "Doctors by specialty", systemImage: "stethoscope")
                }
                
                // Other options are not yet linked to new views.
                NavigationLink(destination: Text("Places by name view")) {
                    OptionCard(title: "Places by name", systemImage: "magnifyingglass")
                }
                
                NavigationLink(destination: Text("Places by type view")) {
                    OptionCard(title: "Places by type", systemImage: "building.2.fill")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

// A reusable card for the main options.
struct OptionCard: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 40))
                .foregroundColor(.gray)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

// MARK: - SpecialistListView

// This view shows the list of all available specialties.
struct SpecialistListView: View {
    var body: some View {
        VStack {
            List(mockSpecialties, id: \.self) { specialty in
                NavigationLink(destination: DoctorNameSearchView(doctors: mockDoctors.filter { $0.specialties.contains(specialty) })) {
                    Text(specialty)
                }
            }
            .navigationTitle("Specialists")
        }
    }
}

