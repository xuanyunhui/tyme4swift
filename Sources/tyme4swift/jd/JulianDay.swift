import Foundation

public struct JulianDay: CustomStringConvertible {
    public let value: Double

    public init(_ value: Double) {
        self.value = value
    }

    public var description: String { String(format: "%.8f", value) }

    public static func fromYmdHms(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> JulianDay {
        // Disallow missing dates during Gregorian reform
        if year == 1582 && month == 10 && day >= 5 && day <= 14 {
            fatalError("Invalid date during Gregorian switch: 1582-10-05..14")
        }

        var y = year
        var m = month
        if m <= 2 { y -= 1; m += 12 }

        let a = y / 100
        let isGregorian = (year > 1582) || (year == 1582 && (month > 10 || (month == 10 && day >= 15)))
        let b = isGregorian ? (2 - a + a / 4) : 0

        let dayFraction = (Double(hour) + Double(minute)/60.0 + Double(second)/3600.0) / 24.0
        let jd = floor(365.25 * Double(y + 4716)) + floor(30.6001 * Double(m + 1)) + Double(day) + Double(b) - 1524.5 + dayFraction
        return JulianDay(jd)
    }

    public func toYmdHms() -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        var z = Int(floor(value + 0.5))
        let f = (value + 0.5) - Double(z)

        let isGregorian = z >= 2299161 // 1582-10-15
        if isGregorian {
            let alpha = Int((Double(z) - 1867216.25) / 36524.25)
            z = z + 1 + alpha - alpha / 4
        }

        let b = z + 1524
        let c = Int((Double(b) - 122.1) / 365.25)
        let d = Int(365.25 * Double(c))
        let e = Int((Double(b - d)) / 30.6001)

        let day = b - d - Int(30.6001 * Double(e))
        let month = (e < 14) ? e - 1 : e - 13
        let year = (month > 2) ? c - 4716 : c - 4715

        let daySeconds = Int(round(f * 86400.0))
        let hour = daySeconds / 3600
        let minute = (daySeconds % 3600) / 60
        let second = daySeconds % 60

        return (year, month, day, hour, minute, second)
    }
}
