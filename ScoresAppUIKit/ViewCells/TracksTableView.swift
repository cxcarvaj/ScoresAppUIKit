//
//  TracksTableView.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 13/3/25.
//

import UIKit

final class TracksTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var tracks: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        var content = UIListContentConfiguration.cell()
        content.text = tracks[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    


}
