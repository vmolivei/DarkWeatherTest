//
//  ViewModel.swift
//  DarkSkyWeather
//
//  Created by Victor Martin on 5/22/18.
//  Copyright © 2018 Victor Martin. All rights reserved.
//

import Foundation
import CoreLocation

// View Controller CompletionHandler
typealias viewControllerHandler = ((BlackSky?, DarkSkyApiErros?) -> Void)

class ViewModel{
    
    var data : BlackSky?
    
    //MARK: - Load Data From Api
    
    func loadData(city: String, completion:@escaping  viewControllerHandler){
        
        //First Get Location from City Name
        BlackSkyApi.shared.getLocationFromCity(for: city, completion: {(result) in
            switch result{
                case .error(let err):
                    completion(nil, err)
                case .success(let data): // Call Api to load Data
                    self.loadDataFromApi(location: self.unwrapLocation(from: data)!,
                                         completion: completion)
            }
        })
    }
    
    // Get Data from API passing the Location
    func loadDataFromApi(location: CLLocationCoordinate2D,
                         completion: @escaping viewControllerHandler){
        BlackSkyApi.shared.loadData(for: location, completion: { (res) in
            switch res{
                case .error(let err):
                    completion(nil, err)
                case .success(let data):
                    completion(self.unwrapBlackSkyDataFromResult(with: data), nil)
            }
        })
    }
    
    //MARK: - Data Unwrapers
    
    func unwrapLocation(from data: Any) -> CLLocationCoordinate2D?{
        if let coordinate =  data as? CLLocationCoordinate2D{
            return coordinate
        }
        return nil
    }
    
    func unwrapBlackSkyDataFromResult(with data: Any) -> BlackSky?{
        if let skyData =  data as? BlackSky{
            return skyData
        }
        return nil
    }
    
}
