//
//  UserDetailsPresenter.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

final class UserDetailsPresenter: UserDetailsPresenterProtocol {
    
    var interactor: UserDetailsInteractorProtocol?
    var user: User?
    var view: UserDetailsProtocol?
    var posts: [PostUseCase.Response]?
    
    func viewDidLoad() {
        guard let user = self.user else { return }
        interactor?.getPostList(idUser: String(user.id))
    }
    
    func getPostListSuccess(posts: [PostUseCase.Response]) {
        self.posts = posts
        view?.reloadTable()
    }
    
    func getPostListFailed(error: AFError) {
        print(error)
    }
}
