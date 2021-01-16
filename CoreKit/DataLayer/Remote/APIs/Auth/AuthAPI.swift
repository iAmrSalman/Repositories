//
//  AuthAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

public protocol AuthAPI: RemoteAPI {
    func login(code: String) -> Promise<UserToken>
}
