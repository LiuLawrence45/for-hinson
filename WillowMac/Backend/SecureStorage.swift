import Foundation
import CryptoKit
import Auth

class SecureStorage: AuthLocalStorage, @unchecked Sendable {
    private let defaults = UserDefaults.standard
    private let prefix = "encrypted_auth_"
    
    // Generate a persistent key or use a hardcoded one (store securely)
    private let encryptionKey: SymmetricKey = {
        // Use a 32-byte (256-bit) key for AES-GCM
        let keyString = "12345678901234567890123456789012" // Exactly 32 bytes
        let keyData = Data(keyString.utf8)
        print("🔐 SecureStorage: Initializing encryption key with \(keyData.count) bytes")
        return SymmetricKey(data: keyData)
    }()
    
    func store(key: String, value: Data) throws {
        let prefixedKey = prefix + key
        print("📥 SecureStorage: Storing data for key: \(key)")
        print("📦 Data size: \(value.count) bytes")
        
        do {
            let encryptedData = try encrypt(value)
            defaults.set(encryptedData, forKey: prefixedKey)
            defaults.synchronize() // Force write to disk
            print("✅ SecureStorage: Successfully stored encrypted data for key: \(key)")
            printStoredKeys() // Print keys after storing
        } catch {
            print("❌ SecureStorage: Failed to store data for key: \(key)")
            print("💥 Error: \(error)")
            throw error
        }
    }
    
    func retrieve(key: String) throws -> Data? {
        let prefixedKey = prefix + key
        print("🔍 SecureStorage: Attempting to retrieve data for key: \(key)")
        
        guard let encryptedData = defaults.data(forKey: prefixedKey) else {
            print("⚠️ SecureStorage: No data found for key: \(key)")
            return nil
        }
        
        do {
            let decryptedData = try decrypt(encryptedData)
            print("✅ SecureStorage: Successfully retrieved and decrypted data for key: \(key)")
            print("📦 Retrieved data size: \(decryptedData.count) bytes")
            
            // If it's a string, let's log it (useful for debugging)
            if let stringValue = String(data: decryptedData, encoding: .utf8) {
                print("📝 Retrieved value (if string): \(stringValue.prefix(100))...")
            }
            
            return decryptedData
        } catch {
            print("❌ SecureStorage: Failed to decrypt data for key: \(key)")
            print("💥 Error: \(error)")
            throw error
        }
    }
    
    func remove(key: String) throws {
        let prefixedKey = prefix + key
        print("🗑️ SecureStorage: Removing data for key: \(key)")
        defaults.removeObject(forKey: prefixedKey)
        print("✅ SecureStorage: Successfully removed data for key: \(key)")
    }
    
    // Helper encryption methods
    private func encrypt(_ data: Data) throws -> Data {
        print("🔒 SecureStorage: Encrypting data")
        do {
            let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
            print("✅ SecureStorage: Encryption successful")
            return sealedBox.combined!
        } catch {
            print("❌ SecureStorage: Encryption failed")
            print("💥 Error: \(error)")
            throw error
        }
    }
    
    private func decrypt(_ data: Data) throws -> Data {
        print("🔓 SecureStorage: Decrypting data")
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: encryptionKey)
            print("✅ SecureStorage: Decryption successful")
            return decryptedData
        } catch {
            print("❌ SecureStorage: Decryption failed")
            print("💥 Error: \(error)")
            throw error
        }
    }
    
    // Add a debug method to list all stored keys
    func printStoredKeys() {
        print("📋 SecureStorage: Currently stored keys:")
        let allKeys = defaults.dictionaryRepresentation().keys
        let authKeys = allKeys.filter { $0.hasPrefix(prefix) }
        authKeys.forEach { key in
            print("   🔑 \(key.replacingOccurrences(of: prefix, with: ""))")
        }
    }
}
