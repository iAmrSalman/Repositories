//
//  Repository.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public struct Owner: Codable, Hashable {
	let login: String?
	let id: Int?
	let nodeId: String?
	public let avatarUrl: String?
	let gravatarId: String?
	let url: String?
	let received_eventsUrl: String?
	let type: String?
	let htmlUrl: String?
	let followersUrl: String?
	let followingUrl: String?
	let gistsUrl: String?
	let starredUrl: String?
	let subscriptionsUrl: String?
	let organizationsUrl: String?
	let reposUrl: String?
	let eventsUrl: String?
	let siteAdmin: Bool?
}
