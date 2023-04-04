//
//  ContentView.swift
//  WeatherApp
//
//  Created by OakHost Customer on 21/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherDetailsViewModel = WeatherDetailsViewModel(weatherLogic: InjectContainer.shared.weatherLogic)

    var body: some View {
        WeatherDetailsAdapter(viewModel: weatherDetailsViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
