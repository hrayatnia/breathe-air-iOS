//
//  humanify.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-25.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation

public func timeAgoSince(_ date: Date,unitFlags:NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month]) -> String {
    
    let calendar = Calendar.current
    let now = calendar.startOfDay(for: Date())
    let temp = calendar.startOfDay(for: date)
    print(date)
    
    let components = (calendar as NSCalendar).components(unitFlags, from: temp, to: now, options: [])
    
    if let year = components.year, year >= 1 {
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_year",
                                  comment: ""),
                year)
    }
    
    
    if let month = components.month, month >= 1 && month < 12 {
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_month",
                                  comment: ""),
                month)
    }
    
    if let week = components.weekOfYear, week >= 1 {
        print("weeks: \(week)")
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_week",
                                  comment: ""),
                week)
    }
    
    
    if let day = components.day , day >= 0 {
        
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_day",
                                  comment: ""),
                day)
    }
    
    
    if let hour = components.hour , hour >= 0 {
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_hour",
                                  comment: ""),
                hour)
    }
    
    
    
    if let minute = components.minute, minute >= 0 {
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_minute",
                                  comment: ""),
                minute)
    }
    
    if let second = components.second, second >= 3 {
        return String
            .localizedStringWithFormat(
                NSLocalizedString("number_of_second",
                                  comment: ""),
                second)
    }
    
    return "Just now"
    
}
