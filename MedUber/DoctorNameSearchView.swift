//
//  DoctorNameSearchView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/28/25.
//

import Foundation
import SwiftUI
import SwiftUICore

// This is the data model for a single doctor.
// It includes properties to hold all the information seen in the image.
struct Doctor: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let specialties: [String]
    let acceptingNewPatients: Bool
    let phoneNumber: String
}

// This is a mock array of doctor data based on the provided image.
let mockDoctors = [
    Doctor(name: "Frank A. Cammarata, LCSW", location: "5586 Main St Ste G2, Williamsville, NY 14221", specialties: ["Clinical Social Worker"], acceptingNewPatients: true, phoneNumber: "(716) 630-7075"),
    Doctor(name: "Dr Frank A Cammarata LCSW", location: "5586 Main St Ste G2, Williamsville, NY 14221", specialties: ["Multi-Specialty Group"], acceptingNewPatients: true, phoneNumber: "(716) 630-7075"),
    Doctor(name: "Amber F Blanchard LCSW", location: "5586 Main St Ste 210, Williamsville, NY 14221", specialties: ["Multi-Specialty Group"], acceptingNewPatients: false, phoneNumber: "(716) 463-5602"),
    Doctor(name: "Dr. Jane Smith", location: "123 Health Ave, Anytown, CA 90210", specialties: ["Cardiology"], acceptingNewPatients: true, phoneNumber: "(555) 123-4567"),
    Doctor(name: "Dr. John Doe", location: "456 Main St, Metropolis, NY 10001", specialties: ["Neurology"], acceptingNewPatients: true, phoneNumber: "(555) 987-6543"),
    Doctor(name: "Dr. Emily White", location: "789 Pine Ln, Springfield, IL 62704", specialties: ["Dermatology"], acceptingNewPatients: false, phoneNumber: "(555) 234-5678")
]

// MARK: - DoctorNameSearchView

// This view shows a searchable list of doctors.
struct DoctorNameSearchView: View {
    let doctors: [Doctor]
    
    var body: some View {
        VStack {
            // A simple list to display the doctors.
            List(doctors) { doctor in
                // NavigationLink to the DoctorDetailView when a doctor is tapped.
                NavigationLink(destination: DoctorDetailView(doctor: doctor)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(doctor.name)
                            .font(.headline)
                            .foregroundColor(.black) // Changed font color
                        Text(doctor.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding() // Add padding for spacing inside the card
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .listRowSeparator(.hidden) // Hides the default list separator lines
                .padding(.horizontal, 10)
                .padding(.vertical, 5) // Add vertical padding between list items
            }
            .navigationTitle("Doctors")
            .listStyle(.plain) // Use a plain list style to remove the default list background
        }
    }
}

// MARK: - DoctorDetailView

// This view displays the detailed information for a single doctor.
// The layout is inspired by the image you provided.
struct DoctorDetailView: View {
    let doctor: Doctor
    // State variable to control the confirmation message
    @State private var showConfirmation = false
    // "selectedClinicName" acts like a session variable
    @AppStorage("selectedDoctorName") private var selectedDoctorName: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Doctor's name and title
                Text(doctor.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Main details section
                VStack(alignment: .leading, spacing: 10) {
                    Text(doctor.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Displaying specialties, phone number, etc.
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Specialties:")
                                .fontWeight(.medium)
                            Text(doctor.specialties.joined(separator: ", "))
                        }
                        
                        HStack {
                            Text("Accepting new patients:")
                                .fontWeight(.medium)
                            Text(doctor.acceptingNewPatients ? "Yes" : "No")
                                .foregroundColor(doctor.acceptingNewPatients ? .green : .red)
                        }
                        
                        HStack {
                            Text("Phone Number:")
                                .fontWeight(.medium)
                            Text(doctor.phoneNumber)
                        }
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Conditional button and message
                if doctor.acceptingNewPatients {
                    Button(action: {
                        selectedDoctorName = doctor.name
                        showConfirmation = true
                        // Hide the message after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showConfirmation = false
                            }
                        }
                    }) {
                        Text("Confirm")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                // Conditional confirmation message
                if showConfirmation {
                    Text("This doctor is selected!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .transition(.opacity) // Fades in and out smoothly
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(doctor.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
