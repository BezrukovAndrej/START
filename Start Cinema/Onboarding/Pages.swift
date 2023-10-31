//
//  Pages.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 31.10.2023.
//

import Foundation

enum Pages: CaseIterable {
    case pageOne
    case pageTwo
    
    var title: String {
        switch self {
        case .pageOne:
            return "PAGE_ONE".localized
        case .pageTwo:
            return "PAGE_TWO".localized
        }
    }
    
    var index: Int {
        switch self {
        case .pageOne:
            return 0
        case .pageTwo:
            return 1
        }
    }
}
