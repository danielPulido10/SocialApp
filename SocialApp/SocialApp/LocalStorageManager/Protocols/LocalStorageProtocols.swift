//
//  LocalStorageProtocols.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

protocol LocalStorageProtocol {
    func createUser(users: [UserUseCase.Response], completion: @escaping (Result<Data?, Error>) -> Void)
    func fetchUsers(completion: @escaping (Result<[UserDB], Error>) -> Void)
}
