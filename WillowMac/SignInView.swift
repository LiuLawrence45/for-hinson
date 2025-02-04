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
            
            viewModel.signInWithGoogle()
            
        } label: {
            Text("Sign in with Google.")
        }
    }
}
