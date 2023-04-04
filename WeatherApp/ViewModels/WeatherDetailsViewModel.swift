//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by César Augusto Batista Santos on 22/02/23.
//

import Foundation
import Combine

public class WeatherDetailsViewModel: ObservableObject {
    private let weatherLogic: WeatherLogicImplementing
    private var subscriptions = Set<AnyCancellable>()
    private var weatherInfo: WeatherInfo?
    private var currentDay = 0
    
    @Published public var state: UiState = UiState()
    
    public init(weatherLogic: WeatherLogicImplementing) {
        self.weatherLogic = weatherLogic
    }
    
    public func onAppear() {
        weatherLogic.getWeatherByCity(cityCode: CityCode.Toronto)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                guard let self = self else { return }
                self.state = self.state.copy(loadableWeatherInfoDay: .loading)
            }, receiveCancel: { [weak self] in
                guard let self = self else { return }
                self.state = self.state.copy(loadableWeatherInfoDay: .initial)
            })
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):                    
                    guard let self = self else { return }
                    self.state = self.state.copy(loadableWeatherInfoDay: .failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weatherInfo in
                guard let self = self else { return }
                self.weatherInfo = weatherInfo
                self.updateState()
            })
            .store(in: &subscriptions)
    }
    
    private func updateState() {
        guard let weatherInfo = weatherInfo else { return }
        
        let weatherInfoDays = weatherInfo.weatherInfoDays[self.currentDay]
        self.state = self.state.copy(loadableWeatherInfoDay: .loaded(weatherInfoDays))
    }
    
    public func onSwipe(direction: SwipeDirection) {
        guard let weatherInfo = weatherInfo else { return }

        if direction == .left && self.currentDay < weatherInfo.weatherInfoDays.count-1 {
            self.currentDay = self.currentDay + 1
        } else if direction == .right && self.currentDay > 0 {
            self.currentDay = self.currentDay - 1
        } else {
            return
        }
        updateState()
    }
}

public extension WeatherDetailsViewModel {
    struct UiState {
        public let loadableWeatherInfoDay: LoadableObject<WeatherInfoDay, Error>
        
        public init(loadableWeatherInfoDay: LoadableObject<WeatherInfoDay, Error> = .initial) {
            self.loadableWeatherInfoDay = loadableWeatherInfoDay
        }
        
        public func copy(loadableWeatherInfoDay: LoadableObject<WeatherInfoDay, Error>? = nil) -> UiState {
            return UiState(loadableWeatherInfoDay: loadableWeatherInfoDay ?? self.loadableWeatherInfoDay)
        }
    }
}

