//
//  ViewUserRouter.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

final class ViewUserRouter: ViewUserRouterProtocol {
    var viewController: BaseViewController?
    
    func pushDetailsUser(user: User?) {
        guard let model = user else { return }
        let viewController = UserDetailsRouter.createUserDetailsModule(model: model)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
