//
//  DashboardView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//


import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var session: AppSession
    @State private var showCardsSheet = false
    @AppStorage("selectedClinicName") var selectedClinicName: String = ""
    @AppStorage("selectedDoctorName") var selectedDoctorName: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header: Name + effective date + member count
                header
                
                // Plan details card
                planDetailsCard
                
                // ID Cards section
                idCardsSection
            }
            .padding()
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) { EmptyView() }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(session.user.firstName.isEmpty ? "Your Account" : session.user.firstName)
                .font(.system(size: 36, weight: .bold))
            HStack(spacing: 8) {
                Text("Your plan is effective")
                Text(session.user.planEffective, style: .date)
                    .fontWeight(.semibold)
                Text("for")
                Label("1 member", systemImage: "person")
                    .labelStyle(.titleAndIcon)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.secondary)
        }
    }
    
    private var planDetailsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            LabeledRow(title: "PLAN TYPE", value: session.user.planType)
            Divider()
            LabeledRow(title: "MEMBER ID", value: session.user.memberID)
            Divider()
            LabeledRow(title: "GROUP ID", value: session.user.groupID)
            Divider()
            LabeledRow(title: "Primarycare Physician", value: selectedDoctorName)
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.systemBackground)))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.2)))
        .shadow(radius: 1)
    }
    
    private var idCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("ID Cards", systemImage: "creditcard")
                    .font(.title3.bold())
                Spacer()
                Button("View ID Cards") { showCardsSheet = true }
            }
            
            Text("Misplaced your ID Card? Print out your card or place an order for a free replacement!")
                .foregroundStyle(.secondary)
            
            HStack(spacing: 12) {
                Button {
                    session.showSuccess("Printing card…")
                } label: {
                    Text("Print")
                        .frame(maxWidth: .infinity).padding()
                        .background(Color.red.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.red))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button {
                    session.showSuccess("Replacement order placed")
                } label: {
                    Text("Order Cards")
                        .frame(maxWidth: .infinity).padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            // Thumbnail (use your asset if available)
            Image(uiImage: UIImage(named: "idcard-thumb") ?? placeholderCard())
                .resizable().scaledToFit()
                .frame(maxWidth: 280)
                .cornerRadius(10)
                .shadow(radius: 2)
        }
        .sheet(isPresented: $showCardsSheet) {
            NavigationStack {
                VStack(spacing: 20) {
                    Image(uiImage: UIImage(named: "idcard-thumb") ?? placeholderCard())
                        .resizable().scaledToFit().padding()
                    Text("Member: \(session.user.firstName.isEmpty ? "Member" : session.user.firstName)")
                    Text("ID: \(session.user.memberID)")
                    Spacer()
                }
                .padding()
                .navigationTitle("Your ID Card")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) { Button("Done") { showCardsSheet = false } }
                }
            }
        }
    }
    
    // simple placeholder if you don’t add an asset
    private func placeholderCard() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: .init(width: 520, height: 330))
        return renderer.image { ctx in
            UIColor.systemGray6.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 520, height: 330))
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24, weight: .semibold),
                .foregroundColor: UIColor.gray
            ]
            let str = NSString(string: "ID Card Preview")
            str.draw(at: CGPoint(x: 150, y: 150), withAttributes: attrs)
        }
    }
}

private struct LabeledRow: View {
    var title: String
    var value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.title3)
        }
    }
}
