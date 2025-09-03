//
//  LoginProfileViewModel.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 14.02.20.
//  Copyright © 2020 RB. All rights reserved.
//

import Foundation
import Combine

class LoginProfileViewModel: ObservableObject {
    var cancellable: AnyCancellable?
    
    let getGithubReposService: GetRequestsGit
    let urlService: GitHubUrls
    
    @Published var userObject: UserDTO?
    
    init(webService: GetRequestsGit, urlServiceClass: GitHubUrls = GitHubUrls()) {
        getGithubReposService = webService
        urlService = urlServiceClass
        
        cancellable = NotificationCenter.Publisher(center: .default, name: .reloadProfile, object: nil)
            .sink { [weak self] notification in
                print("user logged in, reload this view")
                Task { @MainActor in
                    self?.loadUserFromGitHub()
                }
        }
    }
    
    deinit {
        self.cancellable?.cancel()
    }
    
    @MainActor
    func loadUserFromGitHub() {
        // if no auth objects persisted, do not try to load profile from github
        guard let _ : LoginAccessTokenDTO = UserDefaults.standard.getObject(forKey: GitHubExplorerAppCreds.persistedLoginObject) else {
            userObject = nil
            return
        }
        
        Task {
            let userResult: Result<UserDTO, Error> = await getGithubReposService.getJsonData(url: urlService.getUserUrl())

            switch userResult {
            case .success(let loadedUserDto):
                userObject = loadedUserDto
            case .failure:
                userObject = nil
            }
        }
    }
}
