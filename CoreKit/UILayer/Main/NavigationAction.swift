//
//  NavigationAction.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
  
  case present(view: ViewModelType)
  case presented(view: ViewModelType)
}
