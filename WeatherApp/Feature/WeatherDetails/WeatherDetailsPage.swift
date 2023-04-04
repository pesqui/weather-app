//
//  WeatherDetailsPage.swift
//  WeatherApp
//
//  Created by OakHost Customer on 22/02/2023.
//

import SwiftUI

public struct WeatherDetailsPage: View {
    private let state: WeatherDetailsViewModel.UiState
    private let onSwipe: ((SwipeDirection) -> Void)?
    
    public init(state: WeatherDetailsViewModel.UiState, onSwipe: ((SwipeDirection) -> Void)? = nil) {
        self.state = state
        self.onSwipe = onSwipe
    }

    public var body: some View {
        VStack {
            switch state.loadableWeatherInfoDay {
            case .loading:
                loading()
            case .loaded(let weatherInfoDay):
                content(weatherInfoDay: weatherInfoDay)
            case .failure(let error):
                errorMsg(error)
            default:
                EmptyView()
            }
        }
    }
    
    @ViewBuilder func content(weatherInfoDay: WeatherInfoDay) -> some View {
        VStack {
            HStack {
                Text("Toronto")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(14)
            .padding(.top, 40)
            HStack {
                VStack(spacing: 0) {
                    HStack {
//                        AsyncImage(url: URL(string: weatherInfoDay.iconURL)) { image in
//                            image.resizable()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(width: 60, height: 60)
                        Image(systemName: "cloud")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("\(weatherInfoDay.temp.intRounded)°")
                            .font(.system(size: 68, weight: .medium))
                    }
                    .padding(.bottom, 14)
                    Text(weatherInfoDay.weatherStateName)
                        .font(.headline)
                        .padding(.bottom, 10)
                    HStack {
                        Text("L:")
                        Text("\(weatherInfoDay.minTemp.intRounded)°")
                        Text("H:")
                        Text("\(weatherInfoDay.maxTemp.intRounded)°")
                    }
                    .font(Font.title2.weight(.medium))
                    
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .gesture(DragGesture(minimumDistance: 50.0, coordinateSpace: .local)
                .onEnded { value in
                    guard abs(value.startLocation.y - value.location.y) <= 50 else { return }
                    
                    if value.startLocation.x > value.location.x {
                        self.onSwipe?(.left)
                    } else {
                        self.onSwipe?(.right)
                    }
                }
        )
    }
    
    @ViewBuilder func loading() -> some View {
        ProgressView()
            .scaleEffect(2)
    }

    @ViewBuilder func errorMsg(_ error: Error) -> some View {
        VStack {
            Spacer()
                .frame(height: 150)
            HStack {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 30))
                Text(error.localizedDescription)
            }
            Spacer()
        }
    }
}

struct WeatherDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        let weatherInfoDay = WeatherInfoDay(weatherStateName: "Light Cloud",
                                            minTemp: 11.0,
                                            maxTemp: 17.0,
                                            temp: 16.0,
                                            iconURL: NetworkUtils.formatIconURL(iconAbbr: "lc"))
        let state = WeatherDetailsViewModel.UiState(loadableWeatherInfoDay: .loaded(weatherInfoDay))
        WeatherDetailsPage(state: state)
    }
}
