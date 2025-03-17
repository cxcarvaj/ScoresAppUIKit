//
//  ScoreTableViewCell.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 14/3/25.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var scoreTitle: UILabel!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        cover.image = nil
        scoreTitle.text = nil
        year.text = nil
        length.text = nil
    }
}
