//
//  ProfileRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

protocol ProfileRepository {
    func fetch(completion: @escaping (Profile?) -> Void)
    func save(profile: Profile, completion: @escaping () -> Void) 
}
