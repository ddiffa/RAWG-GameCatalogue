//
//  UserDefaultsProfileStorage.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation
import CoreData

final class UserDefaultsProfileStorage {
    private let userDefaults: UserDefaultsStorage
    
    init(userDefaults: UserDefaultsStorage = UserDefaultsStorage.shared) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsProfileStorage: ProfileStorage {
    func fetchProfileData(completion: @escaping (Profile?) -> Void) {
        let profile = userDefaults.loadKey(key: .profile)
        
        guard let profile = profile else {
            completion(nil)
            return
        }
        completion(profile)
    }
    
    func replaceProfileData(profile: Profile, completion: @escaping () -> Void) {
        userDefaults.save(key: .profile,
                          data: profile.toDictionary())
        completion()
    }
}
