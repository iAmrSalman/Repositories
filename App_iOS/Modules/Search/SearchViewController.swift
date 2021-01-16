//
//  SearchViewController.swift
//  App_iOS
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit
import CoreKit
import AppUIKit
import RxSwift
import RxCocoa
import Kingfisher

final public class SearchViewController: NiblessViewController {

    // MARK: - Properties
    let viewModel: SearchViewModel

    // State
    let disposeBag = DisposeBag()
    private lazy var model: OAuthModel = {
        let github = IdentityProvider.github
        let model = OAuthModel(provider: github)
        if let context = UIApplication.shared.keyWindow {
            model.contextProvider = AuthContextProvider(context)
        }
        return model
    }()

    // Views
    let customView: SearchResultsListView
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search in repositories.."
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    // MARK: - Methods

    init(viewModel: SearchViewModel, view: SearchResultsListView) {
        self.viewModel = viewModel
        self.customView = view
        super.init()
    }

    public override func loadView() {
        view = customView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
        bindResultsTableToViewModel()
        bindSearchBar()
        title = "Search"
        navigationItem.searchController = searchController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: {
            $0.setTitle(nil, for: .normal)
            $0.tintColor = R.color.black()
            $0.setImage(R.image.login(), for: .normal)
            $0.addTarget(self, action: #selector(loginToGithub(_:)), for: .touchUpInside)
            return $0
        } (UIButton()))
        customView.resultsTable.rx.setDelegate(self).disposed(by: disposeBag)
    }

    @objc func loginToGithub(_ sender: Any) {
        model.auth { [weak self] authCode, error in
            guard let `self` = self else { return }
            if error != nil {
                self.present(errorMessage: ErrorMessage(title: "Sign in failed", message: error?.localizedDescription ?? ""))
            } else if let authCode = authCode {
                self.viewModel.gotNewToken.accept(authCode)
            }
        }
    }

    private func bindResultsTableToViewModel() {
        viewModel.repositories
            .bind(to: customView.resultsTable.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchResultCell.self)) { _, model, cell in
                cell.imageAvatar.kf.indicatorType = .activity
                cell.imageAvatar.kf.setImage(with: URL(string: model.owner?.avatarUrl ?? ""))
                cell.labelName.text = model.fullName
                cell.labelDescription.text = model.description
            }.disposed(by: self.disposeBag)

        customView.resultsTable.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                defer {
                    self.customView.resultsTable.deselectRow(at: indexPath, animated: true)
                }
                self.viewModel.selectRepository(at: indexPath.row)
            }).disposed(by: self.disposeBag)

        customView.resultsTable.rx.willDisplayCell
            .asDriver()
            .drive(onNext: { [weak self] displayEvent in
                guard let `self` = self else { return }
                self.viewModel.displayedResultIndex.accept(displayEvent.indexPath.row)
            }).disposed(by: self.disposeBag)
    }

    private func bindSearchBar() {
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(50), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.viewModel.searchKeyword.accept($0)
            })
            .disposed(by: disposeBag)
    }


    private func observeErrorMessages() {
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] errorMessage in
                guard let `self` = self else { return }
                self.present(errorMessage: errorMessage)
            })
            .disposed(by: disposeBag)
    }

}

extension SearchViewController: UITableViewDelegate {}
