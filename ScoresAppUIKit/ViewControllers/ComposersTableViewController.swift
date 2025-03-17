//
//  ComposersTableViewController.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 14/3/25.
//

import UIKit

@MainActor
protocol ComposerSelectionDelegate {
    func composerSelected(_ composer: String)
}

final class ComposersTableViewController: UITableViewController {
    let logic = ModelLogic.shared
    
    var delegate: ComposerSelectionDelegate?
    
    lazy var dataSource: UITableViewDiffableDataSource<Int, String> = {
        UITableViewDiffableDataSource<Int, String>(tableView: tableView) { tableView, indexPath, composer in
            let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath) as? ComposerTableViewCell
            
            cell?.name.text = composer
            cell?.cover.image = UIImage(named: composer)
            
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        
        tableView.dataSource = dataSource
        initDataSource()
    }
    
    func initDataSource() {
        dataSource.apply(logic.getComposerSnapshot)
        
        if let composer = dataSource.itemIdentifier(for: IndexPath(row: 0, section: 0)) {
            delegate?.composerSelected(composer)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.composerSelected(logic.composerSelected(indexPath: indexPath))
    }
    
}
