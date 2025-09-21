// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct DateRangePicker: View {
    @Binding private var startDate: Date?
    @Binding private var endDate: Date?
    let bounds: Range<Date>
    var calendar: Calendar = .current
    
    public init(
        startDate: Binding<Date?>,
        endDate: Binding<Date?>,
        bounds: Range<Date>
    ) {
        self._startDate = startDate
        self._endDate = endDate
        self.bounds = bounds
    }
    
    private var datesBinding: Binding<Set<DateComponents>> {
        Binding {
            DateRangeHelper.getDatesInRange(startDate: startDate, endDate: endDate, calendar: calendar)
        } set: { newValue in
            DateRangeHelper.setDateRangeFromSelection(
                newValue: newValue,
                calendar: calendar,
                startDate: &startDate,
                endDate: &endDate
            )
        }
    }
    
    public var body: some View {
        MultiDatePicker("sss", selection: datesBinding, in: bounds)
            .environment(\.locale, Locale.current)
            .environment(\.timeZone, .current)
            .environment(\.calendar, calendar)
            .tint(Color.blue) // replace with your custom color if needed
    }
}
