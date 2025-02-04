import SwiftUI
//import PostHog
import GoogleSignIn

@main
struct WillowMacApp: App {

//    init() {
//        OSStatus.setKeychainAccessControl()
//    }

    @StateObject private var authState = AuthState()
    
    var body: some Scene {
        WindowGroup {
            WelcomePage()
                .environmentObject(authState)
        }
    }   
}
