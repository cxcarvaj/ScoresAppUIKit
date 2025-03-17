//
//  ScoreTableViewControllerD.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

final class ScoreTableViewControllerD: UITableViewController, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            
    }
    
    
    var logic = ModelLogic.shared
    let presentation = PresentationLogic.shared

    @IBOutlet weak var orderByButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.prefetchDataSource = self
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = editButtonItem
        
        orderByButton.menu = presentation.getMenuOrderBy()
        configureSearchBar()
        
        NotificationCenter.default.addObserver(forName: .reloadTable,
                                               object: nil,
                                               queue: .main) { _ in
            Task { @MainActor in
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        logic.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logic.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
        let score = logic.scoreForRowAt(indexPath)
        
        cell.contentConfiguration = presentation.getListSubtitleCellConfiguration(
            text: score.title,
            secondaryText: score.composer,
            image: score.cover)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        logic.titleForHeaderInSection(section)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         true
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            logic.deleteScoreAt(indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
//        else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let score = logic.scoreForRowAt(indexPath)
        let isFavorited = score.favorited
        let action = UIContextualAction(style: .normal,
                                        title: isFavorited ? "Unfavorited" : "Favorite") {[unowned self] _, _, result in
            
            logic.toggleFavorite(id: score.id)
            result(true)
        }
        action.image = UIImage(systemName: isFavorited ? "star" : "star.fill")
        action.backgroundColor = isFavorited ? .gray : .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    @IBSegueAction func goToDetails(_ coder: NSCoder) -> ScoreDetailTableViewController? {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        let score = logic.scoreForRowAt(indexPath)
        let detail = ScoreDetailTableViewController(coder: coder)
        
        detail?.score = score
        return detail
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .reloadTable,
                                                  object: nil)
    }
    
    @IBAction func exitDetail(segue: UIStoryboardSegue) {
        guard let source = segue.source as? ScoreDetailTableViewController,
              let score = source.score,
              let indexPath = logic.getIndexPathForScore(score)
        else { return }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}

@available(iOS 17.0, *)
#Preview {
    ScoreTableViewControllerD.preview
}

extension ScoreTableViewControllerD: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        logic.searchTerm = searchController.searchBar.text ?? ""
    }
    
    func configureSearchBar() {
        navigationItem.searchController = presentation.getNewSearchController(placeholder: "Enter the score name")
        navigationItem.searchController?.searchResultsUpdater = self
    }
}
