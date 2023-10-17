//
//  UserdefaultHelper.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/27.
//

import Foundation

class UserDefaultHelper { // PropertyWrapper
    
    static let standard = UserDefaultHelper() // 싱글턴 패턴
    
    private init() { } // 접근 제어자 (담주에 함)
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String { // 컴파일 최적화
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            return userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
