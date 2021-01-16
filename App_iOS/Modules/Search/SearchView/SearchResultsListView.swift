//
//  SearchResultsListView.swift
//  App_iOS
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit
import AppUIKit
import SnapKit

final public class SearchResultsListView: NiblessView {

    // MARK: - Properties

    lazy var resultsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.searchResultCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset.top = 20
        tableView.tableFooterView = self.spinner
        return tableView
    }()

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: - Methods

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        backgroundColor = R.color.white()
        constructHierarchy()
        activateConstraints()
    }

    private func constructHierarchy() {
        addSubview(resultsTable)
    }

    private func activateConstraints() {
        spinner.frame = CGRect(origin: .zero, size: CGSize(width: resultsTable.bounds.width, height: CGFloat(44)))

        resultsTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}
