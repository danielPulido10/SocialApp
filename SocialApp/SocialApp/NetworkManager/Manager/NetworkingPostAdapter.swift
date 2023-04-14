//
//  NetworkingPostAdapter.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

final class NetworkingPostAdapter: NetworkingPostProtocol {
    var service: NetworkingServiceUserProtocol = NetworkingServiceUser()
    
    func getPosts(idUser: String, completion: @escaping (Result<[PostUseCase.Response], AFError>) -> Void) {
        service.requestPosts(idUser: idUser) { (data) in
            switch data {
            case .success(let posts):
                completion(.success(posts))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
