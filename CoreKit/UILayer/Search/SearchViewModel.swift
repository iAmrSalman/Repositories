//
//  SearchViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation
import RxRelay
import RxSwift
import PromiseKit

final public class SearchViewModel {

    // MARK: - Properties

    private let repository: SearchRepository
    private let responder: MainViewResponder
    private let errorMessagesSubject = PublishSubject<ErrorMessage>()
    private let isLoadingSubject = BehaviorSubject(value: false)
    private let repositoriesSubject = BehaviorSubject(value: [Repository]())
    private let disposeBag = DisposeBag()
    private var keyword = ""
    private var currentPage = -1
    private let perPage = 20
    private var isSearchComplete = false

    public var errorMessages: Observable<ErrorMessage> { return self.errorMessagesSubject.asObserver() }
    public var isLoading: Observable<Bool> { return self.isLoadingSubject.asObservable() }
    public var repositories: Observable<[Repository]> { return repositoriesSubject.asObservable() }
    public var searchKeyword = PublishRelay<String>()
    public var displayedResultIndex = PublishRelay<Int>()
    public var gotNewToken = PublishRelay<String>()

    // MARK: - Methods

    public init(repository: SearchRepository, responder: MainViewResponder) {
        self.responder = responder
        self.repository = repository
        searchKeyword
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.repositoriesSubject.onNext([])
                self?.search(keyword: $0)
            }).disposed(by: disposeBag)

        displayedResultIndex
            .asObservable()
            .filter { [weak self] index in
                guard let currentCount = try? self?.repositoriesSubject.value().count, index > 0 else { return false }
                return index == (currentCount - 1)
            }
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.loadMoreResults()
            }).disposed(by: disposeBag)

        gotNewToken
            .asObservable()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                self?.fetchToken(code: $0)
            }).disposed(by: disposeBag)
    }

    private func search(keyword: String, page: Int = 1) {
        self.keyword = keyword
        guard !keyword.isEmpty else {
            self.repositoriesSubject.onNext([])
            return
        }
        self.isLoadingSubject.onNext(true)
        repository
            .search(keyword: keyword,
                    page: page,
                    perPage: perPage)
            .done { [weak self] in
                guard let currentValue = try? self?.repositoriesSubject.value() else { return }
                let newValue = currentValue + ($0.items ?? [])
                self?.repositoriesSubject.onNext(newValue)
                self?.isSearchComplete = $0.incompleteResults ?? false
                self?.currentPage = page
            }
            .ensure { self.isLoadingSubject.onNext(false) }
            .catch {
                guard let error = $0 as? ErrorMessage else {
                    let errorMessage = ErrorMessage(title: "Error", message: "\($0.localizedDescription)")
                    self.present(errorMessage: errorMessage)
                    return
                }
                self.present(errorMessage: error)
            }


    }

    private func loadMoreResults() {
        guard !isSearchComplete, let isLoading = try? isLoadingSubject.value(), !isLoading else { return }
        let newPage = currentPage + 1
        guard newPage > 1 else { return }
        search(keyword: keyword, page: newPage)
    }

    private func fetchToken(code: String) {
        self.isLoadingSubject.onNext(true)
        repository
            .auth(code: code)
            .done { UserDefaults.standard.set($0.accessToken, forKey: "AccessToken") }
            .ensure { self.isLoadingSubject.onNext(false) }
            .catch {
                guard let error = $0 as? ErrorMessage else {
                    let errorMessage = ErrorMessage(title: "Error", message: "\($0.localizedDescription)")
                    self.present(errorMessage: errorMessage)
                    return
                }
                self.present(errorMessage: error)
            }
    }

    public func selectRepository(at index: Int) {

    }

    private func present(errorMessage: ErrorMessage) {
      errorMessagesSubject.onNext(errorMessage)
    }

}
