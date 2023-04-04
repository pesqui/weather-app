//
//  MockWeatherLogic.swift
//  WeatherAppTests
//
//  Created by César Augusto Batista Santos on 23/02/23.
//

import Foundation
import Combine
import WeatherApp


class MockWeatherLogic: WeatherLogicImplementing {
    private let success: Bool
    private let weatherInfo: WeatherInfo?
    
    init(success: Bool, weatherInfo: WeatherInfo? = nil) {
        self.success = success
        self.weatherInfo = weatherInfo
    }
    
    func getWeatherByCity(cityCode: CityCode) -> AnyPublisher<WeatherInfo, Error> {
        var publisher: AnyPublisher<WeatherInfo, Error>

        if success, let weatherInfo = weatherInfo {
            publisher = Just(weatherInfo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            publisher = Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        return publisher
    }
}
