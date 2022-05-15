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
       let view = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
       return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func  navigateToDetailSeriesView(serieID: String) {
        let detailView = DetailSeriesRouter(serieID: serieID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func loginUser() {
        let login = ListView()
        sourceView?.navigationController?.pushViewController(login, animated: true)
    }
}

