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
}


extension ScoreTableViewControllerD {
    // Para el preview en UIKit, debemos entender y simular como funciona por debajo.
    // Por eso aqui creamos el Storyboard
    static var preview: UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
        
        let vc = nc.viewControllers.first as! ScoreTableViewControllerD
        
        vc.logic = ModelLogic.test
        
        return UINavigationController(rootViewController: vc)
    }
}
