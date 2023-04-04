//
//  InjectContainer.swift
//  WeatherApp
//
//  Created by César Augusto Batista Santos on 23/02/23.
//

import Foundation


public struct InjectContainer {
    public let weatherApi: WeatherApi
    public let weatherLogic: WeatherLogic
    
    public static let shared = InjectContainer()

    private init() {
        self.weatherApi = WeatherApi()
        self.weatherLogic = WeatherLogic(dataProvider: self.weatherApi)
    }
}
