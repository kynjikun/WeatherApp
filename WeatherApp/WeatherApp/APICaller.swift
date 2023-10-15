//
//  APICaller.swift
//  WeatherApp
//
//  Created by Kynji Kyle Niño A. Pepito on 10/14/23.
//

import Foundation

enum ExcludeOpts {
    case Current
    case Minutely
    case Hourly
    case Daily
    case Alert
    
    var toString: String {
        switch self {
            case .Current: "current"
            case .Minutely: "minute"
            case .Hourly: "hourly"
            case .Daily: "daily"
            case .Alert: "alert"
        }
    }
}

class APICaller {
    static let key = "55edb762352afab7c34d25e00927bdd4" // temp
    static let shared = APICaller()
    
    
//    https://api.openweathermap.org/data/3.0/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid=55edb762352afab7c34d25e00927bdd4
    func fetchCurrentWeather(lat: Double, lon: Double, excludes: [ExcludeOpts]) async throws -> Weather? { // temp return needs ot convert JSON to current weather model
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon).04&exclude=\(String(describing: excludes.optsToString))&appid=\(APICaller.key)")
        
        let request = URLRequest(url: url!)
        let (data, _) = try await URLSession.shared.data(for: request)
        let resultJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]

        return JsonFormatter().map(resultJson!)
    }
}

extension Array where Element == ExcludeOpts {
    func optsToString() -> String {
        self.reduce("") { result, current in result + "\(result.isEmpty ? current.toString : "," + current.toString)" }
    }
}
