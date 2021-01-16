//
//  MainViewController.swift
//  App_iOS
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit
import CoreKit
import AppUIKit
import RxSwift
import RxCocoa

final public class MainViewController: NiblessNavigationController {
    
    // MARK: - Properties
    
    // View Model
    let viewModel: MainViewModel
    
    // Child View Controllers
    let rootViewController: SearchViewController
    
    // State
    let disposeBag = DisposeBag()
    
    // Factories


    public init(viewModel: MainViewModel,
                rootViewController: SearchViewController) {
        self.viewModel = viewModel
        self.rootViewController = rootViewController
        super.init()
        self.delegate = self
    }
    
    func subscribe(to observable: Observable<MainNavigationAction>) {
        observable
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] view in
                guard let `self` = self else { return }
                self.respond(to: view)
            })
            .disposed(by: disposeBag)
    }
    
    func respond(to navigationAction: MainNavigationAction) {
        switch navigationAction {
        case .present(let view): present(view: view)
        case .presented: break
        }
    }
    
    public func present(view: MainView) {
        switch view {
        case .search: presentSeach()
        }
    }
    
    public func presentSeach() {
        pushViewController(rootViewController, animated: true)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        self.navigationBar.prefersLargeTitles = true
    }
    
    private func observeViewModel() {
        let observable = viewModel.view.distinctUntilChanged()
        subscribe(to: observable)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension MainViewController: UINavigationControllerDelegate {

  public func navigationController(_ navigationController: UINavigationController,
                                   willShow viewController: UIViewController,
                                   animated: Bool) {
    guard let viewToBeShown = mainView(associatedWith: viewController) else { return }
    hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
  }

  public func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
    guard let shownView = mainView(associatedWith: viewController) else { return }
    viewModel.uiPresented(mainView: shownView)
  }
}

// MARK: - Navigation Bar Presentation
extension MainViewController {

  func hideOrShowNavigationBarIfNeeded(for view: MainView, animated: Bool) {
    if view.hidesNavigationBar() {
      hideNavigationBar(animated: animated)
    } else {
      showNavigationBar(animated: animated)
    }
  }

  func hideNavigationBar(animated: Bool) {
    if animated {
      transitionCoordinator?.animate(alongsideTransition: { context in
        self.setNavigationBarHidden(true, animated: animated)
      })
    } else {
      setNavigationBarHidden(true, animated: false)
    }
  }

  func showNavigationBar(animated: Bool) {
    if self.isNavigationBarHidden {
      self.setNavigationBarHidden(false, animated: animated)
    }
  }
}

extension MainViewController {
  
  func mainView(associatedWith viewController: UIViewController) -> MainView? {
    switch viewController {
    case is SearchViewController:
      return .search
    default:
      assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
      return nil
    }
  }
}
