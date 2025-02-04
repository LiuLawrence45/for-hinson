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
    
    func signInWithGoogle() async throws -> AppUser {
        let signInGoogle = SignInGoogle()
        let googleResult = try await signInGoogle.startSignInWithGoogleFlow()
        return try await AuthManager.shared.signInWithGoogle(idToken: googleResult.idToken)
        
    }
    
    
}

struct SignInGoogleResult { 
    let idToken: String
}


class SignInGoogle {
    
    
    func startSignInWithGoogleFlow() async throws -> SignInGoogleResult {
        try await withCheckedThrowingContinuation({ [weak self] continuation in
            self?.signInWithGoogleFlow { result in
                continuation.resume(with: result)
            }
        })
    }
    

    // Apparently this works with Google's callback-based SDK. So our code would just get really messy with nested callbacks. The Async wrapper makes it a lot easier to use (which is the startSignInWithGoogleFlow)
    func signInWithGoogleFlow (completion: @escaping (Result<SignInGoogleResult, Error>) -> Void) {
        guard let topVC = NSApplication.shared.mainWindow else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { signInResult, error in
            guard let user = signInResult?.user, let idToken = user.idToken else {
                completion(.failure(NSError()))
                return
            }

            completion(.success(.init(idToken: idToken.tokenString)))
            
//            From sign in succeeded, display app main content
            
        }
    }
    
}
