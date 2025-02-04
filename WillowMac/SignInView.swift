//
//  SignInView.swift
//  WillowMac
//
//  Created by Lawrence Liu on 2/3/25.
//

import Foundation
import SwiftUI



struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        Button {
            Task {
                do {
                    let appUser = try await viewModel.signInWithGoogle()
                    self.appUser = appUser
                } catch {
                    print("Error signing in")
                }
            }
            
        } label: {
            Text("Sign in with Google.")
        }
    }
}
