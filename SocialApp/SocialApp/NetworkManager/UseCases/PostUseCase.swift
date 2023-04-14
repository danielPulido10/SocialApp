//
//  PostUseCase.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

struct PostUseCase {
    struct Response: Codable {
        var title: String?
        var body: String?
    }
}
