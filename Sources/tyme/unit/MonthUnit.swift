import Foundation

/// 携带年月信息的日历单元基类，继承自 ``YearUnit``。
///
/// 在年份基础上增加月份验证（1–12），构造时若月份非法则抛出错误。
///
/// 继承体系：`YearUnit` → `MonthUnit` → `DayUnit` → `SecondUnit`
open class MonthUnit: YearUnit {
    /// 月份（1–12）。
    public let month: Int

    /// 通过年份和月份构造实例。
    ///
    /// - Parameters:
    ///   - year: 公历年份。
    ///   - month: 月份，必须在 1–12 范围内。
    /// - Throws: ``TymeError/invalidMonth(_:)`` 如果月份超出范围。
    public init(year: Int, month: Int) throws {
        if month < 1 || month > 12 {
            throw TymeError.invalidMonth(month)
        }
        self.month = month
        try super.init(year: year)
    }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> Int { month }
}
