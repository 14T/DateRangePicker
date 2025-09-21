# DateRangePicker

A lightweight **SwiftUI date range picker** built on top of Apple's native [`MultiDatePicker`](https://developer.apple.com/documentation/swiftui/multidatepicker).
Unlike the standard `MultiDatePicker`, this package allows you to **select a continuous date range** by tapping a start date and an end date — everything in between is selected automatically.

> ⚠️ Requires **iOS 16+** (since `MultiDatePicker` is only available starting iOS 16).

---

## ✨ Features
- Select a **start and end date** to define a range
- Automatically highlights all days in between
- Uses **native SwiftUI `MultiDatePicker`**
- Lightweight and dependency-free
- Includes example project for quick testing

---

## 📦 Installation

### Swift Package Manager (SPM)
Add the package to your project:

1. In Xcode, go to **File → Add Packages…**
2. Enter the repository URL: https://github.com/yourusername/DateRangePicker.git
3. Select the **main branch** (or a tagged release once you publish).

---

## 🚀 Usage

### Parameters
- **`startDate`**: A `Binding<Date?>` that holds the selected start date of the range. Set to `nil` when no range is selected.
- **`endDate`**: A `Binding<Date?>` that holds the selected end date of the range. Set to `nil` when no range is selected.
- **`bounds`**: A `Range<Date>` that constrains the calendar to only allow date selection within this range. This prevents users from selecting dates outside your desired timeframe.

### Basic Example

```swift
import SwiftUI
import DateRangePicker

struct ContentView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    private var bounds: Range<Date> {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .month, value: -1, to: Date())!
        let end = calendar.date(byAdding: .month, value: 1, to: Date())!
        return start..<end
    }
    
    var body: some View {
        VStack(spacing: 20) {
            DateRangePicker(
                startDate: $startDate,
                endDate: $endDate,
                bounds: bounds
            )
            .frame(height: 400)
            
            if let start = startDate, let end = endDate {
                Text("Range: \(start.formatted(date: .abbreviated, time: .omitted)) → \(end.formatted(date: .abbreviated, time: .omitted))")
            } else {
                Text("No complete range selected")
            }
        }
        .padding()
    }
}
```

### Advanced Example with Validation

```swift
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
        VStack(spacing: 20) {
            Text("Book your stay")
                .font(.title2)
                .fontWeight(.semibold)
            
            DateRangePicker(
                startDate: $checkInDate,
                endDate: $checkOutDate,
                bounds: bookingBounds
            )
            .frame(height: 350)
            
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
        }
        .padding()
    }
}
```

---

## 🎛 Customization

You can further customize the appearance using standard SwiftUI modifiers:

```swift
DateRangePicker(
    startDate: $startDate,
    endDate: $endDate,
    bounds: bounds
)
.frame(height: 400)
.datePickerStyle(.graphical)
.accentColor(.blue)
```

---

## 📱 Example Project

The package includes a sample iOS app that demonstrates various use cases:

1. Basic date range selection
2. Constrained date ranges (e.g., future dates only)
3. Integration with form validation
4. Custom styling and theming

Open the example project in Xcode to see these implementations in action.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
