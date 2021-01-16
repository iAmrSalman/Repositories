//
//  UserToken.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public struct UserToken: Codable, Hashable {
    let accessToken: String?
    let scope: String?
    let tokenType: String?
}
