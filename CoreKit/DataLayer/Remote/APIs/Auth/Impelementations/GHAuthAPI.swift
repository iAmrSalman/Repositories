//
//  GHAuthAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

final public class GHAuthAPI: AuthAPI {

    public init() {

    }

    public func login(code: String) -> Promise<UserToken> {
        request(Github.login(code: code))
    }
}
