//
//  ErrorModel.swift
//  DarkSkyWeather
//
//  Created by Victor Martin on 5/23/18.
//  Copyright © 2018 Victor Martin. All rights reserved.
//

import Foundation

enum DarkSkyApiResponse{
    case success(Any)
    case error(DarkSkyApiErros)
}

enum DarkSkyApiErros: Error{
    case fileNotFound
    case serverError
    
    var localizedDescription: String{
        switch self {
        case .fileNotFound:
            return "Sorry Destination Not Found!"
        default:
            return "Server Error, please contact Admin!"
        }
    }
}
