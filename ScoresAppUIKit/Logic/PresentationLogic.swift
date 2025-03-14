//
//  PresentationLogic.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

@MainActor
struct PresentationLogic {
    static let shared = PresentationLogic()
    
    let modelLogic = ModelLogic.shared
    
    func getListSubtitleCellConfiguration(text: String, secondaryText: String, image: String) -> UIListContentConfiguration {
        
        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = text
        configuration.secondaryText = secondaryText
        configuration.image = UIImage(named: image)
        configuration.imageProperties.cornerRadius = 10
        
        return configuration
    }
    
    func getMenuOrderBy() -> UIMenu {
        var uiActions: [UIAction] = []
        for option in SortedBy.allCases {
            let uiAction = UIAction(title: option.rawValue) { _ in
                modelLogic.orderBy = option
            }
            uiActions.append(uiAction)
        }
        return UIMenu(title: "Select order", children: uiActions)
    }
    
    func getComposerMenu(selectedComposer: String, _ action: @escaping (String) -> Void) -> UIMenu {
        var uiActions: [UIAction] = []
        for composer in modelLogic.composers {
            let uiAction = UIAction(title: composer, state: selectedComposer == composer ? .on : .off) { _ in
                action(composer)
            }
            uiActions.append(uiAction)
        }
        return UIMenu(title: "Select a new Composer", children: uiActions)
    }
    
    func getNewSearchController(placeholder: String) -> UISearchController {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = placeholder
        search.obscuresBackgroundDuringPresentation = false
        return search
    }
    
    func alertError(title: String, message: String) -> UIAlertController {
        let uiAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let uiAlertAction = UIAlertAction(title: "Ok", style: .default)
        
        uiAlertController.addAction(uiAlertAction)
        
        return uiAlertController
    }
}
