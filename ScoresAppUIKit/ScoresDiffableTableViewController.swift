//
//  ScoresDiffableTableViewController.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 14/3/25.
//

import UIKit

final class ScoresDiffableTableViewController: UITableViewController, ComposerSelectionDelegate {
    
    let logic = ModelLogic.shared
    
    lazy var dataSource: UITableViewDiffableDataSource<Int, Score> = {
        UITableViewDiffableDataSource<Int, Score>(tableView: tableView) { tableView, indexPath, score in
            let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath) as? ScoreTableViewCell
            
            cell?.scoreTitle.text = score.title
            cell?.year.text = score.yearS
            cell?.length.text = score.lengthS
            cell?.cover.image = UIImage(named: score.cover)
            
            return cell
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.dataSource = dataSource
        self.connectDelegate()
        
    }
    
    func connectDelegate() {
        guard let navigationCtrl = splitViewController?
            .viewControllers
            .first as? UINavigationController,
              
                let composerTable = navigationCtrl
            .topViewController as? ComposersTableViewController else { return }
        
        composerTable.delegate = self
    }
    
    func composerSelected(_ composer: String) {
        navigationItem.title = composer
        dataSource.apply(logic.snapshotForComposer(composer), animatingDifferences: false)
        if let score = dataSource.itemIdentifier(for: IndexPath(row: 0, section: 0)) {
            NotificationCenter.default.post(name: .scoreSelected, object: score)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let score = logic.getScoreByComposerWithIndexPath(composer: navigationItem.title, indexPath: indexPath)
        
        NotificationCenter.default.post(name: .scoreSelected, object: score)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let score = logic.getScoreByComposerWithIndexPath(composer: navigationItem.title,
                                                                indexPath: indexPath) else { return nil }
        let isFavorited = score.favorited
        let action = UIContextualAction(style: .normal,
                                        title: isFavorited ? "Unfavorited" : "Favorite") {[unowned self] _, _, result in
            
            logic.toggleFavorite(id: score.id)
            result(true)
        }
        action.image = UIImage(systemName: isFavorited ? "star" : "star.fill")
        action.backgroundColor = isFavorited ? .systemRed : .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }

}
