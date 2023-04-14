//
//  UserDetailsViewController.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import UIKit
import PureLayout

class UserDetailsViewController: BaseViewController {
    
    internal lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.green
        return view
    }()
    
    internal lazy var namelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = Colors.white
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    internal lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    internal lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    internal lazy var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    internal lazy var containerLoaderView: LoaderView = {
        let view = LoaderView()
        return view
    }()
    
    internal lazy var containerPostsView: UIView = {
        let view = UIView()
        return view
    }()
    
    internal lazy var collectionPost: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width - 20, height: 230)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.register(UINib(nibName: "UserDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "userDetailsCollectionViewCell")
        return collection
    }()
    
    var presenter: UserDetailsPresenterProtocol?
    private let topMarginLabel: CGFloat = 20
    
    private var loaderIsHidden: Bool = false {
        didSet {
            setVisibilityLoader(isHidden: loaderIsHidden)
        }
    }
    
    private func setVisibilityLoader(isHidden: Bool) {
        containerLoaderView.isHidden = isHidden
        containerLoaderView.isAnimating = !isHidden
        containerPostsView.isHidden = !isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponentsToView()
        presenter?.viewDidLoad()
        loaderIsHidden = false
    }
    
    private func addComponentsToView() {
        addContainerViewToView()
        addNameLabelToView()
        addPhoneLabelToView()
        addEmailLabelToView()
        addValuesLabel()
        addStackViewToView()
        addContainerViewToView()
        addContainerPostsViewToView()
        addCollectionPostViewToView()
        addContainerLoaderViewToView()
    }
    
    private func addContainerViewToView() {
        view.addSubview(containerView)
        containerView.autoPinEdge(toSuperviewSafeArea: .top)
        containerView.autoPinEdge(toSuperviewEdge: .right)
        containerView.autoPinEdge(toSuperviewEdge: .left)
        containerView.autoSetDimension(.height, toSize: 150)
    }
    
    private func addNameLabelToView() {
        containerView.addSubview(namelabel)
        namelabel.autoPinEdge(toSuperviewEdge: .right)
        namelabel.autoPinEdge(toSuperviewEdge: .left)
        namelabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: topMarginLabel)
    }
    
    private func addPhoneLabelToView() {
        containerView.addSubview(phoneLabel)
        phoneLabel.autoPinEdge(toSuperviewEdge: .right)
        phoneLabel.autoPinEdge(toSuperviewEdge: .left)
        phoneLabel.autoPinEdge(.top, to: .bottom, of: namelabel, withOffset: topMarginLabel)
    }
    
    private func addEmailLabelToView() {
        containerView.addSubview(emailLabel)
        emailLabel.autoPinEdge(toSuperviewEdge: .right)
        emailLabel.autoPinEdge(toSuperviewEdge: .left)
        emailLabel.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: topMarginLabel)
    }
    
    private func addValuesLabel() {
        guard let presenter = self.presenter else { return }
        namelabel.text = presenter.user?.name
        phoneLabel.text = presenter.user?.phone
        emailLabel.text = presenter.user?.email
    }
    
    private func addStackViewToView() {
        view.addSubview(stackView)
        stackView.autoPinEdge(.top, to: .bottom, of: containerView, withOffset: topMarginLabel)
        stackView.autoPinEdge(toSuperviewEdge: .right)
        stackView.autoPinEdge(toSuperviewEdge: .left)
        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addContainerPostsViewToView() {
        stackView.addArrangedSubview(containerPostsView)
        containerPostsView.autoPinEdge(toSuperviewEdge: .top)
        containerPostsView.autoPinEdge(toSuperviewEdge: .right)
        containerPostsView.autoPinEdge(toSuperviewEdge: .left)
        containerPostsView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addCollectionPostViewToView() {
        containerPostsView.addSubview(collectionPost)
        collectionPost.autoPinEdge(toSuperviewEdge: .top)
        collectionPost.autoPinEdge(toSuperviewEdge: .right)
        collectionPost.autoPinEdge(toSuperviewEdge: .left)
        collectionPost.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addContainerLoaderViewToView() {
        stackView.addArrangedSubview(containerLoaderView)
        containerLoaderView.autoPinEdge(toSuperviewEdge: .top)
        containerLoaderView.autoPinEdge(toSuperviewEdge: .right)
        containerLoaderView.autoPinEdge(toSuperviewEdge: .left)
        containerLoaderView.autoPinEdge(toSuperviewEdge: .bottom)
    }
}

extension UserDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter, let posts = presenter.posts else { return .zero }
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPost.dequeueReusableCell(withReuseIdentifier: "userDetailsCollectionViewCell", for: indexPath) as? UserDetailsCollectionViewCell
        guard let posts = presenter?.posts, let finalCell = cell else { return UserDetailsCollectionViewCell() }
        finalCell.titleLabel.text = posts[indexPath.item].title
        finalCell.bodyLabel.text = posts[indexPath.item].body
        return finalCell
    }
}

extension UserDetailsViewController: UserDetailsProtocol {
    
    func reloadTable() {
        collectionPost.reloadData()
        validatePosts()
    }
    
    private func validatePosts() {
        if presenter?.posts?.count == .zero {
            loaderIsHidden = false
        } else {
            loaderIsHidden = true
        }
    }
}
