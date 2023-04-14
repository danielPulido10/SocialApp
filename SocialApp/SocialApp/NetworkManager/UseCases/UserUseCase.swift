//
//  UserUseCase.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

struct UserUseCase {
    struct Response: Codable {
        var id: Int?
        var name: String?
        var email: String?
        var phone: String?
    }
}
