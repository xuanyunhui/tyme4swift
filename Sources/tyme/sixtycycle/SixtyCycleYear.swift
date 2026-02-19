import Foundation

/// 年柱 (SixtyCycle Year)
/// Represents a year in the SixtyCycle system
public final class SixtyCycleYear: AbstractCulture {
    public let year: Int
    public let sixtyCycle: SixtyCycle

    /// Initialize with year
    /// - Parameter year: The year
    public init(year: Int) {
        self.year = year
        var index = (year - 4) % 60
        if index < 0 { index += 60 }
        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }
    public var zodiac: Zodiac { Zodiac.fromIndex(sixtyCycle.earthBranch.index) }

    /// 运
    public var twenty: Twenty {
        Twenty.fromIndex(Int(floor(Double(year - 1864) / 20.0)))
    }

    /// 九星
    public var nineStar: NineStar {
        NineStar.fromIndex(63 + twenty.sixty.index * 3 - sixtyCycle.index)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        Direction.fromIndex([0, 7, 7, 2, 3, 3, 8, 1, 1, 6, 0, 0][sixtyCycle.earthBranch.index])
    }

    /// 首月（五虎遁月）
    public var firstMonth: SixtyCycleMonth {
        let h = HeavenStem.fromIndex((sixtyCycle.heavenStem.index + 1) * 2)
        guard let sc = try? SixtyCycle.fromName(h.getName() + "寅") else {
            preconditionFailure("SixtyCycleYear: invalid first month calculation")
        }
        return SixtyCycleMonth(year: self, month: sc)
    }

    /// 本年所有干支月（12个）
    public var months: [SixtyCycleMonth] {
        var l: [SixtyCycleMonth] = []
        let m = firstMonth
        l.append(m)
        for i in 1..<12 {
            l.append(m.next(i))
        }
        return l
    }

    /// Get name
    /// - Returns: SixtyCycle name with 年 suffix
    public override func getName() -> String {
        return "\(sixtyCycle.getName())年"
    }

    /// Get next SixtyCycleYear
    /// - Parameter n: Number of years to advance
    /// - Returns: Next SixtyCycleYear
    public func next(_ n: Int) -> SixtyCycleYear {
        return SixtyCycleYear(year: year + n)
    }

    /// Create from year
    /// - Parameter year: The year
    /// - Returns: SixtyCycleYear instance
    public static func fromYear(_ year: Int) -> SixtyCycleYear {
        return SixtyCycleYear(year: year)
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "zodiac")
    public func getZodiac() -> Zodiac { zodiac }

    @available(*, deprecated, renamed: "twenty")
    public func getTwenty() -> Twenty { twenty }

    @available(*, deprecated, renamed: "nineStar")
    public func getNineStar() -> NineStar { nineStar }

    @available(*, deprecated, renamed: "jupiterDirection")
    public func getJupiterDirection() -> Direction { jupiterDirection }

    @available(*, deprecated, renamed: "firstMonth")
    public func getFirstMonth() -> SixtyCycleMonth { firstMonth }

    @available(*, deprecated, renamed: "months")
    public func getMonths() -> [SixtyCycleMonth] { months }
}
