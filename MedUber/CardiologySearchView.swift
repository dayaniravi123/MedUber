//
//  CardiologySearchView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/28/25.
//

import Foundation
import SwiftUI

// MARK: - Cardiology Model
struct CardiologyClinic: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let services: [String]
    let phoneNumber: String
    let yearsInPractice: Int
}

// MARK: - Mock Data
let mockCardiologyClinics = [
    CardiologyClinic(name: "Buffalo Heart Center", location: "123 Main St, Buffalo, NY 14202", services: ["Cardiac Diagnostics", "Stress Test", "Echocardiography"], phoneNumber: "(716) 555-1234", yearsInPractice: 15),
    CardiologyClinic(name: "Mercy Cardiology Clinic", location: "456 Park Ave, Buffalo, NY 14222", services: ["Arrhythmia Treatment", "Heart Failure Management"], phoneNumber: "(716) 555-5678", yearsInPractice: 10),
    CardiologyClinic(name: "UB Heart Institute", location: "789 Elmwood Ave, Buffalo, NY 14222", services: ["Cardiac Imaging", "Interventional Cardiology"], phoneNumber: "(716) 555-9012", yearsInPractice: 20),
    CardiologyClinic(name: "CardioCare Associates", location: "321 Oak St, Amherst, NY 14226", services: ["Preventive Cardiology", "Electrophysiology"], phoneNumber: "(716) 555-3456", yearsInPractice: 12),
    CardiologyClinic(name: "Western New York Heart Specialists", location: "654 Maple Rd, Buffalo, NY 14214", services: ["Heart Surgery Consultation", "Lipid Management"], phoneNumber: "(716) 555-7890", yearsInPractice: 18)
]

// MARK: - CardiologySearchView
struct CardiologySearchView: View {
    let clinics: [CardiologyClinic]
    
    var body: some View {
        VStack {
            List(clinics) { clinic in
                NavigationLink(destination: CardiologyDetailView(clinic: clinic)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(clinic.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(clinic.location)
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
            .navigationTitle("Cardiology Clinics")
            .listStyle(.plain)
        }
    }
}

// MARK: - CardiologyDetailView
struct CardiologyDetailView: View {
    let clinic: CardiologyClinic
    @State private var showConfirmation = false
    
    // "selectedClinicName" acts like a session variable
    @AppStorage("selectedClinicName") private var selectedClinicName: String = ""
        
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(clinic.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(clinic.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    LabeledContent(label: "Services", value: clinic.services.joined(separator: ", "))
                    
                    LabeledContent(label: "Years in Practice", value: "\(clinic.yearsInPractice) years")
                        .foregroundColor(.blue)
                    
                    LabeledContent(label: "Phone Number", value: clinic.phoneNumber)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Button(action: {
                    // Save clinic name in "session variable"
                    selectedClinicName = clinic.name
                                        
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
                    Text("This cardiology clinic is selected!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .transition(.opacity)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Clinic Details")
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
