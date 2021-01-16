//
//  MoyaCacheable.swift
//  RateMyAppKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import Moya

public protocol MoyaCacheable {
  typealias MoyaCacheablePolicy = URLRequest.CachePolicy
  var cachePolicy: MoyaCacheablePolicy { get }
}
