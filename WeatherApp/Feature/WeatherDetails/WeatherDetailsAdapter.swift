//
//  WeatherDetailsAdapter.swift
//  WeatherApp
//
//  Created by César Augusto Batista Santos on 22/02/23.
//

import SwiftUI

public struct WeatherDetailsAdapter: View {
    @StateObject private var viewModel: WeatherDetailsViewModel
    
    public init(viewModel: WeatherDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        WeatherDetailsPage(state: viewModel.state, onSwipe: { direction in
            viewModel.onSwipe(direction: direction)
        })
            .onAppear {
                viewModel.onAppear()
            }
    }
}
