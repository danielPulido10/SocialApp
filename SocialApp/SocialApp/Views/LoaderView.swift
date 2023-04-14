//
//  LoaderView.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import UIKit

internal class LoaderView: UIView {
    
    internal lazy var loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = colors.green
        return indicator
    }()
    
    internal lazy var loaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Cargando..."
        label.textColor = colors.green
        label.textAlignment = .center
        return label
    }()
    
    internal var isAnimating: Bool = false {
        didSet {
            isAnimating ? loader.startAnimating() : loader.stopAnimating()
        }
    }
    
    private let topMarginLoaderLabel: CGFloat = 25
    private let colors: AppColors = AppColors()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    internal init() {
        super.init(frame: UIView().frame)
        addComponentsToView()
    }
    
    private func addComponentsToView() {
        addLoaderToView()
        addLoaderLabelToView()
    }
    
    private func addLoaderToView() {
        addSubview(loader)
        loader.autoPinEdge(toSuperviewEdge: .top, withInset: 300)
        loader.autoPinEdge(toSuperviewEdge: .left)
        loader.autoPinEdge(toSuperviewEdge: .right)
    }
    
    private func addLoaderLabelToView() {
        addSubview(loaderLabel)
        loaderLabel.autoPinEdge(.top, to: .bottom, of: loader, withOffset: topMarginLoaderLabel)
        loaderLabel.autoPinEdge(toSuperviewEdge: .left)
        loaderLabel.autoPinEdge(toSuperviewEdge: .right)
    }
    
}
