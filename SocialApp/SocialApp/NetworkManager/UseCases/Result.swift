//
//  Result.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

enum Result<T, U> {
    case success(T)
    case failure(U)
}
