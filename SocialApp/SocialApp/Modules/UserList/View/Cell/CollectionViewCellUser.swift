//
//  CollectionViewCellUser.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 12/04/23.
//

import UIKit

class CollectionViewCellUser: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var showResultLabel: UILabel!
    @IBOutlet weak var imageMail: UIImageView!
    @IBOutlet weak var imagePhone: UIImageView!
    
    private let marginTop: CGFloat = 20
    private let marginTopShowResult: CGFloat = 30
    private let cornerRadius: CGFloat = 15
    private let marginLeftRight: CGFloat = 20
    private let iconSize: CGFloat = 22
    private let widthBorder: CGFloat = 2
    private let textShowResult: String = "Ver publicaciones"
    private let colors: AppColors = AppColors()
    
    internal var presenter: ViewUserPresenterProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addComponentsToView()
    }
    
    private func addComponentsToView() {
        addContainerViewToView()
        addNameLabelToView()
        addImagePhoneToView()
        addPhoneLabelToView()
        addImageMailToView()
        addMailLabelToView()
        addShowResultLabelToView()
    }
    
    private func addContainerViewToView() {
        containerView.layer.borderWidth = widthBorder
        containerView.layer.borderColor = colors.green.cgColor
        containerView.backgroundColor = colors.white
        containerView.layer.cornerRadius = cornerRadius
        containerView.autoPinEdge(toSuperviewEdge: .left)
        containerView.autoPinEdge(toSuperviewEdge: .right)
        containerView.autoPinEdge(toSuperviewEdge: .top)
        containerView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addNameLabelToView() {
        nameLabel.textColor = colors.green
        nameLabel.numberOfLines = .zero
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: marginTop)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: marginLeftRight)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: marginLeftRight)
    }
    
    private func addImagePhoneToView() {
        imagePhone.image = UIImage(named: "ic_phone")
        imagePhone.translatesAutoresizingMaskIntoConstraints = false
        imagePhone.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: marginTop)
        imagePhone.autoPinEdge(toSuperviewEdge: .left, withInset: marginLeftRight)
        imagePhone.autoSetDimension(.height, toSize: iconSize)
        imagePhone.autoSetDimension(.width, toSize: iconSize)
    }
    
    private func addPhoneLabelToView() {
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.numberOfLines = .zero
        phoneLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: marginTop)
        phoneLabel.autoPinEdge(.left, to: .right, of: imagePhone, withOffset: marginLeftRight)
        phoneLabel.autoPinEdge(toSuperviewEdge: .right, withInset: marginLeftRight)
    }
    
    private func addImageMailToView() {
        imageMail.image = UIImage(named: "ic_mail")
        imageMail.translatesAutoresizingMaskIntoConstraints = false
        imageMail.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: marginTop)
        imageMail.autoPinEdge(toSuperviewEdge: .left, withInset: marginLeftRight)
        imageMail.autoSetDimension(.height, toSize: iconSize)
        imageMail.autoSetDimension(.width, toSize: iconSize)
    }
    
    private func addMailLabelToView() {
        mailLabel.numberOfLines = .zero
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        mailLabel.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: marginTop)
        mailLabel.autoPinEdge(.left, to: .right, of: imageMail, withOffset: marginLeftRight)
        mailLabel.autoPinEdge(toSuperviewEdge: .right, withInset: marginLeftRight)
    }
    
    private func addShowResultLabelToView() {
        showResultLabel.numberOfLines = .zero
        showResultLabel.text = textShowResult.uppercased()
        showResultLabel.textColor = colors.green
        addShowResultLabelGesture()
        showResultLabel.translatesAutoresizingMaskIntoConstraints = false
        showResultLabel.autoPinEdge(.top, to: .bottom, of: mailLabel, withOffset: marginTopShowResult)
        showResultLabel.autoPinEdge(toSuperviewEdge: .right, withInset: marginLeftRight)
    }
    
    private func addShowResultLabelGesture() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        showResultLabel.isUserInteractionEnabled = true
        showResultLabel.addGestureRecognizer(labelTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let presenter = presenter else { return }
        presenter.actionTapped(idUser: showResultLabel.tag)
    }
}
