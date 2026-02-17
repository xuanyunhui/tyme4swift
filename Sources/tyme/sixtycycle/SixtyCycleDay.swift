import Foundation

/// 日柱 (SixtyCycle Day)
/// Represents a day in the SixtyCycle system
public final class SixtyCycleDay: AbstractCulture {
    public let solarDay: SolarDay
    public let sixtyCycle: SixtyCycle

    /// Initialize with SolarDay
    /// - Parameter solarDay: The solar day
    public init(solarDay: SolarDay) {
        self.solarDay = solarDay
        let offset = Int(solarDay.julianDay.value + 0.5) + 49
        var index = offset % 60
        if index < 0 { index += 60 }
        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    /// Initialize with year, month, day
    public convenience init(year: Int, month: Int, day: Int) throws {
        self.init(solarDay: try SolarDay(year: year, month: month, day: day))
    }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }
    public var duty: Duty {
        let monthBranchIndex = (solarDay.month + 1) % 12
        let dayBranchIndex = sixtyCycle.earthBranch.index
        var dutyIndex = (dayBranchIndex - monthBranchIndex) % 12
        if dutyIndex < 0 { dutyIndex += 12 }
        return Duty.fromIndex(dutyIndex)
    }
    public var twentyEightStar: TwentyEightStar {
        let offset = Int(solarDay.julianDay.value + 0.5) + 11
        var index = offset % 28
        if index < 0 { index += 28 }
        return TwentyEightStar.fromIndex(index)
    }
    public var threePillars: ThreePillars {
        let term = findPrevailingTerm()
        let termIndex = term.index
        let termYear = term.year

        let offset: Int
        if termIndex < 3 {
            offset = termIndex == 0 ? -2 : -1
        } else {
            offset = (termIndex - 3) / 2
        }

        let cycleYear = offset < 0 ? termYear - 1 : termYear
        let yearSixtyCycle = SixtyCycle.fromIndex(cycleYear - 4)

        let yearHeavenStemIndex = yearSixtyCycle.heavenStem.index
        let firstMonthHeavenStemIndex = (yearHeavenStemIndex + 1) * 2
        let normalizedOffset = offset < 0 ? offset + 12 : offset
        let monthHeavenStemIndex = (firstMonthHeavenStemIndex + normalizedOffset) % 10
        let monthEarthBranchIndex = (2 + normalizedOffset) % 12
        let monthName = HeavenStem.NAMES[monthHeavenStemIndex] + EarthBranch.NAMES[monthEarthBranchIndex]
        let monthSixtyCycle = try! SixtyCycle.fromName(monthName)

        return ThreePillars(year: yearSixtyCycle, month: monthSixtyCycle, day: sixtyCycle)
    }
    public var gods: [God] {
        GodLookup.getDayGods(month: threePillars.month, day: sixtyCycle)
    }
    public var recommends: [Taboo] {
        TabooLookup.getDayRecommends(month: threePillars.month, day: sixtyCycle)
    }
    public var avoids: [Taboo] {
        TabooLookup.getDayAvoids(month: threePillars.month, day: sixtyCycle)
    }

    /// Get name
    /// - Returns: SixtyCycle name
    public override func getName() -> String {
        return sixtyCycle.getName()
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

    private func findPrevailingTerm() -> SolarTerm {
        var y = solarDay.year
        var i = solarDay.month * 2
        if i == 24 {
            y += 1
            i = 0
        }
        var term = SolarTerm.fromIndex(y, i + 1)
        var termDay = term.solarDay
        while solarDay.isBefore(termDay) {
            term = term.next(-1)
            termDay = term.solarDay
        }
        return term
    }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }

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
}
