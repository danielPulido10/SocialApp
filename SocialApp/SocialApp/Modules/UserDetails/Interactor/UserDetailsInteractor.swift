//
//  UserDetailsInteractor.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

final class UserDetailsInteractor: UserDetailsInteractorProtocol {
    
    var presenter: UserDetailsPresenterProtocol?
    var networkingPostAdapter: NetworkingPostProtocol = NetworkingPostAdapter()
    
    func getPostList(idUser: String) {
        networkingPostAdapter.getPosts(idUser: idUser) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let posts):
                self.presenter?.getPostListSuccess(posts: posts)
            case .failure(let error):
                self.presenter?.getPostListFailed(error: error)
            }
        }
    }
}
