//
//  WeatherStore.swift
//  Bement
//
//  Created by Runkai Zhang on 8/11/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation

class WeatherStore {
    var uvIndex: Int
    var temperature: Int
    var summary: String
    var icon: String
    
    init(uvIndex: Int, temperature: Int, summary: String, icon: String) {
        self.uvIndex = uvIndex
        self.temperature = temperature
        self.summary = summary
        self.icon = icon
    }
}
