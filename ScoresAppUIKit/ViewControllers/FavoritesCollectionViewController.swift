//
//  FavoritesCollectionViewController.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 13/3/25.
//

import UIKit

final class FavoritesCollectionViewController: UICollectionViewController {
    
    let logic = ModelLogic.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter
            .default
            .addObserver(forName: .reloadCollection,
                         object: nil,
                         queue: .main) { _ in
            Task { @MainActor in
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        logic.favoritesCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zelda", for: indexPath) as? FavoritesCollectionViewCell else { return UICollectionViewCell() }
        
        let score = logic.favorites[indexPath.row]
        cell.cover.image = UIImage(named: score.cover)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .reloadCollection, object: nil)
    }

}
