//
//  BookingView.swift
//  DateRangePickerExample
//
//  Created by Anand on 22/9/25.
//
import SwiftUI
import DateRangePicker

struct BookingView: View {
    @State private var checkInDate: Date? = nil
    @State private var checkOutDate: Date? = nil
    @State private var minimumStay = 2
    
    private var bookingBounds: Range<Date> {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .day, value: 1, to: Date())! // Tomorrow onwards
        let end = calendar.date(byAdding: .month, value: 6, to: Date())! // 6 months from now
        return start..<end
    }
    
    var isValidBooking: Bool {
        guard let checkIn = checkInDate, let checkOut = checkOutDate else { return false }
        let daysBetween = Calendar.current.dateComponents([.day], from: checkIn, to: checkOut).day ?? 0
        return daysBetween >= minimumStay
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                DateRangePicker(
                    startDate: $checkInDate,
                    endDate: $checkOutDate,
                    bounds: bookingBounds
                )
                .frame(height: 350)
                .tint(.red)
                
                if let checkIn = checkInDate, let checkOut = checkOutDate {
                    let daysBetween = Calendar.current.dateComponents([.day], from: checkIn, to: checkOut).day ?? 0
                    Text("\(daysBetween) nights: \(checkIn.formatted(date: .abbreviated, time: .omitted)) - \(checkOut.formatted(date: .abbreviated, time: .omitted))")
                        .foregroundStyle(isValidBooking ? .green : .orange)
                }
                
                Button("Confirm Booking") {
                    if isValidBooking {
                        // Process booking
                        print("Booking confirmed!")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValidBooking)
                Spacer()
            }
            .padding()
            .navigationTitle("Book your stay")
        }
    }
}

#Preview {
    BookingView()
}
