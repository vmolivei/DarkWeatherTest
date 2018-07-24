//
//  BlackSkyApi.swift
//  DarkSkyWeather
//
//  Created by Victor Martin on 5/22/18.
//  Copyright © 2018 Victor Martin. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

final class BlackSkyApi{
    
    static let shared = BlackSkyApi()
    
    //MARK: - Load Data From API
    
    // Load The Data(DarkSky) from API passing Location
    func loadData( for coordinate: CLLocationCoordinate2D,
                   completion: @escaping ((DarkSkyApiResponse) -> Void) ){
        
        let url = getUrl(with: formatString(coordinate))
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, res, err) in
            if err == nil{
               let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.decode(WeatherJson.self, from: data!)
                    completion(DarkSkyApiResponse.success(self.getBlackSkyDataFromApi(for: decodedData)))
                }catch{
                    completion(DarkSkyApiResponse.error(DarkSkyApiErros.serverError))
                }
            }else{
                completion(DarkSkyApiResponse.error(DarkSkyApiErros.fileNotFound))
            }
        }).resume()
    }
    
    //MARK: - CLGeocoder Location
    
    //GET Location from Place Name, Returns DarkSkyApiResponse with Location
    func getLocationFromCity(for city: String, completion: @escaping ((DarkSkyApiResponse) -> Void) ){
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(city, completionHandler: { data, err in
            if err == nil{
                if let marks = data{
                    let coord = marks.first?.location?.coordinate
                    completion(DarkSkyApiResponse.success(coord as Any))
                }
            }else{
                completion(DarkSkyApiResponse.error(DarkSkyApiErros.fileNotFound))
            }
        })
    }
    
    //MARK: - Helpers
    
    func getBlackSkyDataFromApi(for data: WeatherJson) -> BlackSky{
        let iconPath = Constants.WeatherTypes(rawValue: data.currently.icon)?.getImageName()
        let image = UIImage(named: iconPath!)
        return BlackSky(weather: data.currently, city: nil, weatherIcon: image!)
    }
    
    func getUrl(with city: String) -> URL? {
        return URL(string: city)
    }
    
    func formatString(_ coordinate: CLLocationCoordinate2D) -> String{
        return String(format: Constants.darkSkyURL, Constants.darkSkyKey,
                      String(coordinate.latitude), String(coordinate.longitude) )
    }
    
}
