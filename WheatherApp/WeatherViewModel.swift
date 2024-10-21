//
//  WeatherViewModel.swift
//  WheatherApp
//
//  Created by Jairo Laurente Celis on 21/10/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var currentTemperature: String = "--"
    @Published var weatherDescription: String = ""
    @Published var weatherId: Int = 800
    @Published var locationName: String = ""
    @Published var searchQuery: String = ""
    @Published var isSearching: Bool = false
    @Published var isDayTime: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var weatherService = WeatherService()
    
    func getWeatherWithLatAndLon(lat: Double, lon: Double) {
        isSearching = true
        
        weatherService.getWeatherData(lat: lat, long: lon)
            .sink { completion in
                self.isSearching = false
                if case .failure(let error) = completion {
                    print("Error fetching weather: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.updateWeatherData(response: response)
                self.isSearching = false
            }
            .store(in: &cancellables)

    }
    
    func updateWeatherData(response: WeatherModel) {
        self.currentTemperature = "\(Int(response.main.temp))°C"
        self.weatherDescription = response.weather.first?.description.capitalized ?? "Noned"
        self.locationName = response.name
        self.weatherId = response.weather.first?.id ?? 800
        checkIfDayTime()
    }
    
    private func checkIfDayTime()   {
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: Date())
        
        // SI LA HORA ES DESPUES DE LAS 7PM O ANTES DE LAS 6AM, ES DE NOCHE
        if currentHour >= 19 || currentHour < 6 {
            self.isDayTime = false
        } else {
            self.isDayTime = true
        }
    }
}
