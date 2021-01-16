//
//  Storyboarded.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className.replacingOccurrences(of: "VC", with: ""), bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
