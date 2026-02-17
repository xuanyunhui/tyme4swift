import Foundation

/// 公历现代节日
/// Modern Gregorian calendar festivals.
public final class SolarFestival: AbstractTyme {

    public static let NAMES = ["元旦", "三八妇女节", "植树节", "五一劳动节", "五四青年节", "六一儿童节", "建党节", "八一建军节", "教师节", "国庆节"]

    public static let DATA = "@00001011950@01003081950@02003121979@03005011950@04005041950@05006011950@06007011941@07008011933@08009101985@09010011950"

    /// The festival type (always .day for SolarFestival).
    public private(set) var type: FestivalType

    /// The 0-based index into NAMES.
    public private(set) var index: Int

    /// The Gregorian calendar date this festival falls on.
    public private(set) var solarDay: SolarDay

    /// The festival name.
    public private(set) var festivalName: String

    /// The year this festival was established.
    public private(set) var startYear: Int

    init(type: FestivalType, solarDay: SolarDay, startYear: Int, data: String) {
        self.type = type
        self.solarDay = solarDay
        self.startYear = startYear
        let idxStr = String(data[data.index(data.startIndex, offsetBy: 1)..<data.index(data.startIndex, offsetBy: 3)])
        self.index = Int(idxStr)!
        self.festivalName = SolarFestival.NAMES[self.index]
        super.init()
    }

    /// Creates a SolarFestival for the given year and festival index.
    /// - Parameters:
    ///   - year: Gregorian year.
    ///   - index: Festival index (0-based, must be < NAMES.count).
    /// - Returns: The festival, or nil if index is out of range, data not found, or year < startYear.
    public static func fromIndex(_ year: Int, _ index: Int) -> SolarFestival? {
        guard index >= 0 && index < NAMES.count else { return nil }
        let pattern = String(format: "@%02d\\d+", index)
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: DATA, range: NSRange(DATA.startIndex..., in: DATA)),
              let range = Range(match.range, in: DATA) else { return nil }
        let data = String(DATA[range])
        let typeChar = data[data.index(data.startIndex, offsetBy: 3)]
        guard typeChar == "0" else { return nil }
        let monthStr = String(data[data.index(data.startIndex, offsetBy: 4)..<data.index(data.startIndex, offsetBy: 6)])
        let dayStr = String(data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: 8)])
        let startYearStr = String(data[data.index(data.startIndex, offsetBy: 8)...])
        let month = Int(monthStr)!
        let day = Int(dayStr)!
        let startYear = Int(startYearStr)!
        guard year >= startYear else { return nil }
        guard let sd = try? SolarDay.fromYmd(year, month, day) else { return nil }
        return SolarFestival(type: .day, solarDay: sd, startYear: startYear, data: data)
    }

    /// Finds a SolarFestival occurring on the given Gregorian date.
    /// - Parameters:
    ///   - year: Gregorian year.
    ///   - month: Month (1-12).
    ///   - day: Day (1-31).
    /// - Returns: The festival, or nil if none falls on that date (or year < startYear).
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> SolarFestival? {
        let pattern = String(format: "@\\d{2}0%02d%02d\\d+", month, day)
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: DATA, range: NSRange(DATA.startIndex..., in: DATA)),
              let range = Range(match.range, in: DATA) else { return nil }
        let data = String(DATA[range])
        let startYearStr = String(data[data.index(data.startIndex, offsetBy: 8)...])
        let startYear = Int(startYearStr)!
        guard year >= startYear else { return nil }
        guard let sd = try? SolarDay.fromYmd(year, month, day) else { return nil }
        return SolarFestival(type: .day, solarDay: sd, startYear: startYear, data: data)
    }

    public override func getName() -> String { festivalName }

    public override func next(_ n: Int) -> SolarFestival {
        let size = SolarFestival.NAMES.count
        let year = solarDay.year
        let i = index + n
        let targetYear = (year * size + i) / size
        let targetIndex = ((i % size) + size) % size
        guard let result = SolarFestival.fromIndex(targetYear, targetIndex) else { return self }
        return result
    }

    public override var description: String {
        "\(solarDay) \(festivalName)"
    }
}
