//
//  Repository.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public struct License: Codable, Hashable {
	let key: String?
	let name: String?
	let url: String?
	let spdxId: String?
	let nodeId: String?
	let htmlUrl: String?
}
