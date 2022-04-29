//
//  DetailSeriesViewModel.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import Foundation
import RxSwift


class DetailSeriesViewModel {
    
    private var managerConnection = ManagerConnections()
    private(set) weak var view: DetailSeriesView?
    private var router: DetailSeriesRouter?
    
    func bind(view: DetailSeriesView, router: DetailSeriesRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getSerieData(serieID: String) -> Observable <SeriesDetail> {
        return managerConnection.getDetailSeries(serieID: serieID)
    }
}
