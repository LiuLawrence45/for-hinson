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

//extension OSStatus {
//    static func setKeychainAccessControl() {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrService as String: "supabase.gotrue.swift",
//            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
//            kSecAttrAccessControl as String: SecAccessControlCreateWithFlags(
//                nil,
//                kSecAttrAccessibleAfterFirstUnlock,
//                .init(),
//                nil
//            )
//        ]
//        
//        // Update the keychain item's access control
//        SecItemUpdate(query as CFDictionary, [
//            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
//        ] as CFDictionary)
//    }
//}
