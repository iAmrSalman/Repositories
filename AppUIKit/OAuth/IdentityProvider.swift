//
//  IdentityProvider.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

final public class IdentityProvider {
    
    //MARK: - Properties
    
    var authUrl: String?
    var responseType = "code"
    var clientId: String?
    var redirectUrl: String?
    var issuer: String?
    var scope = [String]()
    var expires = "604800"
    
    //MARK: - Methods
    
    init(authUrl: String, redirectUrl: String) {
        self.authUrl = authUrl
        self.redirectUrl = redirectUrl
    }
    
    init(authUrl: String, clientId: String, issuer: String, redirectUrl: String, scope: [String]) {
        self.authUrl = authUrl
        self.clientId = clientId
        self.issuer = issuer
        self.redirectUrl = redirectUrl
        self.scope = scope
    }
    
}

extension IdentityProvider {
    static public var github: IdentityProvider {
        return IdentityProvider(authUrl: "https://github.com/login/oauth/authorize", clientId: "37881d278b844d642d9c", issuer: "GitHub", redirectUrl: "iamrsalman://login/oauth/github", scope: ["user"])
    }
}
