//
//  DefaultProfileRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

final class DefaultProfileRepository {
    private let userDefaultsProfileStorage: UserDefaultsProfileStorage
    
    init(userDefaultsProfileStorage: UserDefaultsProfileStorage) {
        self.userDefaultsProfileStorage = userDefaultsProfileStorage
    }
}

extension DefaultProfileRepository: ProfileRepository {
    func fetch(completion: @escaping (Profile?) -> Void) {
        userDefaultsProfileStorage.fetchProfileData(completion: completion)
    }
    
    func save(profile: Profile, completion: @escaping () -> Void) {
        userDefaultsProfileStorage.replaceProfileData(profile: profile,
                                                      completion: completion)
    }
}
