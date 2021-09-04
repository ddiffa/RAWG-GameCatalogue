//
//  ProfileUseCase.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

protocol ProfileUseCase {
    func execute(completion: @escaping (Profile?) -> Void)
    func save(profile: Profile, completion: @escaping () -> Void) 
}

final class DefaultProfileUseCase: ProfileUseCase {
    private let profileRepository: ProfileRepository
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func execute(completion: @escaping (Profile?) -> Void) {
        return profileRepository.fetch(completion: completion)
    }
    
    func save(profile: Profile, completion: @escaping () -> Void) {
        return profileRepository.save(profile: profile,
                                      completion: completion)
    }
}
