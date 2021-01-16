//
//  PaginationResponse.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public struct PaginationResponse<T: Codable>: Codable {

    // MARK: - Properties

    let items: [T]?
    let totalCount: Int?
    let incompleteResults: Bool?
    let message: String?

}
