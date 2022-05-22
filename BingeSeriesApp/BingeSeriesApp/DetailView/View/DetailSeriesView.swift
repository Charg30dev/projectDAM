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
    @IBOutlet weak var likeButton: UIButton!
    
    
//    MARK: - Variables
    
    private var router = DetailSeriesRouter()
    private var viewModel = DetailSeriesViewModel()
    private var disposeBag = DisposeBag()
    var serieID: String?
    
    private let unlikedImage = UIImage(named: "heart_empty")
    private let likedImage = UIImage(named: "heart_fill")
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataAndShowDetailSeries()
        viewModel.bind(view: self, router: router)

        if UserDefaults.standard.string(forKey: "saved") == serieID! {
            self.likeButton.setImage(likedImage, for: .normal)
        } else {
            self.likeButton.setImage(unlikedImage, for: .normal)
        }
        
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
    
    @IBAction func backButton(_ sender: Any) {
        
        viewModel.toGoBackMenu()
    }
    
    @IBAction func addToLikeAction(_ sender: Any) {
        
        if self.likeButton.tag == 0{

            self.likeButton.setImage(likedImage, for: .normal)
            self.likeButton.tag = 1
            
            print(serieID!)
            UserDefaults.standard.set(serieID, forKey: "saved")
            UserDefaults.standard.synchronize()
            
        } else {

            self.likeButton.setImage(unlikedImage, for: .normal)
            self.likeButton.tag = 0
            
            print(serieID!)
            UserDefaults.standard.set(serieID, forKey: "saved")
            UserDefaults.standard.synchronize()
            
        }
    }
}
