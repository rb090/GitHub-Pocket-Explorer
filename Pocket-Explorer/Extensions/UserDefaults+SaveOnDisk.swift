//
//  UserDefaults+SaveOnDisk.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 10.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func save<T: Codable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        guard let encodedObject = try? encoder.encode(object) else { return }
        
        UserDefaults.standard.set(encodedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getObject<T: Codable>(forKey key: String) -> T? {
        guard let object = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: object)
    }
}
