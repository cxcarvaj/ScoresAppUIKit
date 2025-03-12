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
        
        return configuration
    }
    
    func getMenuOrderBy() -> UIMenu {
        var actions: [UIAction] = []
        for option in SortedBy.allCases {
            let action = UIAction(title: option.rawValue) { _ in
                modelLogic.orderBy = option
            }
            actions.append(action)
        }
        return UIMenu(title: "Select order", children: actions)
    }
}
