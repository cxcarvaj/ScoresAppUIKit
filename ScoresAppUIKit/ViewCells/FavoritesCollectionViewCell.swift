//
//  FavoritesCollectionViewCell.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 13/3/25.
//

import UIKit

final class FavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cover: UIImageView!
    
    override func prepareForReuse() {
        cover.image = nil
    }
    
}
