//
//  ManagerConnections.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import Foundation
import RxSwift

class ManagerConnections {
    
    func getSeriesList() -> Observable<[Serie]> {
        
        return Observable.create { observer in
            
        let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.mainURL.main+Constants.EndPoints.urlListSeries+Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let series = try decoder.decode(Series.self, from: data)
                    print("\(series.listOfSeries[0])")
                    
                    observer.onNext(series.listOfSeries)
                } catch let error {
                    observer.onError(error)
                    print(error)
                }
            } else if response.statusCode == 401 {
                print("Error 401")
            }
            observer.onCompleted()
            }.resume()
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
