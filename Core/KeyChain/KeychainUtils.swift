//
//  KeychainUtils.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation
import Security

class KeychainUtils {

    static func save(_ key: String, _ stringData: String, service: KeychainService) -> Bool {
        guard let data = stringData.data(using: .utf8) else {
            debugPrint("[Application] Invalid data to save on keychain")
            return false
        }

        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecAttrService as String : service.name,
            kSecValueData as String : data]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        // LOG
        if status != noErr {
            debugPrint("[Application] Save data on keychain error.")
        }

        return status == noErr
    }

    static func load(_ key: String, service: KeychainService) -> String? {
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecAttrService as String : service.name,
            kSecReturnData as String : kCFBooleanTrue!,
            kSecMatchLimit as String : kSecMatchLimitOne]

        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard let data = dataTypeRef as? Data, status == noErr else {
            debugPrint("[Application] Keychain data not found")
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }

    static func delete(_ key: String, service: KeychainService) -> Bool {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecAttrService as String : service.name,
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}
