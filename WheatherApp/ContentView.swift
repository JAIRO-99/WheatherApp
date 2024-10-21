//
//  ContentView.swift
//  WheatherApp
//
//  Created by Jairo Laurente Celis on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    var body: some View {
        VStack {
            
            Text("\(viewModel.locationName)")
                .foregroundColor(.blue)
            Text("\(viewModel.getWeatherWithLatAndLon(lat: 19.342, lon: -101.1234))")
                .foregroundColor(.blue)
        }
        .padding()
        .onAppear{
            viewModel.getWeatherWithLatAndLon(lat: 19.342, lon: -101.1234)
        }
    }
}

#Preview {
    ContentView()
}
