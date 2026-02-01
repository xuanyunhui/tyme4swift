import Foundation

open class SecondUnit: DayUnit {
    private let hour: Int
    private let minute: Int
    private let second: Int

    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        if hour < 0 || hour > 23 { fatalError("Invalid hour: \(hour)") }
        if minute < 0 || minute > 59 { fatalError("Invalid minute: \(minute)") }
        if second < 0 || second > 59 { fatalError("Invalid second: \(second)") }
        self.hour = hour
        self.minute = minute
        self.second = second
        super.init(year: year, month: month, day: day)
    }

    public func getHour() -> Int { hour }
    public func getMinute() -> Int { minute }
    public func getSecond() -> Int { second }
}
