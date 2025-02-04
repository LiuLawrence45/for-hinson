import SwiftUI
import Supabase
import os

class AuthState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User?
    @Published var userInfo: UserInfo?
    private let logger = Logger(subsystem: "com.seewillow.WillowMac", category: "AuthState")
    
    struct UserInfo {
        let email: String?
        let name: String?
        let avatarUrl: String?
    }
    
    init() {
        print("Bundle ID:", Bundle.main.bundleIdentifier ?? "nil")
        
        logger.debug("[DEBUG] AuthState: Initializing")
        Task {
            logger.debug("[DEBUG] AuthState: Starting auth state monitoring")
            for await (event, session) in supabase.auth.authStateChanges {
                logger.debug("[DEBUG] AuthState: Auth state changed - Event: \(event.rawValue)")
                logger.debug("[DEBUG] AuthState: Session exists: \(session != nil)")
                
                if let session = session {
                    logger.debug("[DEBUG] AuthState: User ID: \(session.user.id)")
                    logger.debug("[DEBUG] AuthState: User Email: \(session.user.email ?? "no email")")
                    logger.debug("[DEBUG] AuthState: Access Token: \(session.accessToken.prefix(10))...")
                    logger.debug("[DEBUG] AuthState: Refresh Token exists: \(session.refreshToken != nil)")
                }
                
                await MainActor.run {
                    logger.debug("[DEBUG] AuthState: Updating published properties")
                    self.isAuthenticated = session != nil
                    self.user = session?.user
                    
                    if let user = session?.user {
                        logger.debug("[DEBUG] AuthState: Processing user metadata")
                        logger.debug("[DEBUG] AuthState: Full metadata: \(user.userMetadata)")
                        
                        self.userInfo = UserInfo(
                            email: user.email,
                            name: user.userMetadata["full_name"] as? String,
                            avatarUrl: user.userMetadata["avatar_url"] as? String
                        )
                        
                        logger.debug("[DEBUG] AuthState: UserInfo created - Name: \(self.userInfo?.name ?? "nil")")
                        logger.debug("[DEBUG] AuthState: UserInfo created - Email: \(self.userInfo?.email ?? "nil")")
                        logger.debug("[DEBUG] AuthState: UserInfo created - Avatar: \(self.userInfo?.avatarUrl ?? "nil")")
                    } else {
                        logger.debug("[DEBUG] AuthState: No user in session")
                        self.userInfo = nil
                    }
                }
            }
        }
        logger.debug("[DEBUG] AuthState: Initialization complete")
    }
} 
