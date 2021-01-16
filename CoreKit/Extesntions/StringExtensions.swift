//
//  StringExtensions.swift
//  CoreKit
//
//  Created by Amr Salman on 1/16/21.
//

import Foundation

public extension String {
    func fuzzyContains(_ string: String) -> Bool {
        let charset = CharacterSet(charactersIn: string)
        return self.rangeOfCharacter(from: charset, options: .caseInsensitive) != nil
    }
}
