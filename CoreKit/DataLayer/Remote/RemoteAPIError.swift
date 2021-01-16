//
//  RemoteAPIError.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

internal enum RemoteAPIError: Error {
  
  case unknown
  case createURL
  case httpError
  case parsingError
}
