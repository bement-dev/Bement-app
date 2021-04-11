//
//  WeatherStore.swift
//  Bement
//
//  Created by Runkai Zhang on 8/11/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherStore {
    var uvIndex: Int = 0
    var fahrenheit: Int = 0
    var celsius: Int = 0
    var summary: String = "Something went wrong..."
    var icon: String = "xmark.octagon.fill"
    
    init(_ data: Data? = nil) {
        do {
            if let usableData = data {
                let json = try JSON(data: usableData)
                let result = json.dictionary!["currently"]?.dictionary
                uvIndex = result?["uvIndex"]?.int ?? 0
                fahrenheit = result?["temperature"]?.int ?? 0
                summary = result?["summary"]?.string ?? "Something went wrong..."
                icon = result?["icon"]?.string ?? "xmark.octagon.fill"
                let doubleTemp = Double(fahrenheit)
                celsius = Int(5.0 / 9.0 * (doubleTemp - 32.0))
            }
        } catch {
            print(error)
        }
    }
}
