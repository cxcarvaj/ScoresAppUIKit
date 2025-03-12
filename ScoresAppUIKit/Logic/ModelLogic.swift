//
//  ModelLogic.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

enum SortedBy: String, CaseIterable {
    case byID = "Order by Default"
    case ascending = "Order by Title ascending"
    case descending = "Order by Title descending"
}

@MainActor
final class ModelLogic {
    static let shared = ModelLogic()
    
    private let repository: DataRepository
    private var scores: [Score] {
        didSet {
            try? repository.saveScores(scores)
        }
    }
    
    var orderBy: SortedBy = .byID {
        didSet {
            NotificationCenter.default.post(name: .reloadTable, object: nil)
        }
    }
    
    var numberOfSections: Int {
        Set(scores.map(\.composer)).count
    }
    
    var searchTerm = "" {
        didSet {
            NotificationCenter.default.post(name: .reloadTable, object: nil)
        }
    }
    
    private var scoresByComposers: [[Score]] {
        let groupedScores = groupScoresByComposer()
        let sortedScores = sortGroupedScores(groupedScores)
        return filterAndSortScores(sortedScores)
    }

    // Agrupa los scores por compositor
    private func groupScoresByComposer() -> [String: [Score]] {
        return Dictionary(grouping: scores, by: \.composer)
    }

    // Ordena los scores agrupados por el nombre del compositor
    private func sortGroupedScores(_ groupedScores: [String: [Score]]) -> [[Score]] {
        return groupedScores.values
            .sorted { ($0.first?.composer ?? "") < ($1.first?.composer ?? "") }
    }

    // Filtra y ordena los scores según la búsqueda y el criterio de orden
    private func filterAndSortScores(_ scores: [[Score]]) -> [[Score]] {
        return scores.map { scoreGroup in
            let filteredScores = filterScores(scoreGroup)
            return sortScores(filteredScores)
        }
    }

    // Filtra los scores según la búsqueda
    private func filterScores(_ scores: [Score]) -> [Score] {
        return scores.filter { score in
            if searchTerm.isEmpty {
                return true
            } else {
                return score.title.range(of: searchTerm, options: [.caseInsensitive, .diacriticInsensitive, .anchored]) != nil
            }
        }
    }

    // Ordena los scores según el criterio establecido
    private func sortScores(_ scores: [Score]) -> [Score] {
        return scores.sorted {
            switch orderBy {
                case .byID:
                    return $0.id < $1.id
                case .ascending:
                    return $0.title < $1.title
                case .descending:
                    return $0.title > $1.title
            }
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
    
    func deleteScoreAt(_ indexPath: IndexPath) {
        let targetScoreId = scoresByComposers[indexPath.section][indexPath.row].id
        if let index = scores.firstIndex(where: { $0.id == targetScoreId }) {
            scores.remove(at: index)
        }
    }
    
}

extension ModelLogic {
    static let test = ModelLogic(repository: RepositoryTest())
}
