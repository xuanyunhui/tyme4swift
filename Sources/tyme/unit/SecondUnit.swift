import Foundation

open class SecondUnit: DayUnit {
    internal let hour: Int
    internal let minute: Int
    internal let second: Int

    public static func validate(hour: Int, minute: Int, second: Int) throws {
        if hour < 0 || hour > 23 { throw TymeError.invalidHour(hour) }
        if minute < 0 || minute > 59 { throw TymeError.invalidMinute(minute) }
        if second < 0 || second > 59 { throw TymeError.invalidSecond(second) }
    }

    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        try SecondUnit.validate(hour: hour, minute: minute, second: second)
        self.hour = hour
        self.minute = minute
        self.second = second
        try super.init(year: year, month: month, day: day)
    }

    public func getHour() -> Int { hour }
    public func getMinute() -> Int { minute }
    public func getSecond() -> Int { second }
}
