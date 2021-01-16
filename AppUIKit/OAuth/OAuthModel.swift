//
//  AuthModel.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

final public class OAuthModel: AuthHandlerType {

    //MARK: - Properties

    public var session: NSObject? = nil
    public var contextProvider: AuthContextProvider?
    private(set) var provider: IdentityProvider

    //MARK: - Methods
    
    public init(provider: IdentityProvider) {
        self.provider = provider
    }

    public func auth(_ completion: @escaping ((String?, Error?) -> Void)) {
        guard let authUrlStr = provider.authUrl,
            let authUrl = URL(string: authUrlStr),
            let redirectUrl = URL(string: provider.redirectUrl ?? ""),
            let redirectScheme = redirectUrl.scheme else {
            completion(nil, nil)
            return
        }

        var urlComponents = URLComponents(url: authUrl, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "response_type", value: provider.responseType),
            URLQueryItem(name: "client_id", value: provider.clientId),
            URLQueryItem(name: "redirect_uri", value: provider.redirectUrl),
            URLQueryItem(name: "redirect_url", value: provider.redirectUrl),
            URLQueryItem(name: "scope", value: provider.scope.joined(separator: " ")),
            URLQueryItem(name: "expires_in", value: String(provider.expires))
        ]

        guard let url = urlComponents?.url else {
            completion(nil, nil)
            return
        }

        auth(url: url, callbackScheme: redirectScheme) {
            url, error in
            if error != nil {
                completion(nil, error)
            } else if let `url` = url {
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                      let item = components.queryItems?.first(where: { $0.name == "code" }),
                      let code = item.value else {
                    completion(nil, nil)

                    return
                }

                completion(code, nil)
            }
        }
    }

}
