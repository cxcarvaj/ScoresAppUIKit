//
//  NumberFormatter.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 13/3/25.
//

import Foundation

extension NumberFormatter {
    static let toNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
       return formatter
    }()
}
