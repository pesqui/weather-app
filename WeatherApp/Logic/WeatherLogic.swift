//
//  WeatherServiceApi.swift
//  WeatherApp
//
//  Created by OakHost Customer on 21/02/2023.
//

import Foundation
import Combine

public class WeatherLogic: WeatherLogicImplementing {
    private let dataProvider: WeatherApiImplementing
    
    public init(dataProvider: WeatherApiImplementing) {
        self.dataProvider = dataProvider
    }
    
    public func getWeatherByCity(cityCode: CityCode) -> AnyPublisher<WeatherInfo, Error> {
        return self.dataProvider.getWeatherByCity(cityCode: cityCode)
            .map { weatherInfoDTO in
                let weatherInfoDays = weatherInfoDTO.weatherInfoDays.map { (weatherInfoDayDTO: WeatherInfoDayDTO) -> WeatherInfoDay in
                    let iconURL = NetworkUtils.formatIconURL(iconAbbr: weatherInfoDayDTO.weatherStateAbbr)
                    let weatherInfoDay = WeatherInfoDay(weatherStateName: weatherInfoDayDTO.weatherStateName,
                                                        minTemp: weatherInfoDayDTO.minTemp,
                                                        maxTemp: weatherInfoDayDTO.maxTemp,
                                                        temp: weatherInfoDayDTO.temp,
                                                        iconURL: iconURL)
                    return weatherInfoDay
                }
                let weatherInfo = WeatherInfo(title: weatherInfoDTO.title, weatherInfoDays: weatherInfoDays)
                
                return weatherInfo
            }
            .eraseToAnyPublisher()
    }
    
}
