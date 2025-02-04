import SwiftUI
import Supabase

class AuthState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User?
    @Published var userInfo: UserInfo?
    
    struct UserInfo {
        let email: String?
        let name: String?
        let avatarUrl: String?
    }
    
    init() {
        Task {
            for await (event, session) in supabase.auth.authStateChanges {
                await MainActor.run {
                    self.isAuthenticated = session != nil
                    self.user = session?.user
                    
                    if let user = session?.user {
                        self.userInfo = UserInfo(
                            email: user.email,
                            name: user.userMetadata["full_name"] as? String,
                            avatarUrl: user.userMetadata["avatar_url"] as? String
                        )
                    }
                }
            }
        }
    }
} 
