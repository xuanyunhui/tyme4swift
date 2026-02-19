import Foundation

/// 干支日（立春换年，节令换月）
public final class SixtyCycleDay: AbstractCulture {
    /// 公历日
    public let solarDay: SolarDay

    /// 干支月
    public let sixtyCycleMonth: SixtyCycleMonth

    /// 日柱
    public let sixtyCycle: SixtyCycle

    /// Initialize with SolarDay (computes month from solar term)
    public init(solarDay: SolarDay) {
        let term = solarDay.term
        let termIndex = term.index
        let offset = termIndex < 3 ? (termIndex == 0 ? -2 : -1) : (termIndex - 3) / 2
        self.solarDay = solarDay
        self.sixtyCycleMonth = SixtyCycleYear.fromYear(term.year).firstMonth.next(offset)
        guard let baseDay = try? SolarDay.fromYmd(2000, 1, 7) else {
            preconditionFailure("SixtyCycleDay: invalid base day calculation")
        }
        self.sixtyCycle = SixtyCycle.fromIndex(solarDay.subtract(baseDay))
        super.init()
    }

    /// Internal initializer with explicit month (used by SixtyCycleHour)
    init(solarDay: SolarDay, month: SixtyCycleMonth, day: SixtyCycle) {
        self.solarDay = solarDay
        self.sixtyCycleMonth = month
        self.sixtyCycle = day
        super.init()
    }

    /// Initialize with year, month, day
    public convenience init(year: Int, month: Int, day: Int) throws {
        self.init(solarDay: try SolarDay(year: year, month: month, day: day))
    }

    /// 年柱
    public var yearPillar: SixtyCycle { sixtyCycleMonth.yearPillar }

    /// 月柱
    public var monthPillar: SixtyCycle { sixtyCycleMonth.sixtyCycle }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }

    /// 建除十二值神
    public var duty: Duty {
        Duty.fromIndex(sixtyCycle.earthBranch.index - monthPillar.earthBranch.index)
    }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar {
        TwelveStar.fromIndex(sixtyCycle.earthBranch.index + (8 - monthPillar.earthBranch.index % 6) * 2)
    }

    /// 九星
    public var nineStar: NineStar {
        let dongZhi = SolarTerm.fromIndex(solarDay.year, 0)
        let dongZhiSolar = dongZhi.solarDay
        let xiaZhiSolar = dongZhi.next(12).solarDay
        let dongZhiSolar2 = dongZhi.next(24).solarDay
        let dongZhiIndex = dongZhiSolar.lunarDay.sixtyCycle.index
        let xiaZhiIndex = xiaZhiSolar.lunarDay.sixtyCycle.index
        let dongZhiIndex2 = dongZhiSolar2.lunarDay.sixtyCycle.index
        let solarShunBai = dongZhiSolar.next(dongZhiIndex > 29 ? 60 - dongZhiIndex : -dongZhiIndex)
        let solarShunBai2 = dongZhiSolar2.next(dongZhiIndex2 > 29 ? 60 - dongZhiIndex2 : -dongZhiIndex2)
        let solarNiZi = xiaZhiSolar.next(xiaZhiIndex > 29 ? 60 - xiaZhiIndex : -xiaZhiIndex)
        var offset = 0
        if !solarDay.isBefore(solarShunBai) && solarDay.isBefore(solarNiZi) {
            offset = solarDay.subtract(solarShunBai)
        } else if !solarDay.isBefore(solarNiZi) && solarDay.isBefore(solarShunBai2) {
            offset = 8 - solarDay.subtract(solarNiZi)
        } else if !solarDay.isBefore(solarShunBai2) {
            offset = solarDay.subtract(solarShunBai2)
        } else if solarDay.isBefore(solarShunBai) {
            offset = 8 + solarShunBai.subtract(solarDay)
        }
        return NineStar.fromIndex(offset)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        let idx = sixtyCycle.index
        return idx % 12 < 6 ? Element.fromIndex(idx / 12).direction : sixtyCycleMonth.sixtyCycleYear.jupiterDirection
    }

    /// 逐日胎神
    public var fetusDay: FetusDay {
        FetusDay.fromSixtyCycleDay(self)
    }

    /// 二十八宿
    public var twentyEightStar: TwentyEightStar {
        TwentyEightStar.fromIndex([10, 18, 26, 6, 14, 22, 2][solarDay.week.index]).next(-7 * sixtyCycle.earthBranch.index)
    }

    /// 三柱
    public var threePillars: ThreePillars {
        ThreePillars(year: yearPillar, month: monthPillar, day: sixtyCycle)
    }

    /// 神煞列表
    public var gods: [God] {
        GodLookup.getDayGods(month: monthPillar, day: sixtyCycle)
    }

    /// 宜
    public var recommends: [Taboo] {
        TabooLookup.getDayRecommends(month: monthPillar, day: sixtyCycle)
    }

    /// 忌
    public var avoids: [Taboo] {
        TabooLookup.getDayAvoids(month: monthPillar, day: sixtyCycle)
    }

    /// 干支时辰列表
    public var hours: [SixtyCycleHour] {
        var l: [SixtyCycleHour] = []
        let d = solarDay.next(-1)
        guard let st = try? SolarTime.fromYmdHms(d.year, d.month, d.day, 23, 0, 0) else {
            preconditionFailure("SixtyCycleDay: invalid solar time for hours")
        }
        var h = SixtyCycleHour.fromSolarTime(st)
        l.append(h)
        for _ in 0..<11 {
            h = h.next(7200)
            l.append(h)
        }
        return l
    }

    /// Get name
    public override func getName() -> String {
        return "\(sixtyCycle)日"
    }

    public override var description: String {
        "\(sixtyCycleMonth)\(getName())"
    }

    /// Get next SixtyCycleDay
    public func next(_ n: Int) -> SixtyCycleDay {
        return SixtyCycleDay(solarDay: solarDay.next(n))
    }

    /// Create from SolarDay
    public static func fromSolarDay(_ solarDay: SolarDay) -> SixtyCycleDay {
        return SixtyCycleDay(solarDay: solarDay)
    }

    /// Create from year, month, day
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> SixtyCycleDay {
        return try SixtyCycleDay(year: year, month: month, day: day)
    }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }

    @available(*, deprecated, renamed: "sixtyCycleMonth")
    public func getSixtyCycleMonth() -> SixtyCycleMonth { sixtyCycleMonth }

    @available(*, deprecated, renamed: "yearPillar")
    public func getYear() -> SixtyCycle { yearPillar }

    @available(*, deprecated, renamed: "monthPillar")
    public func getMonth() -> SixtyCycle { monthPillar }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "duty")
    public func getDuty() -> Duty { duty }

    @available(*, deprecated, renamed: "twelveStar")
    public func getTwelveStar() -> TwelveStar { twelveStar }

    @available(*, deprecated, renamed: "nineStar")
    public func getNineStar() -> NineStar { nineStar }

    @available(*, deprecated, renamed: "jupiterDirection")
    public func getJupiterDirection() -> Direction { jupiterDirection }

    @available(*, deprecated, renamed: "fetusDay")
    public func getFetusDay() -> FetusDay { fetusDay }

    @available(*, deprecated, renamed: "twentyEightStar")
    public func getTwentyEightStar() -> TwentyEightStar { twentyEightStar }

    @available(*, deprecated, renamed: "threePillars")
    public func getThreePillars() -> ThreePillars { threePillars }

    @available(*, deprecated, renamed: "gods")
    public func getGods() -> [God] { gods }

    @available(*, deprecated, renamed: "recommends")
    public func getRecommends() -> [Taboo] { recommends }

    @available(*, deprecated, renamed: "avoids")
    public func getAvoids() -> [Taboo] { avoids }

    @available(*, deprecated, renamed: "hours")
    public func getHours() -> [SixtyCycleHour] { hours }
}
