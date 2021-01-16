//
//  MainViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import RxSwift

public typealias MainNavigationAction = NavigationAction<MainView>

public class MainViewModel {
    
    // MARK: - Properties
    
    public var view: Observable<MainNavigationAction> { return viewSubject.asObserver() }
    private let viewSubject = BehaviorSubject<MainNavigationAction>(value: .present(view: .search))
    
    // MARK: - Methods
    
    public init() {}
    
    public func uiPresented(mainView: MainView) {
        viewSubject.onNext(.presented(view: mainView))
    }
}

extension MainViewModel: MainViewResponder {
    public func shouldNavigateToSearch() {
        viewSubject.onNext(.present(view: .search))
    }
}

