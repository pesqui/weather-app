//
//  WeatherNetworkApiImplementing.swift
//  WeatherApp
//
//  Created by OakHost Customer on 21/02/2023.
//

import Foundation
import Combine

public protocol WeatherApiImplementing {
    func getWeatherByCity(cityCode: CityCode) -> AnyPublisher<WeatherInfoDTO, Error>
}
