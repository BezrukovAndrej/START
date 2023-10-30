//
//  YoutubeSearchResponse.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 29.10.2023.
//

import Foundation

struct YoutubeSearchResponse: Decodable {
    let items: [VideoElement]
}

struct VideoElement: Decodable {
    let id: idVieoElement
}

struct idVieoElement: Decodable {
    let kind: String
    let videoId: String
}
