//
//  AuthManager.swift
//  WillowMac
//
//  Created by Lawrence Liu on 2/3/25.
//

import Foundation
import Supabase

struct AppUser {
    let uid: String
    let email: String?
}


class AuthManager {
    
    static let shared = AuthManager()
    
    private init () {}
    
    let client = SupabaseClient(
        supabaseURL: URL(string: "https://drkohhnnbymispsbhqtr.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRya29oaG5uYnltaXNwc2JocXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzY5MjEsImV4cCI6MjA1MzQ1MjkyMX0.hkhLtzMMQTAGWQpXoUDRPCkVhwGzQnSV6ZOHqJnKJDs"
    )
    
    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        print(session)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
}
