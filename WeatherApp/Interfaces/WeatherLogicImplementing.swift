//
//  WeatherServiceApiImplementing.swift
//  WeatherApp
//
//  Created by OakHost Customer on 21/02/2023.
//

import Foundation
import Combine

public protocol WeatherLogicImplementing {
    func getWeatherByCity(cityCode: CityCode) -> AnyPublisher<WeatherInfo, Error>
}
