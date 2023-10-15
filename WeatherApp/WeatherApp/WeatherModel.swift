//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Kynji Kyle Niño A. Pepito on 10/14/23.
//

import Foundation

struct Weather: Decodable {

    let status: String
    let description: String
    let icon: String
}

class JsonFormatter {
    func map(_ keyVal: [String: Any]) -> Weather? {
        guard let current = keyVal["current"] as? [String: Any] else { return nil }
        guard let weather = current["weather"] as? [[String: AnyObject]] else { return nil }

        guard let status = weather[0]["main"] as? String else { return nil }
        guard let description = weather[0]["description"] as? String else { return nil }
        guard let icon = weather[0]["icon"] as? String else { return nil }
        
        return Weather(status: status, description: description, icon: icon)
    }
}

