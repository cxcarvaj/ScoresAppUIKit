//
//  ScoreDetailViewController.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 14/3/25.
//

import UIKit

class ScoreDetailViewController: UIViewController {

    @IBOutlet weak var scoreTitle: UITextField!
    @IBOutlet weak var composer: UITextField!
    @IBOutlet weak var composerCover: UIImageView!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var cover: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .scoreSelected, object: nil, queue: .main) { notifaction in
            
            guard let scoreObject = notifaction.object as? Score?, let scoreObject else { return }
            
            Task {@MainActor [self] in
                setSelectedScore(score: scoreObject)
            }
            
            
        }

    }
    
    func setSelectedScore(score: Score) {
        scoreTitle.text = score.title
        composer.text = score.composer
        year.text = score.yearS
        length.text = score.lengthS
        composerCover.image = UIImage(named: score.composer)
        cover.image = UIImage(named: score.cover)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .scoreSelected, object: nil)
    }
}
