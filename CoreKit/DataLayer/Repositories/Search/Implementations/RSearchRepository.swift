//
//  RSearchRepository.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

final public class RSearchRepository: SearchRepository {

    let searchRemoteAPI: SearchAPI
    let authRemoteAPI: AuthAPI

    public init(searchRemoteAPI: SearchAPI, authRemoteAPI: AuthAPI) {
        self.searchRemoteAPI = searchRemoteAPI
        self.authRemoteAPI = authRemoteAPI
    }

    public func search(keyword: String, page: Int, perPage: Int) -> Promise<PaginationResponse<Repository>> {
        if page < 0 { return Promise(error: CoreKitError.wrongPageNumber) }
        return searchRemoteAPI.search(keyword: keyword, page: page, perPage: perPage)
    }

    public func auth(code: String) -> Promise<UserToken> {
        authRemoteAPI.login(code: code)
    }
}
