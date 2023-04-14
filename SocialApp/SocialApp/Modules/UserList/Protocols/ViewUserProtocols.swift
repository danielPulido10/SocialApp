//
//  ViewUserInteractorProtocol.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

protocol ViewUserInteractorProtocol {
    var presenter: ViewUserPresenterProtocol? { get set }
    var networkingUserAdapter: NetworkingUserProtocol { get set }
    
    func getUsers()
    func saveUsersLocalStorage(users: [UserUseCase.Response])
    func getUsersLocalStorage()
}

protocol ViewUserPresenterProtocol {
    var interactor: ViewUserInteractorProtocol { get set }
    var users: [UserUseCase.Response]? { get set }
    var filtered: [User] { get set }
    var view: ViewUserProtocol? { get set }
    var router: ViewUserRouterProtocol { get set }
    
    func viewDidLoad()
    func getUsersSuccess(users: [UserUseCase.Response])
    func getUsersFailed(error: AFError)
    func getUsersLocalStorageSuccess(users: [UserUseCase.Response])
    func getUsersLocalStorageFailed(error: Error)
    func actionTapped(idUser: Int)
    func filter(value: String)
}

protocol ViewUserRouterProtocol {
    var viewController: BaseViewController? { get set }
    
    func pushDetailsUser(user: User?)
}

protocol ViewUserProtocol {
    var presenter: ViewUserPresenterProtocol { get set }
    
    func reloadTable()
    func changeVisibilityEmpty(isHidden: Bool)
    func changeVisibilityLoader(isHidden: Bool)
}
