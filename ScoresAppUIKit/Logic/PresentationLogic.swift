//
//  PresentationLogic.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

struct PresentationLogic {
    static let shared = PresentationLogic()
    
    func getListSubtitleCell(text: String, secondaryText: String, image: String) -> UIListContentConfiguration {
        
        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = text
        configuration.secondaryText = secondaryText
        configuration.image = UIImage(named: image)
        
        return configuration
    }
}
