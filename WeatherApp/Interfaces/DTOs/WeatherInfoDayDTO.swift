//
//  WeatherInfoDayDTO.swift
//  WeatherApp
//
//  Created by OakHost Customer on 22/02/2023.
//

import Foundation

public struct WeatherInfoDayDTO: Decodable {
    let weatherStateName: String
    let weatherStateAbbr: String
    let minTemp: Float
    let maxTemp: Float
    let temp: Float
        
    public init(weatherStateName: String, weatherStateAbbr: String, minTemp: Float, maxTemp: Float, temp: Float) {
        self.weatherStateName = weatherStateName
        self.weatherStateAbbr = weatherStateAbbr
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.temp = temp
    }
    
    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case temp = "the_temp"
    }
}
