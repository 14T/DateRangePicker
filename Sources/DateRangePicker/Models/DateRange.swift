//
//  DateRange.swift
//  DateRangePicker
//
//  Created by Anand on 21/9/25.
//


import Foundation

/// Represents a selected date range
public struct DateRange {
    public var startDate: Date?
    public var endDate: Date?
    
    public init(startDate: Date? = nil, endDate: Date? = nil) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
