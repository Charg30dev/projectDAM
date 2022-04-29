//
//  DetailSeriesRouter.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import UIKit


class DetailSeriesRouter {
    var viewController: UIViewController{
        return createViewController()
    }

    var serieID: String
    private var sourceView: UIViewController?
    
    init(serieID: String? = "") {
        self.serieID = serieID!
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
   private func createViewController() -> UIViewController{
       let view = DetailSeriesView(nibName: "DetailSeriesView", bundle: Bundle.main)
       view.serieID = self.serieID
       return view
    }
}
