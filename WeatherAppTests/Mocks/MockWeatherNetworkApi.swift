//
//  MockWeatherNetworkApi.swift
//  WeatherAppTests
//
//  Created by OakHost Customer on 21/02/2023.
//

import Foundation
import Combine
import WeatherApp

class MockWeatherApi: WeatherApiImplementing {
    private let success: Bool
    private let weatherInfoDTO: WeatherInfoDTO?
    
    init(success: Bool, weatherInfoDTO: WeatherInfoDTO? = nil) {
        self.success = success
        self.weatherInfoDTO = weatherInfoDTO
    }
    
    func getWeatherByCity(cityCode: CityCode) -> AnyPublisher<WeatherInfoDTO, Error> {
        var publisher: AnyPublisher<WeatherInfoDTO, Error>

//        if success {
//            publisher = Just(self.weatherInfoDTO ?? WeatherInfoDTO()
//                .setFailureType(to: Error.self)
//                .eraseToAnyPublisher()
//        } else {
            publisher = Fail(error: SearchError.notFound).eraseToAnyPublisher()
//        }
        
        return publisher
    }
    
}
