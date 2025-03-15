//
//  ComposerTableViewCell.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 14/3/25.
//

import UIKit

class ComposerTableViewCell: UITableViewCell {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        cover.image = nil
        name.text = nil
    }

}
