//
//  DetailSeriesView.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import UIKit
import RxSwift

class DetailSeriesView: UIViewController {

//    MARK: - Outlets
    
    @IBOutlet private weak var titleSerie: UILabel!
    @IBOutlet private weak var imageSerie: UIImageView!
    @IBOutlet private weak var sinopsisLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    
//    MARK: - Variables
    
    private var router = DetailSeriesRouter()
    private var viewModel = DetailSeriesViewModel()
    private var disposeBag = DisposeBag()
    var serieID: String?
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataAndShowDetailSeries()
        viewModel.bind(view: self, router: router)
        
    }
//    MARK: - Functions
    
    private func getDataAndShowDetailSeries() {
        guard let idSerie = serieID else { return }
        return viewModel.getSerieData(serieID: idSerie).subscribe(
            onNext: { serie  in
                self.showSerieData(serie: serie)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            
        }).disposed(by: disposeBag)
    }
    
    func showSerieData(serie: SeriesDetail) {
        DispatchQueue.main.async {
            self.titleSerie.text = serie.title
            self.imageSerie.imageFromServerURL(urlString: Constants.mainURL.urlImage+serie.imageSerie
                                            , placeholderImage: UIImage(named: "claqueta")!)
            self.sinopsisLabel.text = serie.sinopsis
            self.releaseDateLabel.text = serie.releaseDate
            self.voteAverageLabel.text = String(serie.voteAverage)
        }
    }
}
