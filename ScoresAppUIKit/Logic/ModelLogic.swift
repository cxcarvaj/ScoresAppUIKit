//
//  ModelLogic.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

@MainActor
final class ModelLogic {
    static let shared = ModelLogic()
    
    private let repository: DataRepository
    private var scores: [Score]
    
    var numberOfSections: Int {
        Set(scores.map(\.composer)).count
    }
    
    private var scoresByComposers: [[Score]] {
        Dictionary(grouping: scores, by: \.composer).values.sorted { sc1, sc2 in
            sc1.first?.composer ?? "" <= sc2.first?.composer ?? ""
        }
    }
    
    private init(repository: DataRepository = Repository()) {
        self.repository = repository
        do {
            self.scores = try repository.getScores()
        } catch {
            self.scores = []
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        scoresByComposers[section].count
    }
    
    func scoreForRowAt(_ indexPath: IndexPath) -> Score {
        scoresByComposers[indexPath.section][indexPath.row]
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        scoresByComposers[section].first?.composer
    }
    
}

extension ModelLogic {
    static let test = ModelLogic(repository: RepositoryTest())
}
