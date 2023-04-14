//
//  UserDetailsRouter.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation

final class UserDetailsRouter: UserDetailsRouterProtocol {
    var view: BaseViewController?
    
    static func createUserDetailsModule(model: User) -> UserDetailsViewController {
        let viewController = UserDetailsViewController()
        
        var presenter: UserDetailsPresenterProtocol = UserDetailsPresenter()
        presenter.user = model
        
        var interactor: UserDetailsInteractorProtocol = UserDetailsInteractor()
        interactor.presenter = presenter
        
        let router = UserDetailsRouter()
        router.view = viewController
        
        presenter.view = viewController
        presenter.interactor = interactor
        
        viewController.presenter = presenter
        return viewController
    }
}
