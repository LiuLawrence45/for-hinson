import SwiftUI
import AppKit
import GoogleSignIn
import GoogleSignInSwift
import Supabase
import AuthenticationServices
import os

struct WelcomePage: View {
    @EnvironmentObject var authState: AuthState
    
    var body: some View {
        VStack {
            if authState.isAuthenticated {
                VStack(spacing: 10) {
                    if let userInfo = authState.userInfo {
                        Text("Welcome, \(userInfo.name ?? "User")!")
                        Text(userInfo.email ?? "")
                        
                        if let avatarUrl = userInfo.avatarUrl {
                            AsyncImage(url: URL(string: avatarUrl)) { image in
                                image.resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Button("Sign Out") {
                        Task {
                            try? await supabase.auth.signOut()
                        }
                    }
                }
            } else {
                Button("Log in") {
                    Task {
                        await handleGoogle()
                    }
                }
            }
        }
    }
    
    private func handleGoogle() async {
        guard let window = NSApplication.shared.mainWindow else { return }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: window)
            guard let idToken = result.user.idToken?.tokenString else {
                print("No idToken found.")
                return
            }
            print("idToken from Google is: ", idToken)
            let accessToken = result.user.accessToken.tokenString
            
            try await supabase.auth.signInWithIdToken(
                credentials: OpenIDConnectCredentials(
                    provider: .google,
                    idToken: idToken,
                    accessToken: accessToken
                )
            )
        } catch {
            print("Sign in error: \(error.localizedDescription)")
        }
    }
}



