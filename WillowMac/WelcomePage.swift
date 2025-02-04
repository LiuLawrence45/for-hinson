import SwiftUI
import AppKit
import GoogleSignIn
import GoogleSignInSwift

struct ContentView: View {
    
    @State var appUser: AppUser? = nil
    
    
    var body: some View {
        
        ZStack {
            if let appUser = appUser {
                
                HomeView(appUser: appUser)
                
            } else {
                SignInView(appUser: $appUser)
            }
        }
    }
    
}
