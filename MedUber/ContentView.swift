//
//  ContentView.swift
//  MedUber
//
//  Created by Ravi Dayani on 8/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = AppSession()
    @AppStorage("hasSignedUp") private var hasSignedUp: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Group {
                    if session.isLoggedIn {
                        ShellView()
                    } else {
                        AuthSwitcherView(startWithLogin: hasSignedUp)
                    }
                }
                .environmentObject(session)
                
                if session.showBanner {
                    BannerView(text: session.bannerMessage)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                }
            }
            .onAppear {
                session.bootstrap() // restore Firebase user if logged in
            }
        }
    }
}

// MARK: - Shell with avatar menu
struct ShellView: View {
    @EnvironmentObject var session: AppSession
    
    var body: some View {
        Group {
            switch session.destination {
            case .dashboard:
                DashboardView()
            case .search:
                DoctorSearchView()
            }
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("MedUber")
                    .font(.title2.bold())
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        session.destination = .dashboard
                    } label: {
                        Label("Dashboard", systemImage: "rectangle.grid.2x2")
                    }
                    Button {
                        session.destination = .search
                    } label: {
                        Label("Find Doctors", systemImage: "stethoscope")
                    }
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                    Divider()
                    Button(role: .destructive) {
                        session.logout()
                    } label: {
                        Label("Logout", systemImage: "arrow.backward.square")
                    }
                } label: {
                    AvatarView(initials: initials(for: session.user))
                }
            }
        }
    }
    
    private func initials(for user: User) -> String {
        let f = user.firstName.first.map(String.init) ?? ""
        let l = user.lastName.first.map(String.init) ?? ""
        return (f + l).isEmpty ? "👤" : (f + l)
    }
}


struct AuthSwitcherView: View {
    @State private var showLogin: Bool
    @AppStorage("hasSignedUp") private var hasSignedUp: Bool = false

    init(startWithLogin: Bool) {
        _showLogin = State(initialValue: startWithLogin)
    }
    
    var body: some View {
        VStack {
            if showLogin {
                LoginView(onSwitch: { withAnimation { showLogin = false; hasSignedUp = false } })
            } else {
                SignupView(onSwitch: { withAnimation { showLogin = true; hasSignedUp = true } })
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
