import Foundation
import Supabase
import Auth


let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://drkohhnnbymispsbhqtr.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRya29oaG5uYnltaXNwc2JocXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzY5MjEsImV4cCI6MjA1MzQ1MjkyMX0.hkhLtzMMQTAGWQpXoUDRPCkVhwGzQnSV6ZOHqJnKJDs"
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
