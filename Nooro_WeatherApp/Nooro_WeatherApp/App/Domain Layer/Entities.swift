//
//  Entities.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation


// MARK: - WeatherData (Root)
struct WeatherData: Codable {
    let location: Location
    let current: Current
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let tz_id: String
}

// MARK: - Current
struct Current: Codable {
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: Condition
    let humidity: Int
    let feelslike_c: Double
    let feelslike_f: Double
    let uv: Double
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}
