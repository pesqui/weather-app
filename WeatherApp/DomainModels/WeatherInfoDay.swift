//
//  WeatherInfoDay.swift
//  WeatherApp
//
//  Created by OakHost Customer on 22/02/2023.
//

import Foundation

public struct WeatherInfoDay: Equatable {
    let weatherStateName: String
    let minTemp: Float
    let maxTemp: Float
    let temp: Float
    let iconURL: String
}
