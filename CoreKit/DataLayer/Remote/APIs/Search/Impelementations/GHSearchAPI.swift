//
//  GHSearchAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

public class GHSearchAPI: SearchAPI {

    public init() {

    }

    public func search(keyword: String, page: Int, perPage: Int) -> Promise<PaginationResponse<Repository>> {
        return request(Github.searchRepositories(query: keyword, page: page, perPage: perPage))
    }
}
