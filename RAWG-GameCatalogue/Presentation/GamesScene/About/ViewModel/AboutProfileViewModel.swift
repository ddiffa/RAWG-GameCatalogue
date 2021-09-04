//
//  EditProfileViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

protocol AboutProfileViewModelInput {
    func didSaveButton(profile: Profile)
    func fetchData()
    func closeAlertUpdate()
}

protocol AboutProfileViewModelOutput {
    var profile: Observable<Profile?> { get }
    var isLoading: Observable<Bool> { get }
    var isUpdated: Observable<Bool> { get }
}

protocol AboutProfileViewModel: AboutProfileViewModelInput,
                               AboutProfileViewModelOutput {}

final class DefaultAboutProfileViewModel: AboutProfileViewModel {
    var profile: Observable<Profile?> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var isUpdated: Observable<Bool> = Observable(false)
    
    private let profileUseCase: ProfileUseCase
    
    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }
    
    private func save(profile: Profile) {
        self.isLoading.value = true
        profileUseCase.save(profile: profile) {
            self.isUpdated.value = true
            self.fetch()
        }
    }
    
    private func fetch() {
        self.isLoading.value = true
        profileUseCase.execute { profile in
            if let profile = profile {
                self.profile.value = profile
            }
            self.isLoading.value = false
        }
    }
}

extension DefaultAboutProfileViewModel {
    func didSaveButton(profile: Profile) {
        save(profile: profile)
    }
    
    func fetchData() {
        fetch()
    }
    
    func closeAlertUpdate() {
        self.isUpdated.value = false
    }
}
