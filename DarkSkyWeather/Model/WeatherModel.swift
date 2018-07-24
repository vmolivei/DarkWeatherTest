//
//  Weather.swift
//  DarkSkyWeather
//
//  Created by Victor Martin on 5/22/18.
//  Copyright © 2018 Victor Martin. All rights reserved.
//

import Foundation
import UIKit

struct WeatherJson: Codable {
    var currently: Weather
}

struct Weather: Codable {
    var summary: String
    var windSpeed: Double
    var temperature: Double
    var icon: String
    var humidity : Double
}

struct BlackSky {
    var weather: Weather
    var city: String?
    var weatherIcon: UIImage
}
