//
//  Github.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import Moya

public enum Github {
    case searchRepositories(query: String, page: Int, perPage: Int)
    case login(code: String)
}

extension Github: TargetType {
    public var baseURL: URL {
        switch self {
        case .login:
            return URL(string: "https://github.com/")!
        default:
            #if DEBUG
            return URL(string: "https://api.github.com/")!
            #else
            return URL(string: "https://api.github.com/")!
            #endif
        }
    }

    public var path: String {
        switch self {
        case .login:
            return "login/oauth/access_token"
        case .searchRepositories:
            return "search/repositories"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login: return .post
        default: return .get
        }
    }

    public var sampleData: Data {
        Data()
    }

    public var task: Task {
        switch self {
        case let .login(code):
            return .requestParameters(
                parameters: ["client_id": "37881d278b844d642d9c",
                             "client_secret": "8633e639275e8bbaefb777526cd09ab6155b8ae3",
                             "code": code],
                encoding: URLEncoding.httpBody)
        case let .searchRepositories(query, page, perPage):
            return .requestParameters(
                parameters: ["q": query,
                             "page": page,
                             "per_page": perPage],
                encoding: URLEncoding.default
            )
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .login:
            return ["Accept": "application/json"]
        default:
            return ["Accept": "application/vnd.github.v3+json"]
        }
    }
}

extension Github: MoyaCacheable {
    public var cachePolicy: MoyaCacheablePolicy {
        return .reloadIgnoringLocalCacheData
    }
}

extension Github: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? {
        switch self {
        case .login:
            return nil
        default:
            return UserDefaults.standard.string(forKey: "AccessToken") == nil ? nil : .custom("token")
        }
    }
}
