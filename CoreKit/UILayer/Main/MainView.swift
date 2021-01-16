//
//  MainView.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public enum MainView {
    case search

    public func hidesNavigationBar() -> Bool {
      switch self {
      default: return false
      }
    }
}

extension MainView: Equatable {
    public static func == (lhs: MainView, rhs: MainView) -> Bool {
        switch (lhs, rhs) {
        case (.search, .search): return true
        }
    }
}
