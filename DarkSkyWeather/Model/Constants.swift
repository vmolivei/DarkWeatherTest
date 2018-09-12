//
//  Constants.swift
//  DarkSkyWeather
//
//  Created by Victor Martin on 5/22/18.
//  Copyright © 2018 Victor Martin. All rights reserved.
//

import Foundation

struct Constants{
    static let darkSkyKey = "d8ea6e5ac150f885c4c691db2e876f60"
    static let darkSkyURL = "https://api.darksky.net/forecast/%@/%@,%@"
    static let darkSkyURL2 = "https://api.darksky.net/forecast/%@/%@,%@"
    static let AdarkSkyURL = "https://api.darksky.net/forecast/%@/%@,%@"
    
    enum WeatherTypes: String{
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partCloudyDay = "partly-cloudy-day"
        case partCloudyNight = "partly-cloudy-night"
        case hail = "hail"
        case thunderStorm = "thunderstorm"
        case tornado = "tornado"
        
        func getImageName() -> String{
            switch self {
                case .clearDay:
                    return "clearDay"
                case .clearNight:
                    return "clearNight"
                case .rain:
                    return "rain"
                case .snow:
                    return "snow"
                case .sleet:
                    return "sleet"
                case .wind:
                    return "wind"
                case .fog:
                    return "fog"
                case .cloudy:
                    return "cloudy"
                case .partCloudyDay:
                    return "partCloudyDay"
                case .partCloudyNight:
                    return "partCloudyNight"
                case .hail:
                    return "hail"
                case .thunderStorm:
                    return "thunderStorm"
                case .tornado:
                    return "tornado"
            }
        }
    }
}
