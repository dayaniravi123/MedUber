//
//  PharmacySearchView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/28/25.
//


import Foundation
import SwiftUI
import SwiftUICore



// This is the data model for a single Pharmacy.
// It includes properties to hold all the information seen in the image.
struct Pharmacy: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let specialties: [String]
    let phoneNumber: String
    let plansAccepted: Int
}

// This is a mock array of pharmacy data based on the provided image.
let mockPharmacies = [
    Pharmacy(name: "RITE AID PHARMACY 03194 0", location: "5447 MAIN STREET, WILLIAMSVILLE, NY 14221", specialties: ["Community/Retail Pharmacy", "Pharmacy"], phoneNumber: "(716) 632-8608", plansAccepted: 39),
    Pharmacy(name: "CVS Pharmacy", location: "8700 Main St, Clarence, NY 14031", specialties: ["Retail Pharmacy"], phoneNumber: "(716) 759-8321", plansAccepted: 52),
    Pharmacy(name: "Walgreens Pharmacy", location: "3510 Sheridan Dr, Amherst, NY 14226", specialties: ["Retail Pharmacy"], phoneNumber: "(716) 835-2345", plansAccepted: 48),
    Pharmacy(name: "Wegmans Pharmacy", location: "675 Alberta Dr, Amherst, NY 14226", specialties: ["Supermarket Pharmacy"], phoneNumber: "(716) 839-4400", plansAccepted: 61),
    Pharmacy(name: "Kinney Drugs", location: "9500 Transit Rd, East Amherst, NY 14051", specialties: ["Community Pharmacy"], phoneNumber: "(716) 639-0820", plansAccepted: 35),
    Pharmacy(name: "Walmart Pharmacy", location: "10000 McKinley Pkwy, Hamburg, NY 14075", specialties: ["Retail Pharmacy"], phoneNumber: "(716) 646-1234", plansAccepted: 55),
    Pharmacy(name: "Target Pharmacy", location: "1560 Niagara Falls Blvd, Amherst, NY 14228", specialties: ["Retail Pharmacy"], phoneNumber: "(716) 564-9876", plansAccepted: 42),
    Pharmacy(name: "Erie County Medical Center Pharmacy", location: "462 Grider St, Buffalo, NY 14215", specialties: ["Hospital Pharmacy", "Outpatient Pharmacy"], phoneNumber: "(716) 898-3000", plansAccepted: 28),
    Pharmacy(name: "Mercy Hospital Pharmacy", location: "5650 S Park Ave, Buffalo, NY 14224", specialties: ["Hospital Pharmacy"], phoneNumber: "(716) 825-8353", plansAccepted: 30),
    Pharmacy(name: "Southgate Plaza Pharmacy", location: "1049 Union Rd, West Seneca, NY 14224", specialties: ["Independent Pharmacy"], phoneNumber: "(716) 674-3456", plansAccepted: 25)
]


// MARK: - PharmacySearchView

// This view shows a searchable list of pharmacies.
struct PharmacySearchView: View {
    let pharmacies: [Pharmacy]
    
    var body: some View {
        VStack {
            // A simple list to display the pharmacies.
            List(pharmacies) { pharmacy in
                // NavigationLink to the PharmacyDetailView when a pharmacy is tapped.
                NavigationLink(destination: PharmacyDetailView(pharmacy: pharmacy)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(pharmacy.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(pharmacy.location)
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
            .navigationTitle("Pharmacies")
            .listStyle(.plain)
        }
    }
}


// MARK: - PharmacyDetailView

// This view displays the detailed information for a single pharmacy.
struct PharmacyDetailView: View {
    let pharmacy: Pharmacy
    // State variable to control the confirmation message
    @State private var showConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Pharmacy's name
                Text(pharmacy.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Main details section
                VStack(alignment: .leading, spacing: 10) {
                    Text(pharmacy.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    // Displaying specialties, plans accepted, etc.
                    LabeledContent(label: "Specialties", value: pharmacy.specialties.joined(separator: ", "))
                    
                    LabeledContent(label: "Plans Accepted", value: "\(pharmacy.plansAccepted) plans accepted")
                        .foregroundColor(.blue)
                    
                    LabeledContent(label: "Phone Number", value: pharmacy.phoneNumber)
                    
                    // Add other information from your data model here
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Conditional button and message
                Button(action: {
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
                
                // Conditional confirmation message
                if showConfirmation {
                    Text("This pharmacy is selected!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .transition(.opacity)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Pharmacy Details")
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
