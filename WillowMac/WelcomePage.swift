import SwiftUI
import AppKit
import GoogleSignIn
import GoogleSignInSwift
import Supabase
import AuthenticationServices
import os

struct WelcomePage: View {
    @EnvironmentObject var authState: AuthState
    @State private var errorMessage: String? = nil
    
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
                VStack(spacing: 16) {
                    Button("Log in") {
                        Task {
                            await handleGoogle()
                        }
                    }
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
        }
    }
    
}




