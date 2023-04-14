//
//  ViewUserInteractor.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

final class ViewUserInteractor: ViewUserInteractorProtocol {
    var networkingUserAdapter: NetworkingUserProtocol = NetworkinUserAdapter()
    var presenter: ViewUserPresenterProtocol?
    var localStorageUser: LocalStorageProtocol = LocalStorageUser()
    
    func getUsers() {
        networkingUserAdapter.getUsers() { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let users):
                self.presenter?.getUsersSuccess(users: users)
                self.saveUsersLocalStorage(users: users)
            case .failure(let error):
                self.presenter?.getUsersFailed(error: error)
            }
        }
    }
    
    func saveUsersLocalStorage(users: [UserUseCase.Response]) {
        localStorageUser.createUser(users: users) { (response) in
            switch response {
            case .success:
                print("Users saving successfully")
            case .failure(let error):
                print("Error saving users - \(error)")
            }
        }
    }
    
    func getUsersLocalStorage() {
        localStorageUser.fetchUsers() { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let users):
                self.presenter?.getUsersLocalStorageSuccess(users: self.parseUsersLocalStorage(usersDB: users))
            case .failure(let error):
                self.presenter?.getUsersLocalStorageFailed(error: error)
            }
        }
    }
    
    private func parseUsersLocalStorage(usersDB: [UserDB]) -> [UserUseCase.Response] {
        var users: [UserUseCase.Response] = []
        for user in usersDB {
            var userResponse = UserUseCase.Response()
            userResponse.id = Int(user.id)
            userResponse.name = user.name
            userResponse.email = user.email
            userResponse.phone = user.phone
            users.append(userResponse)
        }
        return users
    }
}
