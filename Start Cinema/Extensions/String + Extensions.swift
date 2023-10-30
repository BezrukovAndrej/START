//
//  String + Extensions.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
