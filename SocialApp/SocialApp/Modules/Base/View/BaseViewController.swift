//
//  BaseViewController.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 12/04/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var colors: AppColors = AppColors()
    var Colors: AppColors { get { return colors }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = Colors.gray
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = colors.white
        navigationController?.navigationBar.tintColor = colors.green
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colors.green,
                                                                   NSAttributedString.Key.font: UIFont(name: "Arial", size: 26)!]
    }
}
