//
//  RepositoryTest.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

struct RepositoryTest: DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "scoresdatatest",
                        withExtension: "json")!
    }
    
    var urlDoc: URL {
        URL.documentsDirectory.appending(path: "scoresdatatest").appendingPathExtension(for: .json)
    }
    
    func saveScores(_ scores: [Score]) throws {}
}


extension ScoreTableViewControllerD {
    // Para el preview en UIKit, debemos entender y simular como funciona por debajo.
    // Por eso aqui creamos el Storyboard
    static var preview: UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Sin Storyboard ID
//        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
//        
//        let vc = nc.viewControllers.first as! ScoreTableViewControllerD
        
        //Con Storyboard ID
        let vc = storyboard.instantiateViewController(withIdentifier: "ScoreTableViewControllerD") as! ScoreTableViewControllerD

        
        vc.logic = ModelLogic.test
        
        return UINavigationController(rootViewController: vc)
    }
}
