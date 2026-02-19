import Foundation

/// 干支时辰（立春换年，节令换月，23点换日）
public final class SixtyCycleHour: AbstractCulture {
    /// 公历时刻
    public let solarTime: SolarTime

    /// 干支日
    public let sixtyCycleDay: SixtyCycleDay

    /// 时柱
    public let sixtyCycle: SixtyCycle

    /// Initialize with SolarTime
    public init(solarTime: SolarTime) {
        let solarYear = solarTime.year
        let springSolarTime = SolarTerm.fromIndex(solarYear, 3).julianDay.solarTime
        let lunarHour = solarTime.lunarHour
        let lunarDay = lunarHour.lunarDay
        var lunarYear = lunarDay.lunarMonth.lunarYear
        if lunarYear.year == solarYear {
            if solarTime.isBefore(springSolarTime) {
                lunarYear = lunarYear.next(-1)
            }
        } else if lunarYear.year < solarYear {
            if !solarTime.isBefore(springSolarTime) {
                lunarYear = lunarYear.next(1)
            }
        }

        let term = solarTime.term
        var termOffset = term.index - 3
        if termOffset < 0 && term.julianDay.solarTime.isAfter(SolarTerm.fromIndex(solarYear, 3).julianDay.solarTime) {
            termOffset += 24
        }

        let d = lunarDay.sixtyCycle
        guard let lunarMonth1 = try? LunarMonth.fromYm(solarYear, 1) else {
            preconditionFailure("SixtyCycleHour: invalid lunar month calculation")
        }
        let monthSixtyCycle = lunarMonth1.sixtyCycle.next(Int(floor(Double(termOffset) * 0.5)))
        let scMonth = SixtyCycleMonth(
            year: SixtyCycleYear.fromYear(lunarYear.year),
            month: monthSixtyCycle
        )

        self.solarTime = solarTime
        self.sixtyCycleDay = SixtyCycleDay(
            solarDay: solarTime.solarDay,
            month: scMonth,
            day: solarTime.hour < 23 ? d : d.next(1)
        )
        self.sixtyCycle = lunarHour.sixtyCycle
        super.init()
    }

    /// Initialize with year, month, day, hour, minute, second
    public convenience init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        self.init(solarTime: try SolarTime.fromYmdHms(year, month, day, hour, minute, second))
    }

    /// 年柱
    public var yearPillar: SixtyCycle { sixtyCycleDay.yearPillar }

    /// 月柱
    public var monthPillar: SixtyCycle { sixtyCycleDay.monthPillar }

    /// 日柱
    public var dayPillar: SixtyCycle { sixtyCycleDay.sixtyCycle }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }

    /// 位于当天的索引
    public var indexInDay: Int {
        let h = solarTime.hour
        return h == 23 ? 0 : (h + 1) / 2
    }

    /// 九星
    public var nineStar: NineStar {
        let solar = solarTime.solarDay
        let dongZhi = SolarTerm.fromIndex(solar.year, 0)
        let earthBranchIndex = indexInDay % 12
        let baseIndex = [8, 5, 2][dayPillar.earthBranch.index % 3]
        let idx: Int
        if !solar.isBefore(dongZhi.julianDay.solarDay) && solar.isBefore(dongZhi.next(12).julianDay.solarDay) {
            idx = 8 + earthBranchIndex - baseIndex
        } else {
            idx = baseIndex - earthBranchIndex
        }
        return NineStar.fromIndex(idx)
    }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar {
        TwelveStar.fromIndex(sixtyCycle.earthBranch.index + (8 - dayPillar.earthBranch.index % 6) * 2)
    }

    /// 宜
    public var recommends: [Taboo] {
        TabooLookup.getHourRecommends(day: dayPillar, hour: sixtyCycle)
    }

    /// 忌
    public var avoids: [Taboo] {
        TabooLookup.getHourAvoids(day: dayPillar, hour: sixtyCycle)
    }

    /// 八字
    public var eightChar: EightChar {
        EightChar(year: yearPillar, month: monthPillar, day: dayPillar, hour: sixtyCycle)
    }

    /// Get name
    public override func getName() -> String {
        return "\(sixtyCycle)时"
    }

    public override var description: String {
        "\(sixtyCycleDay)\(getName())"
    }

    /// 推移（秒数）
    public func next(_ n: Int) -> SixtyCycleHour {
        return SixtyCycleHour.fromSolarTime(solarTime.next(n))
    }

    /// Create from SolarTime
    public static func fromSolarTime(_ solarTime: SolarTime) -> SixtyCycleHour {
        return SixtyCycleHour(solarTime: solarTime)
    }

    /// Create from year, month, day, hour, minute, second
    public static func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> SixtyCycleHour {
        return try SixtyCycleHour(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    @available(*, deprecated, renamed: "solarTime")
    public func getSolarTime() -> SolarTime { solarTime }

    @available(*, deprecated, renamed: "sixtyCycleDay")
    public func getSixtyCycleDay() -> SixtyCycleDay { sixtyCycleDay }

    @available(*, deprecated, renamed: "yearPillar")
    public func getYear() -> SixtyCycle { yearPillar }

    @available(*, deprecated, renamed: "monthPillar")
    public func getMonth() -> SixtyCycle { monthPillar }

    @available(*, deprecated, renamed: "dayPillar")
    public func getDay() -> SixtyCycle { dayPillar }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "indexInDay")
    public func getIndexInDay() -> Int { indexInDay }

    @available(*, deprecated, renamed: "nineStar")
    public func getNineStar() -> NineStar { nineStar }

    @available(*, deprecated, renamed: "twelveStar")
    public func getTwelveStar() -> TwelveStar { twelveStar }

    @available(*, deprecated, renamed: "recommends")
    public func getRecommends() -> [Taboo] { recommends }

    @available(*, deprecated, renamed: "avoids")
    public func getAvoids() -> [Taboo] { avoids }
}
