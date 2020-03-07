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
    
    init(getReposHelper: GetRequestsGit, urlServiceClass: GitHubUrls = GitHubUrls()) {
        getGithubReposService = getReposHelper
        urlService = urlServiceClass
        
        cancellable = NotificationCenter.Publisher(center: .default, name: .reloadProfile, object: nil)
            .sink { [weak self] notification in
                print("user logged in, reload this view")
                self?.loadUserFromGitHub()
        }
    }
    
    deinit {
        self.cancellable?.cancel()
    }
    
    func loadUserFromGitHub() {
        // if no auth objects persisted, do not try to load profile from github
        guard let _ : LoginAccessTokenDTO = UserDefaults.standard.getObject(forKey: GitHubExplorerAppCreds.persistedLoginObject) else {
            userObject = nil
            return
        }
        
        getGithubReposService.getJsonData(url: urlService.getUserUrl()) { [weak self] (result: Result<UserDTO, Error>) in
            switch result {
            case .success(let loadedUserDto):
                self?.userObject = loadedUserDto
            case .failure:
                self?.userObject = nil
            }
        }
    }
}
