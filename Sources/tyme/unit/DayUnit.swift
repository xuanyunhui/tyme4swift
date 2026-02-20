import Foundation

/// 携带年月日信息的日历单元基类，继承自 ``MonthUnit``。
///
/// 在年月基础上增加日期验证（1–31），构造时若日期非法则抛出错误。
/// 注意：此处仅做范围检查，不验证月份实际天数（由具体子类负责）。
///
/// 继承体系：`YearUnit` → `MonthUnit` → `DayUnit` → `SecondUnit`
open class DayUnit: MonthUnit {
    /// 日期（1–31）。
    public let day: Int

    /// 通过年、月、日构造实例。
    ///
    /// - Parameters:
    ///   - year: 公历年份。
    ///   - month: 月份（1–12）。
    ///   - day: 日期（1–31）。
    /// - Throws: ``TymeError/invalidDay(_:)`` 如果日期超出范围。
    public init(year: Int, month: Int, day: Int) throws {
        if day < 1 || day > 31 {
            throw TymeError.invalidDay(day)
        }
        self.day = day
        try super.init(year: year, month: month)
    }

    @available(*, deprecated, renamed: "day")
    public func getDay() -> Int { day }
}
