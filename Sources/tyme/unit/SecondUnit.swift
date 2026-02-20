import Foundation

/// 携带完整时间精度（年月日时分秒）的日历单元基类，继承自 ``DayUnit``。
///
/// 在年月日基础上增加时、分、秒的验证，构造时若任一字段非法则抛出错误。
/// 被 `SolarTime` 等具体时间类型继承使用。
///
/// 继承体系：`YearUnit` → `MonthUnit` → `DayUnit` → `SecondUnit`
open class SecondUnit: DayUnit {
    /// 小时（0–23）。
    public let hour: Int

    /// 分钟（0–59）。
    public let minute: Int

    /// 秒（0–59）。
    public let second: Int

    /// 验证时、分、秒字段是否合法。
    ///
    /// - Parameters:
    ///   - hour: 小时（0–23）。
    ///   - minute: 分钟（0–59）。
    ///   - second: 秒（0–59）。
    /// - Throws: 对应的 ``TymeError`` 如果任一字段超出范围。
    public static func validate(hour: Int, minute: Int, second: Int) throws {
        if hour < 0 || hour > 23 { throw TymeError.invalidHour(hour) }
        if minute < 0 || minute > 59 { throw TymeError.invalidMinute(minute) }
        if second < 0 || second > 59 { throw TymeError.invalidSecond(second) }
    }

    /// 通过年、月、日、时、分、秒构造实例。
    ///
    /// - Parameters:
    ///   - year: 公历年份。
    ///   - month: 月份（1–12）。
    ///   - day: 日期（1–31）。
    ///   - hour: 小时（0–23）。
    ///   - minute: 分钟（0–59）。
    ///   - second: 秒（0–59）。
    /// - Throws: 对应的 ``TymeError`` 如果任一字段非法。
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
