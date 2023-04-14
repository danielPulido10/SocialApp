//
//  UserDetailsProtocols.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

protocol UserDetailsRouterProtocol {
    var view: BaseViewController? { get set }
    
    static func createUserDetailsModule(model: User) -> UserDetailsViewController
}

protocol UserDetailsPresenterProtocol {
    var interactor: UserDetailsInteractorProtocol? { get set }
    var user: User? { get set }
    var view: UserDetailsProtocol? { get set }
    var posts: [PostUseCase.Response]? { get set }
    
    func viewDidLoad()
    func getPostListSuccess(posts: [PostUseCase.Response])
    func getPostListFailed(error: AFError)
}

protocol UserDetailsInteractorProtocol {
    var presenter: UserDetailsPresenterProtocol? { get set }
    var networkingPostAdapter: NetworkingPostProtocol { get set }
    
    func getPostList(idUser: String)
}

protocol UserDetailsProtocol {
    var presenter: UserDetailsPresenterProtocol? { get set }
    
    func reloadTable()
}
