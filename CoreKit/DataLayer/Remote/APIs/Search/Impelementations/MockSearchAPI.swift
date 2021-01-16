//
//  MockSearchAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import PromiseKit

public class MockSearchAPI: SearchAPI {

    public init() {

    }

    public func search(keyword: String, page: Int, perPage: Int) -> Promise<PaginationResponse<Repository>> {
        return Promise { seal in
            if keyword == "Storage" {
                var repos = [Repository]()
                for i in 1...10 {
                    repos.append(Repository(id: i, nodeId: nil, name: nil, fullName: nil, owner: nil, private: nil, htmlUrl: nil, description: nil, fork: nil, url: nil, createdAt: nil, updatedAt: nil, pushedAt: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: nil, forksCount: nil, openIssuesCount: nil, masterBranch: nil, defaultBranch: nil, score: nil, archiveUrl: nil, assigneesUrl: nil, blobsUrl: nil, branchesUrl: nil, collaboratorsUrl: nil, commentsUrl: nil, commitsUrl: nil, compareUrl: nil, contentsUrl: nil, contributorsUrl: nil, deploymentsUrl: nil, downloadsUrl: nil, eventsUrl: nil, forksUrl: nil, gitCommitsUrl: nil, gitRefsUrl: nil, gitTagsUrl: nil, gitUrl: nil, issueCommentUrl: nil, issueEventsUrl: nil, issuesUrl: nil, keysUrlsUrl: nil, labelsUrl: nil, languagesUrl: nil, mergesUrl: nil, milestonesUrl: nil, notificationsUrl: nil, pullsUrl: nil, releasesUrl: nil, sshUrl: nil, stargazersUrl: nil, statusesUrl: nil, subscribersUrl: nil, subscriptionUrl: nil, tagsUrl: nil, teamsUrl: nil, treesUrl: nil, cloneUrl: nil, mirrorUrl: nil, hooksUrl: nil, svnUrl: nil, forks: nil, openIssues: nil, watchers: nil, hasIssues: nil, hasProjects: nil, hasPages: nil, hasWiki: nil, hasDownloads: nil, archived: nil, disabled: nil, license: nil))
                }
                seal.fulfill(PaginationResponse<Repository>.init(items: repos, totalCount: repos.count, incompleteResults: true, message: nil))
            } else if keyword == "Error" {
                seal.reject(CoreKitError.mock)
            }
        }
    }
}
