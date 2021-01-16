//
//  Sharable.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit

public protocol Sharable {
    func share(_ str: String, source: UIView?, completionHandler: ((_ completed: Bool) -> Void)?)
}

public extension Sharable where Self: UIViewController {
    func share(_ str: String, source: UIView? = nil, completionHandler: ((_ completed: Bool) -> Void)? = nil) {
        let activityController = UIActivityViewController.init(activityItems: [str], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = source ?? self.view
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            completionHandler?(completed)
        }

        self.present(activityController, animated: true, completion: nil)
    }
    
    func share(_ data: Data, source: UIView? = nil, completionHandler: ((_ completed: Bool) -> Void)? = nil) {
        let activityController = UIActivityViewController.init(activityItems: [data], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = source ?? self.view
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            completionHandler?(completed)
        }
        
        self.present(activityController, animated: true, completion: nil)
    }
    
    func share(_ image: UIImage, source: UIView? = nil, completionHandler: ((_ completed: Bool) -> Void)? = nil) {
        share(image.jpegData(compressionQuality: 1) ?? Data(), completionHandler: completionHandler)
    }

}
