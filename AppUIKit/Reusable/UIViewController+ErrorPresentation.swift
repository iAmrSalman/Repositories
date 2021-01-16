//
//  UIViewController+ErrorPresentation.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import CoreKit
import RxSwift

public extension UIViewController {
  
  // MARK: - Methods
    func present(errorMessage: ErrorMessage) {
    let errorAlertController = UIAlertController(title: errorMessage.title,
                                                 message: errorMessage.message,
                                                 preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    errorAlertController.addAction(okAction)
    present(errorAlertController, animated: true, completion: nil)
  }
  
    func present(errorMessage: ErrorMessage,
                      withPresentationState errorPresentation: BehaviorSubject<ErrorPresentation?>? = nil) {
    errorPresentation?.onNext(.presenting)
    let errorAlertController = UIAlertController(title: errorMessage.title,
                                                 message: errorMessage.message,
                                                 preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      errorPresentation?.onNext(.dismissed)
      errorPresentation?.onNext(nil)
    }
    errorAlertController.addAction(okAction)
    present(errorAlertController, animated: true, completion: nil)
    
  }
}
