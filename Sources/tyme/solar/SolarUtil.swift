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

    static func validateYear(_ year: Int) throws {
        if year < 1 || year > 9999 {
            throw TymeError.invalidYear(year)
        }
    }

    static func daysInMonth(year: Int, month: Int) throws -> Int {
        if year == 1582 && month == 10 {
            return 21
        }
        switch month {
        case 1,3,5,7,8,10,12: return 31
        case 4,6,9,11: return 30
        case 2: return isLeapYear(year) ? 29 : 28
        default: throw TymeError.invalidMonth(month)
        }
    }

    static func validateYmd(year: Int, month: Int, day: Int) throws {
        if month < 1 || month > 12 { throw TymeError.invalidMonth(month) }
        if year == 1582 && month == 10 && day >= 5 && day <= 14 {
            throw TymeError.invalidDate("1582-10-05..14")
        }
        if year == 1582 && month == 10 {
            if day < 1 || day > 31 { throw TymeError.invalidDay(day) }
            return
        }
        let maxDay = try daysInMonth(year: year, month: month)
        if day < 1 || day > maxDay { throw TymeError.invalidDay(day) }
    }
}
