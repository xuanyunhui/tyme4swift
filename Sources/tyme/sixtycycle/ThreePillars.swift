import Foundation

/// 三柱（年柱、月柱、日柱）
public final class ThreePillars: AbstractCulture {
    public let year: SixtyCycle
    public let month: SixtyCycle
    public let day: SixtyCycle

    public init(year: SixtyCycle, month: SixtyCycle, day: SixtyCycle) {
        self.year = year
        self.month = month
        self.day = day
        super.init()
    }

    public convenience init(yearName: String, monthName: String, dayName: String) {
        guard let y = try? SixtyCycle.fromName(yearName),
              let m = try? SixtyCycle.fromName(monthName),
              let d = try? SixtyCycle.fromName(dayName) else {
            preconditionFailure("ThreePillars: invalid pillar names")
        }
        self.init(year: y, month: m, day: d)
    }

    /// 公历日列表
    /// - Parameters:
    ///   - startYear: 开始年(含)，支持1-9999年
    ///   - endYear: 结束年(含)，支持1-9999年
    /// - Returns: 公历日列表
    public func getSolarDays(startYear: Int, endYear: Int) -> [SolarDay] {
        var l: [SolarDay] = []
        // 月地支距寅月的偏移值
        var m = month.earthBranch.next(-2).index
        // 月天干要一致
        if HeavenStem.fromIndex((year.heavenStem.index + 1) * 2 + m).getName() != month.heavenStem.getName() {
            return l
        }
        // 1年的立春是辛酉，序号57
        var y = year.next(-57).index + 1
        // 节令偏移值
        m *= 2
        let baseYear = startYear - 1
        if baseYear > y {
            y += 60 * Int(ceil(Double(baseYear - y) / 60.0))
        }
        while y <= endYear {
            // 立春为寅月的开始
            var term = SolarTerm.fromIndex(y, 3)
            // 节令推移，年干支和月干支就都匹配上了
            if m > 0 {
                term = term.next(m)
            }
            var solarDay = term.solarDay
            if solarDay.year >= startYear {
                // 日干支和节令干支的偏移值
                let d = day.next(-solarDay.lunarDay.sixtyCycle.index).index
                if d > 0 {
                    // 从节令推移天数
                    solarDay = solarDay.next(d)
                }
                // 验证一下
                if solarDay.sixtyCycleDay.threePillars.getName() == getName() {
                    l.append(solarDay)
                }
            }
            y += 60
        }
        return l
    }

    public override func getName() -> String {
        "\(year) \(month) \(day)"
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> SixtyCycle { year }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> SixtyCycle { month }

    @available(*, deprecated, renamed: "day")
    public func getDay() -> SixtyCycle { day }
}
