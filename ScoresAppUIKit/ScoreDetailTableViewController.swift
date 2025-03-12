//
//  ScoreDetailTableViewController.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 12/3/25.
//

import UIKit

class ScoreDetailTableViewController: UITableViewController {
    
    var score: Score?

    @IBOutlet weak var scoreTitle: UITextField!
    @IBOutlet weak var composer: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var lenght: UITextField!
    @IBOutlet weak var cover: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = score?.title
        
        loadDetails()
    }
    
    func loadDetails() {
        self.scoreTitle.text = score?.title
        self.composer.text = score?.composer
        self.year.text = score?.yearS
        self.lenght.text = score?.lengthS
        self.cover.image = UIImage(named: score?.cover ?? "")
    }
    
    @IBAction func saveScore(_ sender: UIBarButtonItem) {
    }
}
