//
//  Specialty.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//

import Foundation


struct Specialty: Identifiable {
    let id = UUID()
    let name: String
    let systemImage: String
}

let specialties: [Specialty] = [
    Specialty(name: "Primary Care", systemImage: "stethoscope"),
    Specialty(name: "Specialist", systemImage: "person.3"),
    Specialty(name: "Hospital", systemImage: "cross.case"),
    Specialty(name: "Urgent Care", systemImage: "mappin.and.ellipse"),
    Specialty(name: "Pharmacy", systemImage: "pills"),
    Specialty(name: "Cardiology", systemImage: "heart.fill"),
    Specialty(name: "Dermatology", systemImage: "bandage.fill"),
    Specialty(name: "Urology", systemImage: "drop.fill"),
    Specialty(name: "Psychiatry", systemImage: "brain.head.profile"),
    Specialty(name: "Neurology", systemImage: "bolt.fill"),
    Specialty(name: "Orthopedics", systemImage: "figure.walk"),
    Specialty(name: "Pediatrics", systemImage: "person.2.fill"),
    Specialty(name: "Ophthalmology", systemImage: "eye.fill")
]
