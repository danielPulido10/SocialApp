//
//  ViewUserPresenter.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 12/04/23.
//

import Foundation
import Alamofire

final class ViewUserPresenter: ViewUserPresenterProtocol {
    
    var interactor: ViewUserInteractorProtocol = ViewUserInteractor()
    var router: ViewUserRouterProtocol = ViewUserRouter()
    var users: [UserUseCase.Response]?
    var filtered: [User] = []
    var view: ViewUserProtocol?
    
    init() {
        interactor.presenter = self
    }
    
    func viewDidLoad() {
        view?.changeVisibilityLoader(isHidden: false)
        interactor.getUsersLocalStorage()
    }
    
    func getUsersSuccess(users: [UserUseCase.Response]) {
        self.users = users
        parseFilterList()
        view?.reloadTable()
    }
    
    func getUsersFailed(error: AFError) {
        print(error)
    }
    
    func getUsersLocalStorageSuccess(users: [UserUseCase.Response]) {
        if users.count == .zero {
            interactor.getUsers()
            return
        }
        self.users = users
        parseFilterList()
        view?.reloadTable()
    }
    
    func getUsersLocalStorageFailed(error: Error) {
        print(error)
    }
    
    func actionTapped(idUser: Int) {
        guard let users = self.users else { return }
        router.pushDetailsUser(user: createUser(model: users[idUser]))
    }
    
    func filter(value: String) {
        if value != String() {
            filterArray(value: value)
            return
        }
        parseFilterList()
        view?.reloadTable()
    }
    
    func filterArray(value: String) {
        parseFilterList()
        let provisionalList: [User] = filtered
        filtered = provisionalList.filter({ (item) -> Bool in
            return (item.name.localizedCaseInsensitiveContains(value))
        })
        view?.reloadTable()
        validateIsSecreenIsEmpty()
    }
    
    func validateIsSecreenIsEmpty() {
        filtered.count == .zero ? view?.changeVisibilityEmpty(isHidden: false) : view?.changeVisibilityEmpty(isHidden: true)
    }
    
    private func parseFilterList() {
        self.filtered = []
        guard let users = self.users else { return }
        for user in users {
            if let user = createUser(model: user) {
                self.filtered.append(user)
            }
        }
        view?.changeVisibilityEmpty(isHidden: true)
    }
    
    private func createUser(model: UserUseCase.Response) -> User? {
        router.viewController = view as? BaseViewController
        guard let id = model.id, let name = model.name, let email = model.email, let phone = model.phone else { return nil }
        return User(id: id, name: name, email: email, phone: phone)
    }
}
