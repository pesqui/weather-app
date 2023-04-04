//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by OakHost Customer on 21/02/2023.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherLogicTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
    }

    func test_getWeatherByCity_whenFail_returnError() {
        // given
        let mock = MockWeatherApi(success: false)
        let sut = WeatherLogic(dataProvider: mock)
        let expec = expectation(description: "")
        var success = true
        
        // when
        sut.getWeatherByCity(cityCode: CityCode.Toronto)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail()
                    break
                case .failure:
                    success = false
                    expec.fulfill()
                }
            }, receiveValue: { _ in }
            ).store(in: &subscriptions)
        
        wait(for: [expec], timeout: 3.0)

        // then
        XCTAssertFalse(success)
    }

    func test_getWeatherByCity_whenSuccess_returnWeatherInfo() {
        // given
        let weatherInfoDayDTO = WeatherInfoDayDTO(weatherStateName: "Light Cloud",
                                               weatherStateAbbr: "lr",
                                               minTemp: 11.0,
                                               maxTemp: 17.0,
                                               temp: 16.0)
        let weatherInfoDTO = WeatherInfoDTO(title: "Toronto", weatherInfoDays: [weatherInfoDayDTO])
        let mock = MockWeatherApi(success: true, weatherInfoDTO: weatherInfoDTO)
        let sut = WeatherLogic(dataProvider: mock)
        let expec = expectation(description: "")
        var expectedWeatherInfo: WeatherInfo?
        
        // when
        sut.getWeatherByCity(cityCode: CityCode.Toronto)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            }, receiveValue: { value in
                expectedWeatherInfo = value
                expec.fulfill()
            }
            ).store(in: &subscriptions)
        
        wait(for: [expec], timeout: 3.0)
        
        // then
        XCTAssertNotNil(expectedWeatherInfo)
        XCTAssertEqual(expectedWeatherInfo?.title, "Toronto")
    }

}
