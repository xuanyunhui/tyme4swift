import Foundation

/// 藏历日
/// 仅支持藏历1950年十二月初一（公历1951年1月8日）至藏历2050年十二月三十（公历2051年2月11日）
/// 算法对齐 tyme4j com.tyme.rabbyung.RabByungDay
public final class RabByungDay: AbstractTyme {

    public static let NAMES = [
        "初一", "初二", "初三", "初四", "初五",
        "初六", "初七", "初八", "初九", "初十",
        "十一", "十二", "十三", "十四", "十五",
        "十六", "十七", "十八", "十九", "二十",
        "廿一", "廿二", "廿三", "廿四", "廿五",
        "廿六", "廿七", "廿八", "廿九", "三十"
    ]

    // MARK: - Stored Properties

    /// 藏历月
    public let rabByungMonth: RabByungMonth

    /// 日（1-30）
    public let day: Int

    /// 是否闰日（重复日）
    public let isLeap: Bool

    // MARK: - Initializer

    public init(_ month: RabByungMonth, _ day: Int) throws {
        guard day != 0, abs(day) <= 30 else {
            throw TymeError.invalidDay(day)
        }
        let leap = day < 0
        let d = abs(day)
        if leap {
            guard month.leapDays.contains(d) else {
                throw TymeError.invalidDay(day)
            }
        } else {
            guard !month.missDays.contains(d) else {
                throw TymeError.invalidDay(day)
            }
        }
        self.rabByungMonth = month
        self.day = d
        self.isLeap = leap
        super.init()
    }

    // MARK: - Factory Methods

    /// 由藏历年月日构造（月为负表示闰月，日为负表示闰日）
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> RabByungDay {
        let m = try RabByungMonth.fromYm(year, month)
        return try RabByungDay(m, day)
    }

    /// 由饶迥序号、五行、生肖、月、日构造
    public static func fromElementZodiac(_ rabByungIndex: Int, _ element: RabByungElement, _ zodiac: Zodiac, _ month: Int, _ day: Int) throws -> RabByungDay {
        let m = try RabByungMonth.fromElementZodiac(rabByungIndex, element, zodiac, month)
        return try RabByungDay(m, day)
    }

    /// 由公历日转换为藏历日
    public static func fromSolarDay(_ solarDay: SolarDay) throws -> RabByungDay {
        let epochDay = try SolarDay.fromYmd(1951, 1, 8)
        var days = solarDay.subtract(epochDay)
        guard days >= 0 else {
            throw TymeError.invalidDay(days)
        }
        var m = try RabByungMonth.fromYm(1950, 12)
        var count = m.dayCount
        while days >= count {
            days -= count
            let next = m.next(1)
            guard next.year != m.year || next.monthWithLeap != m.monthWithLeap else {
                throw TymeError.invalidDay(days)
            }
            m = next
            count = m.dayCount
        }
        var day = days + 1
        for d in m.specialDays {
            if d < 0 {
                if day >= -d { day += 1 }
            } else if d > 0 {
                if day == d + 1 {
                    day = -d
                    break
                } else if day > d + 1 {
                    day -= 1
                }
            }
        }
        return try RabByungDay(m, day)
    }

    // MARK: - Computed Properties

    /// 藏历年
    public var year: Int { rabByungMonth.year }

    /// 月（闰月为负）
    public var month: Int { rabByungMonth.monthWithLeap }

    /// 日（闰日为负）
    public var dayWithLeap: Int { isLeap ? -day : day }

    public override func getName() -> String {
        (isLeap ? "闰" : "") + RabByungDay.NAMES[day - 1]
    }

    // MARK: - Solar Day Conversion

    /// 对应的公历日
    public var solarDay: SolarDay {
        guard let epochMonth = try? RabByungMonth.fromYm(1950, 12),
              let anchorDay = try? SolarDay.fromYmd(1951, 1, 7) else {
            preconditionFailure("RabByungDay: epoch values 1950-12 / 1951-01-07 are always valid")
        }
        var n = 0
        var cur = epochMonth
        while !(rabByungMonth.year == cur.year && rabByungMonth.monthWithLeap == cur.monthWithLeap) {
            n += cur.dayCount
            cur = cur.next(1)
        }
        var t = day
        for d in cur.specialDays {
            if d < 0 {
                if t > -d { t -= 1 }
            } else if d > 0 {
                if t > d { t += 1 }
            }
        }
        if isLeap { t += 1 }
        return anchorDay.next(n + t)
    }

    // MARK: - Arithmetic

    /// 与另一藏历日相差的天数
    public func subtract(_ target: RabByungDay) -> Int {
        solarDay.subtract(target.solarDay)
    }

    // MARK: - Navigation

    public override func next(_ n: Int) -> RabByungDay {
        if n == 0 { return (try? RabByungDay.fromSolarDay(solarDay)) ?? self }
        return (try? RabByungDay.fromSolarDay(solarDay.next(n))) ?? self
    }

    // MARK: - Deprecated API

    @available(*, deprecated, renamed: "rabByungMonth")
    public func getRabByungMonth() -> RabByungMonth { rabByungMonth }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> Int { month }

    @available(*, deprecated, renamed: "day")
    public func getDay() -> Int { day }

    @available(*, deprecated, renamed: "isLeap")
    public func isLeapDay() -> Bool { isLeap }

    @available(*, deprecated, renamed: "dayWithLeap")
    public func getDayWithLeap() -> Int { dayWithLeap }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }
}
