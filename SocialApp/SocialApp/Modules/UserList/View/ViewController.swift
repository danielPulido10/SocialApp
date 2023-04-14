//
//  ViewController.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 10/04/23.
//

import UIKit
import PureLayout

class ViewController: BaseViewController {

    internal lazy var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    internal lazy var containerViewUser: UIView = {
        let view = UIView()
        view.backgroundColor = colors.gray
        return view
    }()
    
    internal lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Buscar Usuario"
        label.textColor = Colors.green
        return label
    }()
    
    internal lazy var searchField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.placeholder = "Buscar por nombre de usuario"
        return searchBar
    }()
    
    internal lazy var collectionUser: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width - 20, height: 200)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "CollectionViewCellUser", bundle: nil), forCellWithReuseIdentifier: "collectionViewCellUser")
        return collection
    }()
    
    internal lazy var containerViewLoad: LoaderView = {
        let view = LoaderView()
        return view
    }()
    
    internal lazy var stackViewEmptyAndUser: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    internal lazy var containerViewEmpty: UIView = {
        let view = UIView()
        return view
    }()
    
    internal lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "List is empty"
        label.textColor = Colors.green
        label.textAlignment = .center
        return label
    }()
    
    private let topMarginSearchLabel: CGFloat = 20
    private let topMarginSearch: CGFloat = 10
    private let topMarginCollection: CGFloat = 30
    private let leftMargin: CGFloat = 20
    internal var presenter: ViewUserPresenterProtocol = ViewUserPresenter()
    
    private var loaderIsHidden: Bool = false {
        didSet {
            setVisibilityLoader(isHidden: loaderIsHidden)
        }
    }
    
    private var emptyIsHidden: Bool = true {
        didSet {
            setVisibilityEmpty(isHidden: emptyIsHidden)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Social APP"
        setPresenter()
        addComponentsToView()
        emptyIsHidden = true
    }
    
    private func setPresenter() {
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    private func setVisibilityLoader(isHidden: Bool) {
        containerViewLoad.isHidden = isHidden
        containerViewLoad.isAnimating = !isHidden
        containerViewUser.isHidden = !isHidden
        containerViewEmpty.isHidden = true
    }
    
    private func setVisibilityEmpty(isHidden: Bool){
        collectionUser.isHidden = !isHidden
        containerViewEmpty.isHidden = isHidden
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setStyleSearchField()
    }
    
    private func addComponentsToView() {
        addStackViewToView()
        addContainerViewUsertoView()
        addSearchLabelToView()
        addSearchFieldToView()
        addStackViewEmptyAndUserToView()
        addCollectionUserToView()
        addContainerViewLoadToView()
        addContainerViewEmptyToView()
        addEmptyLabelToView()
    }
    
    private func setStyleSearchField() {
        let border = CALayer()
        border.borderColor = colors.green.cgColor
        border.frame = CGRect(x: 10, y: searchField.frame.size.height - 1, width:  searchField.frame.size.width - 20, height: searchField.frame.size.height)
        border.borderWidth = 1
        searchField.layer.addSublayer(border)
        searchField.layer.masksToBounds = true
    }
    
    private func addStackViewToView() {
        view.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .left)
        stackView.autoPinEdge(toSuperviewEdge: .right)
        stackView.autoPinEdge(toSuperviewSafeArea: .top)
        stackView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
    
    private func addContainerViewUsertoView() {
        stackView.addArrangedSubview(containerViewUser)
        containerViewUser.autoPinEdge(toSuperviewEdge: .left)
        containerViewUser.autoPinEdge(toSuperviewEdge: .right)
        containerViewUser.autoPinEdge(toSuperviewEdge: .top)
        containerViewUser.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addSearchLabelToView() {
        containerViewUser.addSubview(searchLabel)
        searchLabel.autoPinEdge(toSuperviewEdge: .top, withInset: topMarginSearchLabel)
        searchLabel.autoPinEdge(toSuperviewEdge: .left, withInset: leftMargin)
        searchLabel.autoPinEdge(toSuperviewEdge: .right)
    }
    
    private func addSearchFieldToView() {
        containerViewUser.addSubview(searchField)
        searchField.autoPinEdge(toSuperviewEdge: .left, withInset: leftMargin)
        searchField.autoPinEdge(toSuperviewEdge: .right, withInset: leftMargin)
        searchField.autoPinEdge(.top, to: .bottom, of: searchLabel, withOffset: topMarginSearch)
    }
    
    private func addStackViewEmptyAndUserToView() {
        containerViewUser.addSubview(stackViewEmptyAndUser)
        stackViewEmptyAndUser.autoPinEdge(toSuperviewEdge: .left)
        stackViewEmptyAndUser.autoPinEdge(toSuperviewEdge: .right)
        stackViewEmptyAndUser.autoPinEdge(.top, to: .bottom, of: searchField, withOffset: topMarginCollection)
        stackViewEmptyAndUser.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addCollectionUserToView() {
        stackViewEmptyAndUser.addArrangedSubview(collectionUser)
        collectionUser.backgroundColor = Colors.gray
        collectionUser.autoPinEdge(toSuperviewEdge: .left)
        collectionUser.autoPinEdge(toSuperviewEdge: .right)
        collectionUser.autoPinEdge(toSuperviewEdge: .top)
        collectionUser.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addContainerViewLoadToView() {
        stackView.addArrangedSubview(containerViewLoad)
        containerViewLoad.autoPinEdge(toSuperviewEdge: .left)
        containerViewLoad.autoPinEdge(toSuperviewEdge: .right)
        containerViewLoad.autoPinEdge(toSuperviewEdge: .top)
        containerViewLoad.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addContainerViewEmptyToView() {
        stackViewEmptyAndUser.addArrangedSubview(containerViewEmpty)
        containerViewEmpty.autoPinEdge(toSuperviewEdge: .left)
        containerViewEmpty.autoPinEdge(toSuperviewEdge: .right)
        containerViewEmpty.autoPinEdge(toSuperviewEdge: .top)
        containerViewEmpty.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func addEmptyLabelToView() {
        containerViewEmpty.addSubview(emptyLabel)
        emptyLabel.autoPinEdge(toSuperviewEdge: .left)
        emptyLabel.autoPinEdge(toSuperviewEdge: .right)
        emptyLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(presenter.filtered.count)
        return presenter.filtered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionUser.dequeueReusableCell(withReuseIdentifier: "collectionViewCellUser", for: indexPath) as? CollectionViewCellUser
        guard let finalCell = cell else { return CollectionViewCellUser() }
        finalCell.nameLabel.text = presenter.filtered[indexPath.item].name
        finalCell.phoneLabel.text = presenter.filtered[indexPath.item].phone
        finalCell.mailLabel.text = presenter.filtered[indexPath.item].email
        finalCell.showResultLabel.tag = indexPath.item
        finalCell.presenter = presenter
        return finalCell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != " "  {
            presenter.filter(value: searchBar.text ?? String())
        }
    }
}

extension ViewController: ViewUserProtocol {
    
    func reloadTable() {
        collectionUser.reloadData()
        validateUsers()
    }
    
    func changeVisibilityLoader(isHidden: Bool) {
        loaderIsHidden = isHidden
    }
    
    func changeVisibilityEmpty(isHidden: Bool) {
        emptyIsHidden = isHidden
    }
    
    private func validateUsers() {
        if presenter.users?.count == .zero {
            loaderIsHidden = false
        } else {
            loaderIsHidden = true
        }
    }
}

