//
//  WeatherInfoDTO.swift
//  WeatherApp
//
//  Created by OakHost Customer on 22/02/2023.
//

import Foundation

public struct WeatherInfoDTO: Decodable {
    let title: String
    let weatherInfoDays: [WeatherInfoDayDTO]
    
    public init(title: String, weatherInfoDays: [WeatherInfoDayDTO]) {
        self.title = title
        self.weatherInfoDays = weatherInfoDays
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case weatherInfoDays = "consolidated_weather"
    }
}
