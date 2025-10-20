//
//  DateSelectionHelperTests.swift
//  DateRangePicker
//
//  Created by Anand on 21/9/25.
//


import Testing
@testable import DateRangePicker
import Foundation

struct DateSelectionHelperTests {
    
    let calendar = Calendar.current
    
    @Test func testGetDatesInRangeWithStartAndEnd() {
        let start = calendar.date(from: DateComponents(year: 2023, month: 10, day: 1))!
        let end = calendar.date(from: DateComponents(year: 2023, month: 10, day: 3))!
        
        let dates = DateRangeHelper.getDatesInRange(startDate: start, endDate: end, calendar: calendar)
        
        #expect(dates.count == 3)
        #expect(dates.contains(DateComponents(year: 2023, month: 10, day: 1)))
        #expect(dates.contains(DateComponents(year: 2023, month: 10, day: 2)))
        #expect(dates.contains(DateComponents(year: 2023, month: 10, day: 3)))
    }
    
    @Test func testGetDatesInRangeWithOnlyStart() {
        let start = calendar.date(from: DateComponents(year: 2023, month: 10, day: 1))!
        
        let dates = DateRangeHelper.getDatesInRange(startDate: start, endDate: nil, calendar: calendar)
        
        #expect(dates.count == 1)
        #expect(dates.contains(DateComponents(year: 2023, month: 10, day: 1)))
    }
    
    @Test func testSetDateRangeFromSelectionFirstSelection() {
        var startDate: Date? = nil
        var endDate: Date? = nil
        let selected = Set([DateComponents(year: 2023, month: 10, day: 1)])
        
        DateRangeHelper.setDateRangeFromSelection(
            newValue: selected,
            calendar: calendar,
            startDate: &startDate,
            endDate: &endDate
        )
        
        #expect(startDate == calendar.date(from: DateComponents(year: 2023, month: 10, day: 1)))
        #expect(endDate == nil)
    }
    
    @Test func testSetDateRangeFromSelectionSecondSelection() {
        var startDate: Date? = calendar.date(from: DateComponents(year: 2023, month: 10, day: 1))
        var endDate: Date? = nil
        let selected = Set([
            DateComponents(year: 2023, month: 10, day: 1),
            DateComponents(year: 2023, month: 10, day: 3)
        ])
        
        DateRangeHelper.setDateRangeFromSelection(
            newValue: selected,
            calendar: calendar,
            startDate: &startDate,
            endDate: &endDate
        )
        
        #expect(startDate == calendar.date(from: DateComponents(year: 2023, month: 10, day: 1)))
        #expect(endDate == calendar.date(from: DateComponents(year: 2023, month: 10, day: 3)))
    }
}
