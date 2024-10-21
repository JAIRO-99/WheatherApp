//
//  Service.swift
//  WheatherApp
//
//  Created by Jairo Laurente Celis on 21/10/24.
//

import Foundation
import Combine

//0cbca0658683dbd91f3459c71c82a327
    //https://api.openweathermap.org/data/3.0/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid={API key}
//https://api.openweathermap.org/data/2.5/weather?lat=39.099724&lon=-94.578331&dt=1643803200&appid=0cbca0658683dbd91f3459c71c82a327
class WeatherService {
    
    private let apiKey = "0cbca0658683dbd91f3459c71c82a327"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func getWeatherData(lat: Double, long: Double) -> AnyPublisher<WeatherModel, Error> {
         let urlString = "\(baseURL)?lat=\(lat)&lon=\(long)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
