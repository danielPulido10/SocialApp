//
//  NetworkingUserAdapter.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

final class NetworkinUserAdapter: NetworkingUserProtocol {
    var service: NetworkingServiceUserProtocol = NetworkingServiceUser()
    
    func getUsers(completion: @escaping (Result<[UserUseCase.Response], AFError>) -> Void) {
        service.requestUsers() { (data) in
            switch data {
            case .success(let users):
                completion(.success(users))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
