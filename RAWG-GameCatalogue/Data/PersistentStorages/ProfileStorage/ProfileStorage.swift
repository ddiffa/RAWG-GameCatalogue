//
//  ProfileStorage.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

protocol ProfileStorage {
    func fetchProfileData(completion: @escaping(Profile?) -> Void)
    func replaceProfileData(profile: Profile,
                            completion: @escaping() -> Void)
}
