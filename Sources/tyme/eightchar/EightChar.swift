import Foundation

/// 八字 (EightChar) - Birth Destiny System
/// 由年月日时四柱的干支组成，每柱一个 SixtyCycle
public final class EightChar: AbstractCulture {
    private let yearPillar: SixtyCycle
    private let monthPillar: SixtyCycle
    private let dayPillar: SixtyCycle
    private let hourPillar: SixtyCycle

    /// 通过四柱干支初始化
    public init(year: SixtyCycle, month: SixtyCycle, day: SixtyCycle, hour: SixtyCycle) {
        self.yearPillar = year
        self.monthPillar = month
        self.dayPillar = day
        self.hourPillar = hour
        super.init()
    }

    /// 通过四柱名称初始化
    public convenience init(year: String, month: String, day: String, hour: String) throws {
        self.init(
            year: try SixtyCycle.fromName(year),
            month: try SixtyCycle.fromName(month),
            day: try SixtyCycle.fromName(day),
            hour: try SixtyCycle.fromName(hour)
        )
    }

    // MARK: - 四柱 Pillars

    /// 年柱
    public var year: SixtyCycle { yearPillar }

    /// 月柱
    public var month: SixtyCycle { monthPillar }

    /// 日柱
    public var day: SixtyCycle { dayPillar }

    /// 时柱
    public var hour: SixtyCycle { hourPillar }

    // MARK: - 派生计算

    /// 胎元 — 月柱天干 next(1), 月柱地支 next(3)
    public var fetalOrigin: SixtyCycle {
        let m = month
        return try! SixtyCycle.fromName(
            m.heavenStem.next(1).getName() +
            m.earthBranch.next(3).getName()
        )
    }

    /// 胎息 — 日柱天干 next(5), 地支 = 13 - 日柱地支 index
    public var fetalBreath: SixtyCycle {
        let d = day
        return try! SixtyCycle.fromName(
            d.heavenStem.next(5).getName() +
            EarthBranch.fromIndex(13 - d.earthBranch.index).getName()
        )
    }

    /// 命宫
    public var ownSign: SixtyCycle {
        var m = month.earthBranch.index - 1
        if m < 1 { m += 12 }
        var h = hour.earthBranch.index - 1
        if h < 1 { h += 12 }
        let sum = m + h
        let offset = (sum >= 14 ? 26 : 14) - sum
        return try! SixtyCycle.fromName(
            HeavenStem.fromIndex((year.heavenStem.index + 1) * 2 + offset - 1).getName() +
            EarthBranch.fromIndex(offset + 1).getName()
        )
    }

    /// 身宫
    public var bodySign: SixtyCycle {
        var offset = month.earthBranch.index - 1
        if offset < 1 { offset += 12 }
        offset += hour.earthBranch.index + 1
        if offset > 12 { offset -= 12 }
        return try! SixtyCycle.fromName(
            HeavenStem.fromIndex((year.heavenStem.index + 1) * 2 + offset - 1).getName() +
            EarthBranch.fromIndex(offset + 1).getName()
        )
    }

    /// 反查公历时刻：给定年份范围，找出所有匹配此八字的 SolarTime
    public func getSolarTimes(startYear: Int, endYear: Int) -> [SolarTime] {
        var result: [SolarTime] = []
        // 月地支距寅月的偏移值
        let m = month.earthBranch.next(-2).index
        // 月天干要一致
        if HeavenStem.fromIndex((year.heavenStem.index + 1) * 2 + m) != month.heavenStem {
            return result
        }
        // 1年的立春是辛酉，序号57
        var y = year.next(-57).index + 1
        // 节令偏移值
        let termOffset = m * 2
        // 时辰地支转时刻
        let h = hour.earthBranch.index * 2
        let hours = h == 0 ? [0, 23] : [h]
        let baseYear = startYear - 1
        if baseYear > y {
            y += 60 * Int(ceil(Double(baseYear - y) / 60.0))
        }
        while y <= endYear {
            // 立春为寅月的开始
            var term = SolarTerm.fromIndex(y, 3)
            // 节令推移
            if termOffset > 0 {
                term = term.next(termOffset)
            }
            let solarTime = term.julianDay.solarTime
            if solarTime.year >= startYear {
                // 日干支和节令干支的偏移值
                let solarDay = solarTime.solarDay
                let d = day.next(-solarDay.lunarDay.sixtyCycle.index).index
                var targetDay = solarDay
                if d > 0 {
                    targetDay = solarDay.next(d)
                }
                for hr in hours {
                    var mi = 0
                    var s = 0
                    if d == 0 && hr == solarTime.hour {
                        mi = solarTime.minute
                        s = solarTime.second
                    }
                    var time = try! SolarTime.fromYmdHms(targetDay.year, targetDay.month, targetDay.day, hr, mi, s)
                    if d == 30 {
                        time = time.next(-3600)
                    }
                    // 验证
                    if time.lunarHour.eightChar == self {
                        result.append(time)
                    }
                }
            }
            y += 60
        }
        return result
    }

    // MARK: - Culture

    public override func getName() -> String {
        "\(year.getName()) \(month.getName()) \(day.getName()) \(hour.getName())"
    }
}

// MARK: - Equatable

extension EightChar: Equatable, Hashable {
    public static func == (lhs: EightChar, rhs: EightChar) -> Bool {
        lhs.year == rhs.year && lhs.month == rhs.month &&
        lhs.day == rhs.day && lhs.hour == rhs.hour
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(month)
        hasher.combine(day)
        hasher.combine(hour)
    }
}

// MARK: - Codable

extension EightChar: Codable {
    private enum CodingKeys: String, CodingKey {
        case year, month, day, hour
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            year: SixtyCycle(index: try container.decode(Int.self, forKey: .year)),
            month: SixtyCycle(index: try container.decode(Int.self, forKey: .month)),
            day: SixtyCycle(index: try container.decode(Int.self, forKey: .day)),
            hour: SixtyCycle(index: try container.decode(Int.self, forKey: .hour))
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(year.index, forKey: .year)
        try container.encode(month.index, forKey: .month)
        try container.encode(day.index, forKey: .day)
        try container.encode(hour.index, forKey: .hour)
    }
}
