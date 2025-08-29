//
//  AvatarView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//


import SwiftUI

struct AvatarView: View {
    var initials: String
    var body: some View {
        ZStack {
            Circle().fill(Color.gray.opacity(0.2))
            Text(initials)
                .font(.headline).foregroundColor(.primary)
        }
        .frame(width: 34, height: 34)
        .overlay(Circle().stroke(Color.gray.opacity(0.4)))
        .accessibilityLabel("Account Menu")
    }
}

struct BannerView: View {
    var text: String
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.seal.fill")
            Text(text).fontWeight(.semibold)
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.green.opacity(0.15))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.green.opacity(0.4)))
        )
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
