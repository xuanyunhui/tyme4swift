import Foundation

/// 携带年月周信息的日历单元基类，继承自 ``MonthUnit``。
///
/// 在年月基础上增加周序号（第几周）和周起始日，
/// 主要被 `SolarWeek` 使用，表示公历某月的第 N 周。
open class WeekUnit: MonthUnit {
    /// 月内周序号（0-based，第 0 周为第一周）。
    public var index: Int = 0

    /// 周起始日的索引（0 = 日曜日，1 = 月曜日，…，6 = 土曜日）。
    public var startIndex: Int = 0

    /// 该周的起始星期，由 ``startIndex`` 决定。
    public var start: Week { Week.fromIndex(startIndex) }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    @available(*, deprecated, renamed: "start")
    public func getStart() -> Week { start }

    /// 验证周序号和起始日索引是否合法。
    ///
    /// - Parameters:
    ///   - index: 周序号（0–5）。
    ///   - start: 起始日索引（0–6）。
    /// - Throws: ``TymeError/invalidIndex(_:)`` 如果任一参数超出范围。
    public static func validate(index: Int, start: Int) throws {
        if index < 0 || index > 5 { throw TymeError.invalidIndex(index) }
        if start < 0 || start > 6 { throw TymeError.invalidIndex(start) }
    }
}
