//
//  RemoteAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit
import Moya

public protocol RemoteAPI {
    func request<T: TargetType & MoyaCacheable, R: Codable>(_ target: T) -> Promise<R>
}

extension RemoteAPI {
    var provider: MoyaProvider<MultiTarget> {
        return MoyaProvider<MultiTarget>(
            plugins: [
                NetworkLoggerPlugin(),
                MoyaCacheablePlugin(),
                AccessTokenPlugin(tokenClosure: { _ -> String in
                    return UserDefaults.standard.string(forKey: "AccessToken") ?? ""
                })
            ]
        )
        
    }
    
    public func request<T: TargetType & MoyaCacheable, R: Codable>(_ target: T) -> Promise<R> {
        return Promise<R> { seal in
            provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let moyaResponse):
                    do {
                        let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try filteredResponse.map(R.self, using: decoder)
                        seal.fulfill(response)
                    } catch {
                        seal.reject(error)
                        print(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                    print(error)
                }
            }
        }
    }
}
