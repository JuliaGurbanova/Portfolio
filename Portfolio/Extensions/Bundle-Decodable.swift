//
//  Bundle-Decodable.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 20.09.2023.
//

import Foundation

extension Bundle {
    /// An extension on the Bundle class to simplify the decoding of JSON data from a file
    /// within the app's bundle and convert it into a Swift object that conforms to Decodable.
    ///
    /// If the file cannot be located in the app's bundle or if there are issues loading or decoding the data,
    /// this function will trigger a fatal error with a descriptive error message.
    /// - Parameters:
    ///   - file: The name of the JSON file to be decoded.
    ///   - type: The type to which the JSON data should be decoded.
    ///
    ///   It has a default value of T.self, which allows Swift to infer the type.
    ///   - dateDecodingStrategy: An optional parameter specifying the strategy for decoding dates from JSON.
    ///   - keyDecodingStrategy: An optional parameter specifying the strategy for decoding keys from JSON.
    /// - Returns: An instance of the specified type, decoded from the JSON file.
    func decode<T: Decodable>(
        _ file: String,
        as type: T.Type = T.self,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file): missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file): type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file): missing \(type) value - \(context.debugDescription))")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file): invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
