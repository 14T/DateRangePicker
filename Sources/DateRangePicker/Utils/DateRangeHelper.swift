//
//  Date+Extensions.swift
//  DateRangePicker
//
//  Created by Anand on 21/9/25.
//


import Foundation

struct DateRangeHelper {
    static func getDatesInRange(
        startDate: Date?,
        endDate: Date?,
        calendar: Calendar
    ) -> Set<DateComponents> {
        var dates: Set<DateComponents> = []
        
        if let endDate, let startDate {
            var currentDate = startDate
            while currentDate <= endDate {
                let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
                dates.insert(components)
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
            }
        } else if let startDate {
            let components = calendar.dateComponents([.year, .month, .day], from: startDate)
            dates.insert(components)
        }
        return dates
    }
    
    static func setDateRangeFromSelection(
        newValue: Set<DateComponents>,
        calendar: Calendar,
        startDate: inout Date?,
        endDate: inout Date?
    ) {
        let sortedDates = newValue.compactMap { calendar.date(from: $0) }.sorted()
        
        if startDate == nil {
            startDate = sortedDates.first
            endDate = nil
        } else if endDate == nil {
            startDate = sortedDates.first
            endDate = sortedDates.last
        } else {
            if let newLast = sortedDates.last, let currentEnd = endDate {
                if newLast > currentEnd {
                    startDate = newLast
                    endDate = nil
                } else if let newFirst = sortedDates.first, let currentStart = startDate {
                    if newFirst < currentStart {
                        startDate = newFirst
                        endDate = nil
                    } else {
                        startDate = nil
                    }
                }
            }
        }
    }
}
