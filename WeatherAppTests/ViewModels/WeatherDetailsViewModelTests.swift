//
//  WeatherDetailsViewModelTests.swift
//  WeatherAppTests
//
//  Created by César Augusto Batista Santos on 23/02/23.
//

import XCTest
import Combine
@testable import WeatherApp

class WeatherDetailsViewModelTests: XCTestCase {
    private var weatherInfo: WeatherInfo!
    private var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        let weatherInfoDay = WeatherInfoDay(weatherStateName: "Light Cloud",
                                               minTemp: 11.0,
                                               maxTemp: 17.0,
                                               temp: 16.0,
                                               iconURL: NetworkUtils.formatIconURL(iconAbbr: "lr"))
        self.weatherInfo = WeatherInfo(title: "Toronto", weatherInfoDays: [weatherInfoDay])
    }

    func test_weatherDetailsViewModel_whenCreated_stateIsInitial() {
        // given
        let mock = MockWeatherLogic(success: true, weatherInfo: self.weatherInfo)
        
        // when
        let sut = WeatherDetailsViewModel(weatherLogic: mock)
        
        // then
        XCTAssertEqual(sut.state.loadableWeatherInfoDay, .initial)
    }
}
