//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by César Augusto Batista Santos on 22/02/23.
//

import Foundation
import Combine

public class WeatherApi: WeatherApiImplementing {
    public func getWeatherByCity(cityCode: CityCode) -> AnyPublisher<WeatherInfoDTO, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn.faire.com"
        components.path = "/static/mobile-take-home/\(cityCode.rawValue).json"
        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var task: URLSessionDataTask!
        
        return Deferred {
            Future<WeatherInfoDTO, Error> { promise in
                task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                        promise(.failure(NetworkError.invalidResponse))
                        return
                    }
                    
                    do {
                        let weatherInfoDTO = try JSONDecoder().decode(WeatherInfoDTO.self, from: data)
                        promise(.success(weatherInfoDTO))
                    } catch {
                        promise(.failure(NetworkError.invalidResponse))
                    }
                }
                task.resume()
            }
        }
        .eraseToAnyPublisher()
    }
}
