//
//  DoctorSearchView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//

import SwiftUICore
import SwiftUI


struct DoctorSearchView: View {
    @State private var navigateToResults = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Button(action: {
                navigateToResults = true
            }) {
                Text("Search Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.pink)
                    .cornerRadius(10)
            }
            
            Text("Need to add or change your Primary Care Physician? ")
                .font(.subheadline) +
            Text("Manage My Doctors")
                .bold()
            
            Text("POPULAR SEARCHES")
                .font(.headline)
                .padding(.top, 20)
            
            // Grid of specialties
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 20) {
                NavigationLink(destination: DoctorNameSearchView(doctors: mockDoctors)) {
                    VStack {
                        Image(systemName: "stethoscope")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        Text("Primary Care")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                NavigationLink(destination: SpecialistListView()) {
                    VStack {
                        Image(systemName: "person.3")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        Text("Specialist")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                NavigationLink(destination: HospitalSearchView(hospitals: mockHospitals)) {
                    VStack {
                        Image(systemName: "cross.case")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        Text("Hospital")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                NavigationLink(destination: UrgentCareSearchView(urgentCares: mockUrgentCares)){
                    VStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        Text("Urgent Care")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                NavigationLink(destination: PharmacySearchView(pharmacies: mockPharmacies)) {
                    VStack {
                        Image(systemName: "pills")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        Text("Pharmacy")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                NavigationLink(destination: CardiologySearchView(clinics: mockCardiologyClinics)){
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        Text("Cardiology")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            NavigationLink(destination: DoctorResultsView(userName: "Ravi"),
                           isActive: $navigateToResults) {
                EmptyView()
            }
        }
        .padding()
    }
}
