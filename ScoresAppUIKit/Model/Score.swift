//
//  Score.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import Foundation

struct Score: Codable {
    let id: Int
    let title: String
    let composer: String
    let year: Int
    let length: Double
    let cover: String
    let tracks: [String]
}

extension Score {
    var lengthS: String {
        length.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 1)))
    }
    
    var yearS: String {
        year.formatted(.number.precision(.integerLength(4)))
    }
}
