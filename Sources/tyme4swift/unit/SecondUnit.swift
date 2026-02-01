import Foundation

open class SecondUnit: DayUnit {
    internal let hour: Int
    internal let minute: Int
    internal let second: Int

    public static func validate(hour: Int, minute: Int, second: Int) {
        if hour < 0 || hour > 23 { fatalError("Invalid hour: \(hour)") }
        if minute < 0 || minute > 59 { fatalError("Invalid minute: \(minute)") }
        if second < 0 || second > 59 { fatalError("Invalid second: \(second)") }
    }

    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        SecondUnit.validate(hour: hour, minute: minute, second: second)
        self.hour = hour
        self.minute = minute
        self.second = second
        super.init(year: year, month: month, day: day)
    }

    public func getHour() -> Int { hour }
    public func getMinute() -> Int { minute }
    public func getSecond() -> Int { second }
}
