import Foundation

/// 携带年份信息的基础单元类，所有日历单元类的根基类。
///
/// 提供经过验证的年份存储，子类依次叠加月、日、时等粒度。
/// 继承体系：`YearUnit` → `MonthUnit` → `DayUnit` → `SecondUnit`
///
/// ## 验证
///
/// 构造时通过 `SolarUtil.validateYear` 验证年份合法性，
/// 非法年份抛出 ``TymeError/invalidYear(_:)``。
open class YearUnit {
    /// 公历年份。
    public let year: Int

    /// 通过年份构造实例，年份必须在支持范围内。
    ///
    /// - Parameter year: 公历年份。
    /// - Throws: ``TymeError/invalidYear(_:)`` 如果年份超出支持范围。
    public init(year: Int) throws {
        try SolarUtil.validateYear(year)
        self.year = year
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    /// 将任意整数索引规范化到 `[0, size)` 范围内。
    internal func indexOf(_ index: Int, _ size: Int) -> Int {
        var i = index % size
        if i < 0 { i += size }
        return i
    }
}
