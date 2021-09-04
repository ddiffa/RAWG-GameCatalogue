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
    
    init(userDefaults: UserDefaultsStorage) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsProfileStorage: ProfileStorage {
    func fetchProfileData(completion: @escaping (Result<Profile, Error>) -> Void) {
        let profile = userDefaults.loadKey(key: .profile)
        
        guard let profile = profile else {
            let error = NSError(domain: "id.hellodiffa",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "Could not fetch data"])
            completion(
                .failure(UserDefaultsStorageError.readError(error)))
            return
        }
        
        completion(.success(profile))
    }
    
    func replaceProfileData(profile: Profile, completion: @escaping () -> Void) {
        userDefaults.save(key: .profile,
                          data: profile.toDictionary())
        completion()
    }
}
