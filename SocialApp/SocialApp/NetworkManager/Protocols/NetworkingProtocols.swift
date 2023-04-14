//
//  NetworkingUserProtocol.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import Alamofire

protocol NetworkingUserProtocol: AnyObject {
    var service: NetworkingServiceUserProtocol { get set }
    
    func getUsers(completion: @escaping (Result<[UserUseCase.Response], AFError>) -> Void)
}

protocol NetworkingPostProtocol: AnyObject {
    var service: NetworkingServiceUserProtocol { get set }
    
    func getPosts(idUser: String, completion: @escaping (Result<[PostUseCase.Response], AFError>) -> Void)
}

protocol NetworkingServiceUserProtocol: AnyObject {
    func requestUsers(completion: @escaping (Result<[UserUseCase.Response], AFError>) -> Void)
    func requestPosts(idUser: String, completion: @escaping (Result<[PostUseCase.Response], AFError>) -> Void )
}
