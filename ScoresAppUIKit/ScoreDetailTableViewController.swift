//
//  ScoreDetailTableViewController.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 12/3/25.
//

import UIKit

@MainActor
final class ScoreDetailTableViewController: UITableViewController {
    let presentation = PresentationLogic.shared
    let modelLogic = ModelLogic.shared
    
    var score: Score?

    @IBOutlet weak var scoreTitle: UITextField!
    @IBOutlet weak var composer: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var lenght: UITextField!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var changeComposer: UIButton!
    @IBOutlet weak var tableTracks: TracksTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = score?.title
        self.loadDetails()
        
        changeComposer.menu = presentation.getComposerMenu(selectedComposer: composer.text ?? "") { composer in
            self.composer.text = composer
        }
        tableTracks.delegate = tableTracks
        tableTracks.dataSource = tableTracks
        tableTracks.tracks = score?.tracks ?? []
        tableTracks.reloadData()

    }
    
    func loadDetails() {
        self.scoreTitle.text = score?.title
        self.composer.text = score?.composer
        self.year.text = score?.yearS
        self.lenght.text = score?.lengthS
        self.cover.image = UIImage(named: score?.cover ?? "")
    }
    
    @IBAction func validateNumber(_ sender: UITextField) {
        if sender.tag == 1000 {
            if let text = sender.text {
                sender.text = text.filter { $0.isNumber }
                sender.text = String(sender.text?.prefix(4) ?? "")
            }
        } else {
            if let text = sender.text {
                sender.text = text.filter { $0.isNumber || $0 == "." }
                sender.text = String(sender.text?.prefix(5) ?? "")
            }
        }
        
    }
    
    @IBAction func saveScore(_ sender: UIBarButtonItem) {
        guard validateScore() else { return }
        
        modelLogic.updateScore(score: score,
                               title: scoreTitle.text,
                               composer: composer.text ?? "",
                               year: year.text,
                               length: lenght.text)
        performSegue(withIdentifier: "exitDetail", sender: nil)
    }
    
    func validateScore() -> Bool {
        var msg = ""
        if scoreTitle.text?.isEmpty ?? true {
            msg += "Title cannot be empty\n"
        }
        if let yearS = year.text, let yearValue = Int(yearS) {
            if yearValue < 1900 || yearValue > Calendar.current.component(.year, from: Date()) {
                msg += "Year must be between 1900 and \(Calendar.current.component(.year, from: Date()))\n"
            }
        }
        if let lengthS = lenght.text, let lengthValue = Double(lengthS) {
            if lengthValue < 1 || lengthValue > 500 {
                msg += "Score length must be between 1 and 500\n"
            }
        }
        if !msg.isEmpty {
            let alert = presentation.alertError(title: "Score validation error", message: String(msg.dropLast()))
            
            present(alert, animated: true)
        }
        return msg.isEmpty
    }
}
