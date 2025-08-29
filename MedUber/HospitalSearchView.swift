//
//  HospitalSearchView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/28/25.
//

import Foundation
import SwiftUI

// MARK: - Hospital Model
struct Hospital: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let specialties: [String]
    let phoneNumber: String
    let capacity: Int   // Example: number of beds
}

// MARK: - Mock Data
let mockHospitals = [
    Hospital(name: "Buffalo General Medical Center", location: "100 High St, Buffalo, NY 14203", specialties: ["Cardiology", "Oncology", "Orthopedics"], phoneNumber: "(716) 859-5600", capacity: 484),
    Hospital(name: "Mercy Hospital of Buffalo", location: "565 Abbott Rd, Buffalo, NY 14220", specialties: ["Emergency Care", "Surgery", "Maternity"], phoneNumber: "(716) 826-7000", capacity: 349),
    Hospital(name: "Sisters of Charity Hospital", location: "2157 Main St, Buffalo, NY 14214", specialties: ["Cardiac Care", "Neurology"], phoneNumber: "(716) 862-1000", capacity: 467),
    Hospital(name: "Erie County Medical Center", location: "462 Grider St, Buffalo, NY 14215", specialties: ["Trauma", "Burn Unit", "Psychiatry"], phoneNumber: "(716) 898-3000", capacity: 550),
    Hospital(name: "Millard Fillmore Suburban Hospital", location: "1540 Maple Rd, Williamsville, NY 14221", specialties: ["Internal Medicine", "Emergency", "Rehabilitation"], phoneNumber: "(716) 568-3600", capacity: 265),
    Hospital(name: "Kenmore Mercy Hospital", location: "2950 Elmwood Ave, Kenmore, NY 14217", specialties: ["Orthopedics", "Surgical Care"], phoneNumber: "(716) 447-6100", capacity: 184)
]

// MARK: - HospitalSearchView
struct HospitalSearchView: View {
    let hospitals: [Hospital]
    
    var body: some View {
        VStack {
            List(hospitals) { hospital in
                NavigationLink(destination: HospitalDetailView(hospital: hospital)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(hospital.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(hospital.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .listRowSeparator(.hidden)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
            }
            .navigationTitle("Hospitals")
            .listStyle(.plain)
        }
    }
}

// MARK: - HospitalDetailView
struct HospitalDetailView: View {
    let hospital: Hospital
    @State private var showConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(hospital.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(hospital.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    LabeledContent(label: "Specialties", value: hospital.specialties.joined(separator: ", "))
                    
                    LabeledContent(label: "Capacity", value: "\(hospital.capacity) beds")
                        .foregroundColor(.blue)
                    
                    LabeledContent(label: "Phone Number", value: hospital.phoneNumber)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Button(action: {
                    showConfirmation = true
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
                
                if showConfirmation {
                    Text("This hospital is selected!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .transition(.opacity)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Hospital Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private struct LabeledContent: View {
        let label: String
        let value: String
        
        var body: some View {
            HStack {
                Text(label + ":")
                    .fontWeight(.medium)
                Text(value)
            }
        }
    }
}
