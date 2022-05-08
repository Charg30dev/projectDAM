//
//  LoginRouter.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 7/5/22.
//

import Foundation
import UIKit

class LoginRouter {
    
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
    
    func loginUser() {
        let login = ListView()
        sourceView?.navigationController?.pushViewController(login, animated: true)
    }
}
