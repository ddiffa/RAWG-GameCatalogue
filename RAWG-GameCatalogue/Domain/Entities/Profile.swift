//
//  ProfileEntity+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

struct Profile {
    var profileImage: Data
    var jobTitle: String
    var fullName: String
}

extension Profile {
    func toDictionary() -> [String : Any] {
        return [
            UserDefaultsDataKey.profileImage.rawValue: profileImage,
            UserDefaultsDataKey.jobTitle.rawValue: jobTitle,
            UserDefaultsDataKey.fullName.rawValue: fullName ]
    }
}
