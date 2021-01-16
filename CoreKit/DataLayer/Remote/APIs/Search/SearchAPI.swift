//
//  SearchAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

public protocol SearchAPI: RemoteAPI {
    func search(keyword: String, page: Int, perPage: Int) -> Promise<PaginationResponse<Repository>>
}
