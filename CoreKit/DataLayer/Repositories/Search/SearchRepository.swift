//
//  SearchRepository.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

public protocol SearchRepository {
    func search(keyword: String, page: Int, perPage: Int) -> Promise<PaginationResponse<Repository>>
    func auth(code: String) -> Promise<UserToken>
}
