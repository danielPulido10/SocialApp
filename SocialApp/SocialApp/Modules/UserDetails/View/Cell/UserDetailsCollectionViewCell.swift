//
//  UserDetailsCollectionViewCell.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import UIKit
import PureLayout

class UserDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let topMarginBody: CGFloat = 15
    private let widthBroder: CGFloat = 2
    private let cornerRadius: CGFloat = 15
    private let padding: CGFloat = 20
    private let topMargin: CGFloat = 10
    private let colors: AppColors = AppColors()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addComponentsToView()
    }
    
    private func addComponentsToView() {
        addContainerViewToView()
        addTitleLabelToView()
        addBodyLabelToView()
    }
    
    private func addContainerViewToView() {
        containerView.layer.borderColor = colors.green.cgColor
        containerView.layer.borderWidth = widthBroder
        containerView.layer.cornerRadius = cornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.autoPinEdge(toSuperviewEdge: .left)
        containerView.autoPinEdge(toSuperviewEdge: .right)
        containerView.autoPinEdge(toSuperviewEdge: .top, withInset: topMargin)
        containerView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addTitleLabelToView() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = colors.green
        titleLabel.numberOfLines = .zero
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: padding)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: padding)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
    }
    
    private func addBodyLabelToView() {
        bodyLabel.textAlignment = .center
        bodyLabel.numberOfLines = .zero
        bodyLabel.textColor = colors.black
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.autoPinEdge(toSuperviewEdge: .left, withInset: padding)
        bodyLabel.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
        bodyLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: topMarginBody)
        bodyLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: padding)
    }
}
