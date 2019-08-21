//
//  Functions.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    
    /**
     Adding a `cornerRadius` of **15** onto a `UIButton` to encourage global styling.
    
     ```swift
    Tools.beautifulButton(someButton)
     ```
     Is all you need to do to implement this.
     
     - parameters:
        - object: `UIButton` that you are trying to modify.
    */
    public static func beautifulButton(_ object: UIButton) {
        object.layer.cornerRadius = 15
        object.layer.masksToBounds = true
    }
    
    public static func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hr
        components.minute = min
        components.second = sec
        let date = calendar.date(from: components as DateComponents)
        return date! as NSDate
    }
    
    public static func component2Date(_ component: DateComponents) -> NSDate {
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let date = calender?.date(from: component)
        return date! as NSDate
    }
}
