//
//  CoreKitTests.swift
//  CoreKitTests
//
//  Created by Amr Salman on 1/13/21.
//

import Quick
import Nimble
import PromiseKit

@testable import CoreKit

class CoreKitTests: QuickSpec {
    override func spec() {
        describe("Search Repository") {
            let searchAPI = MockSearchAPI()
            let authAPI = GHAuthAPI()

            it("Results should not be empty") {
                //Arrange
                let sut = RSearchRepository(searchRemoteAPI: searchAPI, authRemoteAPI: authAPI)

                //Act
                var repositories = [Repository]()
                var error: Error? = nil
                sut.search(keyword: "Storage", page: 0, perPage: 20).done({ repositories = $0.items ?? [] }).catch({ error = $0 })

                //Assert
                expect(repositories.count).toEventually(beGreaterThanOrEqualTo(5))
                expect(error).toEventually(beNil())
            }

            it("Results should be empty") {
                //Arrange
                let sut = RSearchRepository(searchRemoteAPI: searchAPI, authRemoteAPI: authAPI)

                //Act
                var repositories = [Repository]()
                var error: Error? = nil
                sut.search(keyword: "", page: 0, perPage: 20).done({ repositories = $0.items ?? [] }).catch({ error = $0 })

                //Assert
                expect(repositories.count).toEventually(equal(0))
                expect(error).toEventually(beNil())
            }

            it("Should return error when pass wrong page number") {
                //Arrange
                let sut = RSearchRepository(searchRemoteAPI: searchAPI, authRemoteAPI: authAPI)

                //Act
                var repositories = [Repository]()
                var error: Error? = nil
                sut.search(keyword: "Storage", page: -2, perPage: 20).done({ repositories = $0.items ?? [] }).catch({ error = $0 })

                //Assert
                expect(repositories.count).toEventually(equal(0))
                expect(error).toEventually(matchError(CoreKitError.wrongPageNumber))
            }

            it("Should return error typing wrong query") {
                //Arrange
                let sut = RSearchRepository(searchRemoteAPI: searchAPI, authRemoteAPI: authAPI)

                //Act
                var repositories = [Repository]()
                var error: Error? = nil
                sut.search(keyword: "Error", page: 0, perPage: 20).done({ repositories = $0.items ?? [] }).catch({ error = $0 })

                //Assert
                expect(repositories.count).toEventually(equal(0))
                expect(error).toEventually(matchError(CoreKitError.mock))
            }

        }
    }
}
