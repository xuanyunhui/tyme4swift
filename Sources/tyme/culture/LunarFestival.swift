import Foundation

/// 农历传统节日（依据国家标准《农历的编算和颁行》GB/T 33661-2017）
/// Traditional Chinese lunar festivals (per national standard GB/T 33661-2017).
public final class LunarFestival: AbstractTyme {

    public static let NAMES = ["春节", "元宵节", "龙头节", "上巳节", "清明节", "端午节", "七夕节", "中元节", "中秋节", "重阳节", "冬至节", "腊八节", "除夕"]

    public static let DATA = "@0000101@0100115@0200202@0300303@04107@0500505@0600707@0700715@0800815@0900909@10124@1101208@122"

    /// The festival type (日期, 节气, or 除夕).
    public private(set) var type: FestivalType

    /// The 0-based index into NAMES.
    public private(set) var index: Int

    /// The lunar day this festival falls on.
    public private(set) var lunarDay: LunarDay

    /// The solar term (non-nil only when type == .term).
    public private(set) var solarTerm: SolarTerm?

    /// The festival name.
    public private(set) var festivalName: String

    init(type: FestivalType, lunarDay: LunarDay, solarTerm: SolarTerm?, data: String) {
        self.type = type
        self.lunarDay = lunarDay
        self.solarTerm = solarTerm
        let idxStr = String(data[data.index(data.startIndex, offsetBy: 1)..<data.index(data.startIndex, offsetBy: 3)])
        self.index = Int(idxStr)!
        self.festivalName = LunarFestival.NAMES[self.index]
        super.init()
    }

    /// Creates a LunarFestival for the given year and festival index.
    /// - Parameters:
    ///   - year: Lunar year.
    ///   - index: Festival index (0-based, must be < NAMES.count).
    /// - Returns: The festival, or nil if index is out of range or data not found.
    public static func fromIndex(_ year: Int, _ index: Int) -> LunarFestival? {
        guard index >= 0 && index < NAMES.count else { return nil }
        let pattern = String(format: "@%02d\\d+", index)
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: DATA, range: NSRange(DATA.startIndex..., in: DATA)) else {
            return nil
        }
        guard let range = Range(match.range, in: DATA) else { return nil }
        let data = String(DATA[range])
        let typeCode = Int(String(data[data.index(data.startIndex, offsetBy: 3)]))!
        let type = FestivalType.fromIndex(typeCode)
        switch type {
        case .day:
            let monthStr = String(data[data.index(data.startIndex, offsetBy: 4)..<data.index(data.startIndex, offsetBy: 6)])
            let dayStr = String(data[data.index(data.startIndex, offsetBy: 6)...])
            let month = Int(monthStr)!
            let day = Int(dayStr)!
            guard let ld = try? LunarDay.fromYmd(year, month, day) else { return nil }
            return LunarFestival(type: type, lunarDay: ld, solarTerm: nil, data: data)
        case .term:
            let termIndexStr = String(data[data.index(data.startIndex, offsetBy: 4)...])
            let termIndex = Int(termIndexStr)!
            let st = SolarTerm.fromIndex(year, termIndex)
            guard let ld = try? st.solarDay.lunarDay else { return nil }
            return LunarFestival(type: type, lunarDay: ld, solarTerm: st, data: data)
        case .eve:
            guard let nextYear1Day1 = try? LunarDay.fromYmd(year + 1, 1, 1) else { return nil }
            let ld = nextYear1Day1.next(-1)
            return LunarFestival(type: type, lunarDay: ld, solarTerm: nil, data: data)
        }
    }

    /// Finds a LunarFestival occurring on the given lunar date.
    /// - Parameters:
    ///   - year: Lunar year.
    ///   - month: Lunar month (positive).
    ///   - day: Lunar day.
    /// - Returns: The festival, or nil if none falls on that date.
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> LunarFestival? {
        // Check DAY type festivals
        let dayPattern = String(format: "@\\d{2}0%02d%02d", month, day)
        if let regex = try? NSRegularExpression(pattern: dayPattern),
           let match = regex.firstMatch(in: DATA, range: NSRange(DATA.startIndex..., in: DATA)),
           let range = Range(match.range, in: DATA) {
            let data = String(DATA[range])
            guard let ld = try? LunarDay.fromYmd(year, month, day) else { return nil }
            return LunarFestival(type: .day, lunarDay: ld, solarTerm: nil, data: data)
        }

        // Check TERM type festivals
        guard let lunarDay = try? LunarDay.fromYmd(year, month, day) else { return nil }
        let solarDay = lunarDay.solarDay

        let termPattern = "@\\d{2}1\\d{2}"
        if let regex = try? NSRegularExpression(pattern: termPattern) {
            let matches = regex.matches(in: DATA, range: NSRange(DATA.startIndex..., in: DATA))
            for match in matches {
                guard let range = Range(match.range, in: DATA) else { continue }
                let data = String(DATA[range])
                let termIndexStr = String(data[data.index(data.startIndex, offsetBy: 4)...])
                let termIndex = Int(termIndexStr)!
                let term = SolarTerm.fromIndex(year, termIndex)
                let termDay = term.solarDay
                if termDay.year == solarDay.year && termDay.month == solarDay.month && termDay.day == solarDay.day {
                    return LunarFestival(type: .term, lunarDay: lunarDay, solarTerm: term, data: data)
                }
            }
        }

        // Check EVE type (除夕)
        if month == 12 && day > 28 {
            let evePattern = "@\\d{2}2"
            if let regex = try? NSRegularExpression(pattern: evePattern),
               let match = regex.firstMatch(in: DATA, range: NSRange(DATA.startIndex..., in: DATA)),
               let range = Range(match.range, in: DATA) {
                let data = String(DATA[range])
                let nextDay = lunarDay.next(1)
                if nextDay.month == 1 && nextDay.day == 1 {
                    return LunarFestival(type: .eve, lunarDay: lunarDay, solarTerm: nil, data: data)
                }
            }
        }

        return nil
    }

    /// The Gregorian calendar date this festival falls on.
    public var solarDay: SolarDay { lunarDay.solarDay }

    public override func getName() -> String { festivalName }

    public override func next(_ n: Int) -> LunarFestival {
        let size = LunarFestival.NAMES.count
        let year = lunarDay.year
        let i = index + n
        let targetYear = (year * size + i) / size
        let targetIndex = ((i % size) + size) % size
        return LunarFestival.fromIndex(targetYear, targetIndex)!
    }

    public override var description: String {
        "\(lunarDay) \(festivalName)"
    }
}
