import Foundation

enum SolarUtil {
    static func isLeapYear(_ year: Int) -> Bool {
        if year < 1600 {
            return year % 4 == 0
        }
        if year % 400 == 0 { return true }
        if year % 100 == 0 { return false }
        return year % 4 == 0
    }

    static func validateYear(_ year: Int) {
        if year < 1 || year > 9999 {
            fatalError("Invalid year: \(year)")
        }
    }

    static func daysInMonth(year: Int, month: Int) -> Int {
        if year == 1582 && month == 10 {
            return 21
        }
        switch month {
        case 1,3,5,7,8,10,12: return 31
        case 4,6,9,11: return 30
        case 2: return isLeapYear(year) ? 29 : 28
        default: fatalError("Invalid month: \(month)")
        }
    }

    static func validateYmd(year: Int, month: Int, day: Int) {
        if month < 1 || month > 12 { fatalError("Invalid month: \(month)") }
        if year == 1582 && month == 10 && day >= 5 && day <= 14 {
            fatalError("Invalid date during Gregorian switch: 1582-10-05..14")
        }
        if year == 1582 && month == 10 {
            if day < 1 || day > 31 { fatalError("Invalid day: \(day)") }
            return
        }
        let maxDay = daysInMonth(year: year, month: month)
        if day < 1 || day > maxDay { fatalError("Invalid day: \(day)") }
    }
}
