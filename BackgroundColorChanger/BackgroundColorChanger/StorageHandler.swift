//
//  StorageHandler.swift
//  ClassConstraints
//
//  Created by Christopher Boyd on 10/14/20.
//

import Foundation

struct StorageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    static let defaultKey = "ColorCollection"
    
    static func getStorage() {
        if isSet(key: self.defaultKey) {
            let encodedString = UserDefaults.standard.dictionaryRepresentation()[self.defaultKey] as! String
            
            ColorManager.colorCollection = decodeCollection(encodedString.data(using: .utf8)!)
        }
    }
    
    static func isSet(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func set(value: Color) {
        ColorManager.colorCollection.append(value)
        
        defaultStorage.set(encodeCollection(), forKey: self.defaultKey)
    }
    
    static func encodeCollection() -> String {
        // Our JSON Encoder
        let encoder = JSONEncoder()
        
        /**
         * We attempt to encode the Color array that is part of ColorManager
         * If this fails in any way, we simply return an empty string to be stored
         * Otherwise, we then convert that encoded JSON data to a string and return that
         */
        guard let encoded = try? encoder.encode(ColorManager.colorCollection)
        else{
            return ""
        }
        print(storageCount())
        //If encoded succeeded, we convert the JSON to a simple string and return that
        guard let stringEncoded = String(data: encoded, encoding: .utf8)
        else {
            return ""
        }
        return stringEncoded
    }
    
    static func decodeCollection(_ encodedString: Data) -> [Color] {
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode([Color].self, from: encodedString)
        else {
            let newColorCollection: [Color] = []
            return newColorCollection
        }
        
        return decoded
    }

    static func storageCount() -> Int {
        return ColorManager.colorCollection.count
    }
}

