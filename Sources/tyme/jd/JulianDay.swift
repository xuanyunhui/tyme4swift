import Foundation

public struct JulianDay: CustomStringConvertible {
    public static let J2000: Double = 2451545.0
    public let value: Double

    public init(_ value: Double) {
        self.value = value
    }

    public var description: String { String(format: "%.8f", value) }

    public static func fromJulianDay(_ day: Double) -> JulianDay {
        JulianDay(day)
    }

    public static func fromYmdHms(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) throws -> JulianDay {
        // Disallow missing dates during Gregorian reform
        if year == 1582 && month == 10 && day >= 5 && day <= 14 {
            throw TymeError.invalidDate("1582-10-05..14")
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

    public func getDay() -> Double { value }

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

        var daySeconds = Int(round(f * 86400.0))
        if daySeconds >= 86400 { daySeconds = 0 }
        let hour = daySeconds / 3600
        let minute = (daySeconds % 3600) / 60
        let second = daySeconds % 60

        return (year, month, day, hour, minute, second)
    }

    public func next(_ n: Int) -> JulianDay { JulianDay(value + Double(n)) }

    public func getSolarTime() -> SolarTime {
        let ymd = toYmdHms()
        return try! SolarTime.fromYmdHms(ymd.year, ymd.month, ymd.day, ymd.hour, ymd.minute, ymd.second)
    }

    public func getSolarDay() -> SolarDay { try! getSolarTime().getSolarDay() }

    public func getWeek() -> Week {
        Week.fromIndex(Int(value + 0.5) + 7000001)
    }

    public func subtract(_ target: JulianDay) -> Double { value - target.value }
}
