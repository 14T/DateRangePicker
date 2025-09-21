//
//  ContentView.swift
//  DateRangePickerExample
//
//  Created by Anand on 21/9/25.
//

import SwiftUI
import DateRangePicker

struct ContentView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    private var bounds: Range<Date> {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .month, value: -3, to: Date())!
        let end = calendar.date(byAdding: .month, value: 3, to: Date())!
        return start..<end
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                DateRangePicker(
                    startDate: $startDate,
                    endDate: $endDate
                )
                .frame(height: 400)
                .padding()
                
                if let start = startDate, let end = endDate {
                    Text("Selected Range:")
                    Text("\(start.formatted(date: .abbreviated, time: .omitted)) → \(end.formatted(date: .abbreviated, time: .omitted))")
                        .font(.headline)
                } else if let start = startDate {
                    Text("Start: \(start.formatted(date: .abbreviated, time: .omitted))")
                        .font(.headline)
                    Text("End: not selected")
                        .foregroundStyle(.secondary)
                } else {
                    Text("No date range selected")
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                NavigationLink {
                    BookingView()
                } label: {
                    Text("Go to Booking Demo")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                .navigationTitle("Date Range Picker")
            }
        }
    }
}

#Preview {
    ContentView()
}
