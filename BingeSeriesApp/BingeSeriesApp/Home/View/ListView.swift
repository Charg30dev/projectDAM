//
//  ListView.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import UIKit
import RxSwift
import RxCocoa

class ListView: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    private var router = ListRouter()
    private var viewModel = ListViewModel()
    private var disposeBag = DisposeBag()
    private var series = [Serie]()
    private var filteredSeries = [Serie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar una serie"
        
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BingeSeries"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
        manageSearchBarController()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomSerieTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomSerieTableViewCell")
    }
    
    private func getData() {
        return viewModel.getListSeriesData()
        //Manejar la concurrencia o hilos de RXSwift
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        
        //Obsevable
            .subscribe (
                onNext: { series in
                    self.series = series
                    self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
// Reactividad para la barra de búsqueda
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { (result) in
                self.filteredSeries = self.series.filter({ serie in
                    self.reloadTableView()
                    return serie.title.contains(result)
                })
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Extensions

extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredSeries.count
        } else {
            return self.series.count
        }
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomSerieTableViewCell.self)) as! CustomSerieTableViewCell
   
    if searchController.isActive && searchController.searchBar.text != "" {
    cell.imageSeries.imageFromServerURL(urlString: "\(Constants.mainURL.urlImage+self.filteredSeries[indexPath.row].image)",
                                       placeholderImage: UIImage(named: "claqueta")!)
    cell.titleSerie.text = filteredSeries[indexPath.row].title
    cell.descriptionSerie.text = filteredSeries[indexPath.row].sinopsis
    }
    else {
        cell.imageSeries.imageFromServerURL(urlString: "\(Constants.mainURL.urlImage+self.series[indexPath.row].image)",
                                           placeholderImage: UIImage(named: "claqueta")!)
        cell.titleSerie.text = series[indexPath.row].title
        cell.descriptionSerie.text = series[indexPath.row].sinopsis
    }
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.makeDetailView(serieID: String(self.filteredSeries[indexPath.row].serieID))
        } else {
            viewModel.makeDetailView(serieID: String(self.series[indexPath.row].serieID))
        }
    }
}

extension ListView: UISearchControllerDelegate {
    func  searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchController.isActive = false
        reloadTableView()
    }
}
