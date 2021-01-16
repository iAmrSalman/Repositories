//
//  BundleExtension.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public extension Bundle {
    class var humanSoftSolution: Bundle {
        return bundle(for: "") ?? self.main
    }

    class var app_iOS: Bundle {
        return bundle(for: "App_iOS") ?? self.main
    }
    
    class var appUIKit: Bundle {
         return bundle(for: "AppUIKit") ?? self.main
    }
    
    class var corekit: Bundle {
         return bundle(for: "AppUIKit") ?? self.main
    }

    fileprivate static func bundle(for name: String) -> Bundle? {
        return Bundle(identifier: "com.mamopay.app\(name.isEmpty ? "" : ".\(name)")")
    }
}
