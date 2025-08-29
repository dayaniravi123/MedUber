//
//  UrgentCareSearchView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/28/25.
//

import Foundation
import SwiftUI

// MARK: - UrgentCare Model
struct UrgentCare: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let services: [String]
    let phoneNumber: String
    let waitTime: String   // Example: average wait time
}

// MARK: - Mock Data
let mockUrgentCares = [
    UrgentCare(name: "WellNow Urgent Care", location: "3925 Sheridan Dr, Amherst, NY 14226", services: ["Injury Treatment", "Illness Care", "COVID-19 Testing"], phoneNumber: "(716) 836-5437", waitTime: "15 min"),
    UrgentCare(name: "Concentra Urgent Care", location: "255 Aero Dr, Cheektowaga, NY 14225", services: ["Physical Exams", "Occupational Health", "Injury Care"], phoneNumber: "(716) 634-0380", waitTime: "20 min"),
    UrgentCare(name: "Immediate Care Center", location: "2497 Delaware Ave, Buffalo, NY 14216", services: ["General Illness", "X-Rays", "Lab Testing"], phoneNumber: "(716) 447-6500", waitTime: "10 min"),
    UrgentCare(name: "MASH Urgent Care", location: "3980 Sheridan Dr, Amherst, NY 14226", services: ["Pediatric Care", "Infections", "Allergies"], phoneNumber: "(716) 250-9999", waitTime: "25 min"),
    UrgentCare(name: "UBMD Urgent Care", location: "77 Goodell St, Buffalo, NY 14203", services: ["Adult & Pediatric Care", "Diagnostics"], phoneNumber: "(716) 932-7777", waitTime: "30 min")
]

// MARK: - UrgentCareSearchView
struct UrgentCareSearchView: View {
    let urgentCares: [UrgentCare]
    
    var body: some View {
        VStack {
            List(urgentCares) { urgentCare in
                NavigationLink(destination: UrgentCareDetailView(urgentCare: urgentCare)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(urgentCare.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(urgentCare.location)
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
            .navigationTitle("Urgent Care")
            .listStyle(.plain)
        }
    }
}

// MARK: - UrgentCareDetailView
struct UrgentCareDetailView: View {
    let urgentCare: UrgentCare
    @State private var showConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(urgentCare.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(urgentCare.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    LabeledContent(label: "Services", value: urgentCare.services.joined(separator: ", "))
                    
                    LabeledContent(label: "Average Wait Time", value: urgentCare.waitTime)
                        .foregroundColor(.blue)
                    
                    LabeledContent(label: "Phone Number", value: urgentCare.phoneNumber)
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
                    Text("This urgent care center is selected!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .transition(.opacity)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Urgent Care Details")
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
