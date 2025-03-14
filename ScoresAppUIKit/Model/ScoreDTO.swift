//
//  Score.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import Foundation

struct ScoreDTO: Codable {
    let id: Int
    let title: String
    let composer: String
    let year: Int
    let length: Double
    let cover: String
    let tracks: [String]
    
    var toScore: Score {
        Score(id: id,
              title: title,
              composer: composer,
              year: year,
              length: length,
              cover: cover,
              tracks: tracks,
              favorited: false)
    }
}

struct Score: Codable {
    let id: Int
    let title: String
    let composer: String
    let year: Int
    let length: Double
    let cover: String
    let tracks: [String]
    var favorited: Bool
}

extension Score {
    var lengthS: String {
        length.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 1)))
    }
    
    var yearS: String {
        year.formatted(.number.precision(.integerLength(4)))
    }
}
