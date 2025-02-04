import Foundation
import Supabase
import Auth
import os.log

struct AppLogger: SupabaseLogger {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "supabase")
    
    func log(message: SupabaseLogMessage) {
        // Make the message public by using %{public}@
        let publicMessage = "\(message.level): \(message.description)"
        
        switch message.level {
        case .verbose:
            logger.log(level: .info, "\(publicMessage, privacy: .public)")
        case .debug:
            logger.log(level: .debug, "\(publicMessage, privacy: .public)")
        case .warning, .error:
            logger.log(level: .error, "\(publicMessage, privacy: .public)")
        }
    }
}

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://drkohhnnbymispsbhqtr.supabase.co")!,
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRya29oaG5uYnltaXNwc2JocXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzY5MjEsImV4cCI6MjA1MzQ1MjkyMX0.hkhLtzMMQTAGWQpXoUDRPCkVhwGzQnSV6ZOHqJnKJDs",
    options: .init(
        auth: .init(
            storage: KeychainLocalStorage(
                accessGroup: "B9LTMN6KAW.com.seewillow.WillowMac")
        ),
        global: .init(
            logger: AppLogger()
        )
    )
)


// let supabase = SupabaseClient(
//   supabaseURL: URL(string: "https://drkohhnnbymispsbhqtr.supabase.co")!,
//   supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRya29oaG5uYnltaXNwc2JocXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzY5MjEsImV4cCI6MjA1MzQ1MjkyMX0.hkhLtzMMQTAGWQpXoUDRPCkVhwGzQnSV6ZOHqJnKJDs",
//   options: SupabaseClientOptions(
//     auth: .init(
//         storage: SecureStorage(),
//         flowType: .implicit
//     )
//   )
// )

/* This is the option of keyChain local storage
 let supabase = SupabaseClient(
 supabaseURL: URL(string: "https://drkohhnnbymispsbhqtr.supabase.co")!,
 supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRya29oaG5uYnltaXNwc2JocXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzY5MjEsImV4cCI6MjA1MzQ1MjkyMX0.hkhLtzMMQTAGWQpXoUDRPCkVhwGzQnSV6ZOHqJnKJDs",
 options: SupabaseClientOptions(
 auth: .init(
 storage: KeychainLocalStorage(
 accessGroup: "B9LTMN6KAW.com.seewillow.WillowMac"
 )
 )
 )
 )
 */
