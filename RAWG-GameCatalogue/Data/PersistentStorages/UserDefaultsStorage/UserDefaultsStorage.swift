//
//  UserDefaultsStorage.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

enum UserDefaultsDataKey: String {
    case profileImage = "profile_image"
    case fullName = "full_name"
    case jobTitle = "job_title"
}

enum UserDefaultsKey: String {
    case profile = "profile_key"
}

final class UserDefaultsStorage {
    static let shared = UserDefaultsStorage()
    
    private let userDefaults = UserDefaults.standard
    
    func loadKey(key: UserDefaultsKey) -> Profile? {
        let dict = userDefaults.dictionary(forKey: key.rawValue)
        if let profileImage = dict?[UserDefaultsDataKey.profileImage.rawValue] as? Data,
           let jobTitle = dict?[UserDefaultsDataKey.jobTitle.rawValue] as? String,
           let fullName = dict?[UserDefaultsDataKey.fullName.rawValue] as? String {

            return .init(profileImage: profileImage,
                         jobTitle: jobTitle,
                         fullName: fullName)
        }
        return nil
    }
    
    func save(key: UserDefaultsKey, data: [String : Any?]) {
        userDefaults.setValue(data, forKey: key.rawValue)
    }

}
