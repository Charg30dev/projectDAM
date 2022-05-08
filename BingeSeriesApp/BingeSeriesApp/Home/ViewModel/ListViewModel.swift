//
//  ListViewModel.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import Foundation
import RxSwift


class ListViewModel {
    
    private weak var view: ListView?
    private var router: ListRouter?
    private var managerConnections = ManagerConnections()
    
    func bind(view: ListView, router: ListRouter) {
        
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getListSeriesData() -> Observable<[Serie]>{
        return managerConnections.getSeriesList()
    }
    
    func makeDetailView(serieID: String) {
        router?.navigateToDetailSeriesView(serieID: serieID)
    }
}
