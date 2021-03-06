//
//  UsesUserDefault.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 01.10.21.
//

import Foundation

protocol UsesUserDefault {
    func getUserDefaultValue(for key: String) -> [String: Any]?
    func saveUserDefaultValue(_ value: Any, for key: String)
}

extension UsesUserDefault {
    func getUserDefaultValue(for key: String) -> [String: Any]? {
        return UserDefaults.standard.value(forKey: key) as? [String: Any]
    }
    
    func saveUserDefaultValue(_ value: Any, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
