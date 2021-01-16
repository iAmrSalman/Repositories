//
//  Repository.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public struct Repository: Codable, Hashable {
    let id: Int?
    let nodeId: String?
    let name: String?
    public let fullName: String?
    public let owner: Owner?
    let `private`: Bool?
    let htmlUrl: String?
    public let description: String?
    let fork: Bool?
    let url: String?
    let createdAt: String?
    let updatedAt: String?
    let pushedAt: String?
    let homepage: String?
    let size: Int?
    let stargazersCount: Int?
    let watchersCount: Int?
    let language: String?
    let forksCount: Int?
    let openIssuesCount: Int?
    let masterBranch: String?
    let defaultBranch: String?
    let score: Int?
    let archiveUrl: String?
    let assigneesUrl: String?
    let blobsUrl: String?
    let branchesUrl: String?
    let collaboratorsUrl: String?
    let commentsUrl: String?
    let commitsUrl: String?
    let compareUrl: String?
    let contentsUrl: String?
    let contributorsUrl: String?
    let deploymentsUrl: String?
    let downloadsUrl: String?
    let eventsUrl: String?
    let forksUrl: String?
    let gitCommitsUrl: String?
    let gitRefsUrl: String?
    let gitTagsUrl: String?
    let gitUrl: String?
    let issueCommentUrl: String?
    let issueEventsUrl: String?
    let issuesUrl: String?
    let keysUrlsUrl: String?
    let labelsUrl: String?
    let languagesUrl: String?
    let mergesUrl: String?
    let milestonesUrl: String?
    let notificationsUrl: String?
    let pullsUrl: String?
    let releasesUrl: String?
    let sshUrl: String?
    let stargazersUrl: String?
    let statusesUrl: String?
    let subscribersUrl: String?
    let subscriptionUrl: String?
    let tagsUrl: String?
    let teamsUrl: String?
    let treesUrl: String?
    let cloneUrl: String?
    let mirrorUrl: String?
    let hooksUrl: String?
    let svnUrl: String?
    let forks: Int?
    let openIssues: Int?
    let watchers: Int?
    let hasIssues: Bool?
    let hasProjects: Bool?
    let hasPages: Bool?
    let hasWiki: Bool?
    let hasDownloads: Bool?
    let archived: Bool?
    let disabled: Bool?
    let license: License?
}
