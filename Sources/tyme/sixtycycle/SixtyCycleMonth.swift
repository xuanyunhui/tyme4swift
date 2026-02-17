import Foundation

/// 干支月（节令换月）
public final class SixtyCycleMonth: AbstractCulture {
    /// 干支年
    public let sixtyCycleYear: SixtyCycleYear

    /// 月柱
    public let sixtyCycle: SixtyCycle

    public init(year: SixtyCycleYear, month: SixtyCycle) {
        self.sixtyCycleYear = year
        self.sixtyCycle = month
        super.init()
    }

    /// 从年和月索引初始化（0-based）
    public static func fromIndex(_ year: Int, _ index: Int) -> SixtyCycleMonth {
        SixtyCycleYear.fromYear(year).firstMonth.next(index)
    }

    /// 从年和月份初始化（1-based，寅月=1）
    public static func fromYm(_ year: Int, _ month: Int) -> SixtyCycleMonth {
        fromIndex(year, month - 1)
    }

    /// 年
    public var year: Int { sixtyCycleYear.year }

    /// 月（1-based，寅月=1）
    public var month: Int { indexInYear + 1 }

    /// 年柱
    public var yearPillar: SixtyCycle { sixtyCycleYear.sixtyCycle }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }

    public override func getName() -> String {
        "\(sixtyCycle)月"
    }

    public override var description: String {
        "\(sixtyCycleYear)\(getName())"
    }

    /// 位于当年的索引(0-11)，寅月为0
    public var indexInYear: Int {
        sixtyCycle.earthBranch.next(-2).index
    }

    public func next(_ n: Int) -> SixtyCycleMonth {
        SixtyCycleMonth(
            year: SixtyCycleYear.fromYear((sixtyCycleYear.year * 12 + indexInYear + n) / 12),
            month: sixtyCycle.next(n)
        )
    }

    /// 九星
    public var nineStar: NineStar {
        var idx = sixtyCycle.earthBranch.index
        if idx < 2 {
            idx += 3
        }
        return NineStar.fromIndex(27 - yearPillar.earthBranch.index % 3 * 3 - idx)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        let n = [7, -1, 1, 3][sixtyCycle.earthBranch.next(-2).index % 4]
        return n == -1 ? sixtyCycle.heavenStem.direction : Direction.fromIndex(n)
    }

    /// 首日（节令当天）
    public var firstDay: SixtyCycleDay {
        SixtyCycleDay.fromSolarDay(SolarTerm.fromIndex(sixtyCycleYear.year, 3 + indexInYear * 2).solarDay)
    }

    /// 本月的干支日列表
    public var days: [SixtyCycleDay] {
        var l: [SixtyCycleDay] = []
        var d = firstDay
        while d.sixtyCycleMonth == self {
            l.append(d)
            d = d.next(1)
        }
        return l
    }

    @available(*, deprecated, renamed: "sixtyCycleYear")
    public func getSixtyCycleYear() -> SixtyCycleYear { sixtyCycleYear }

    @available(*, deprecated, renamed: "yearPillar")
    public func getYear() -> SixtyCycle { yearPillar }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "indexInYear")
    public func getIndexInYear() -> Int { indexInYear }

    @available(*, deprecated, renamed: "nineStar")
    public func getNineStar() -> NineStar { nineStar }

    @available(*, deprecated, renamed: "jupiterDirection")
    public func getJupiterDirection() -> Direction { jupiterDirection }

    @available(*, deprecated, renamed: "firstDay")
    public func getFirstDay() -> SixtyCycleDay { firstDay }

    @available(*, deprecated, renamed: "days")
    public func getDays() -> [SixtyCycleDay] { days }
}

// MARK: - Equatable

extension SixtyCycleMonth: Equatable {
    public static func == (lhs: SixtyCycleMonth, rhs: SixtyCycleMonth) -> Bool {
        lhs.sixtyCycleYear.year == rhs.sixtyCycleYear.year && lhs.sixtyCycle.index == rhs.sixtyCycle.index
    }
}
