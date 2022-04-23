//
//  ListRouter.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import Foundation
import UIKit

class ListRouter{
    var viewController: UIViewController{
        return createViewController()
    }

    private var sourceView: UIViewController?
    
   private func createViewController() -> UIViewController{
       let view = ListView(nibName: "ListView", bundle: Bundle.main)
       return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
}

