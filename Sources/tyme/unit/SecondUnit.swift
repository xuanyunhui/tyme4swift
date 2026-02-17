import Foundation

open class SecondUnit: DayUnit {
    public let hour: Int
    public let minute: Int
    public let second: Int

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

    @available(*, deprecated, renamed: "hour")
    public func getHour() -> Int { hour }
    @available(*, deprecated, renamed: "minute")
    public func getMinute() -> Int { minute }
    @available(*, deprecated, renamed: "second")
    public func getSecond() -> Int { second }
}
