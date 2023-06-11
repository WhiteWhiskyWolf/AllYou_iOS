//
//  RepositoryUtils.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-11.
//

import Foundation
import os

struct RepositoryUtils {
    private static let logger = Logger(subsystem: "RepositoryUtils", category: "background")
    
    static func decodeObject<T: Codable>(_ type: T.Type, data: [String: Any]) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970
            
            return try decoder.decode(T.self, from: jsonData)
        } catch {
            logger.error("Unable to decode object: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func encodeObject<T: Codable>(data: T) -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            let jsonData = try encoder.encode(data)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return json
        } catch {
            logger.error("Unable to encode object: \(error.localizedDescription)")
            return nil
        }
    }
}
