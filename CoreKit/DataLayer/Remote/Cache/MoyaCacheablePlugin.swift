//
//  MoyaCacheablePlugin.swift
//  RateMyAppKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import Moya

public final class MoyaCacheablePlugin: PluginType {
    
    init() { }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let moyaCachableProtocol = target as? MoyaCacheable {
            var cachableRequest = request
            cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
            return cachableRequest
        }
        return request
    }
}
