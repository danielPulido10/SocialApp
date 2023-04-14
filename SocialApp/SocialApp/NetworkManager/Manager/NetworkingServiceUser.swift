//
//  NetworkingServiceUser.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

final class NetworkingServiceUser: BaseNetworking, NetworkingServiceUserProtocol {
    
    func requestUsers(completion: @escaping (Result<[UserUseCase.Response], AFError>) -> Void ) {
        guard let url = URL(string: "\(baseUrl)users/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                AF.request(url, method: .get).validate(statusCode: self.statusOk).responseDecodable(of: [UserUseCase.Response].self){
                    response in
                    switch response.result {
                    case .success(let users):
                        completion(.success(users))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
    
    func requestPosts(idUser: String, completion: @escaping (Result<[PostUseCase.Response], AFError>) -> Void ) {
        guard let url = URL(string: "\(baseUrl)posts?userId=\(idUser)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                AF.request(url, method: .get).validate(statusCode: self.statusOk).responseDecodable(of: [PostUseCase.Response].self){
                    response in
                    switch response.result {
                    case .success(let users):
                        completion(.success(users))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
