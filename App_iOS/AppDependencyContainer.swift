//
//  AppDependencyContainer.swift
//  Repositories
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit
import CoreKit
import AppUIKit

public class AppDependencyContainer {
    
    // MARK: - Properties
    
    // Long-lived dependencies
    let sharedMainViewModel: MainViewModel
    
    // MARK: - Methods
    public init() {
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        
        self.sharedMainViewModel = makeMainViewModel()
    }
}

// MARK: - MainViewController
public extension AppDependencyContainer {
    func makeMainViewController() -> MainViewController {

        let rootViewController = makeSearchViewController()
        
        return MainViewController(viewModel: sharedMainViewModel,
                                  rootViewController: rootViewController)
    }
}

// MARK: - SearchViewController
extension AppDependencyContainer {
    func makeSearchViewController() -> SearchViewController {
        let searchAPI = GHSearchAPI()
        let authAPI = GHAuthAPI()
        let searchRepository = RSearchRepository(searchRemoteAPI: searchAPI, authRemoteAPI: authAPI)
        let viewModel = SearchViewModel(repository: searchRepository, responder: sharedMainViewModel)
        let view = SearchResultsListView()
        return SearchViewController(viewModel: viewModel, view: view)
    }
}

// MARK: - RepositoryDetailsViewController
extension AppDependencyContainer {

}
