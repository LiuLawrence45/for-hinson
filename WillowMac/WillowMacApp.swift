import SwiftUI
//import PostHog
import GoogleSignIn

@main
struct WillowMacApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }   
}
