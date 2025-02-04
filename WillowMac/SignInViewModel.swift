//
//  SignInViewModel.swift
//  WillowMac
//
//  Created by Lawrence Liu on 2/3/25.
//

import Foundation
import SwiftUI
import GoogleSignIn

class SignInViewModel: ObservableObject {
    
    func signInWithGoogle() {
        guard let window = NSApplication.shared.mainWindow else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: window) { signInResult, error in
            guard let result = signInResult else {
                return
            }
            
        }
    }
    
    
}


