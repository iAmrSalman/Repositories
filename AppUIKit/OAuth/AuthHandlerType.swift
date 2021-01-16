//
//  AuthHandlerType.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import SafariServices
import AuthenticationServices

public typealias AuthHandlerCompletion = (URL?, Error?) -> Void

public class AuthContextProvider: NSObject {

    private weak var anchor: ASPresentationAnchor!

    public init(_ anchor: ASPresentationAnchor) {
        self.anchor = anchor
    }

}

extension AuthContextProvider: ASWebAuthenticationPresentationContextProviding {

    @available(iOS 12.0, *)
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return anchor
    }

}

public protocol AuthHandlerType: class {
    var session: NSObject? { get set }
    var contextProvider: AuthContextProvider? { get set }
    func auth(url: URL, callbackScheme: String, completion: @escaping AuthHandlerCompletion)
}

public extension AuthHandlerType {

    func auth(url: URL, callbackScheme: String, completion: @escaping AuthHandlerCompletion) {
        if #available(iOS 12, *) {
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) {
                url, error in
                completion(url, error)
            }
            if #available(iOS 13.0, *) {
                session.presentationContextProvider = contextProvider
            } else {
                // Fallback on earlier versions
            }
            session.start()
            self.session = session
        } else {
            let session = SFAuthenticationSession(url: url, callbackURLScheme: callbackScheme) {
                url, error in
                completion(url, error)
            }
            session.start()
            self.session = session
        }
    }
}
