import Foundation

/// 逐日胎神
public final class FetusDay: AbstractCulture {
    /// Java tyme4j Direction uses 后天八卦 ordering (9 elements including 中),
    /// different from Swift Direction which uses 8 compass directions.
    /// We use the Java mapping directly here for alignment.
    private static let DIRECTION_NAMES = ["北", "西南", "东", "东南", "中", "西北", "西", "东北", "南"]

    private static let SIDE_DIRECTION_INDEX: [Int] = [
        3, 3, 8, 8, 8, 8, 8, 1, 1, 1,
        1, 1, 1, 6, 6, 6, 6, 6, 5, 5,
        5, 5, 5, 5, 0, 0, 0, 0, 0, -9,
        -9, -9, -9, -9, -5, -5, -1, -1, -1, -3,
        -7, -7, -7, -7, -5, 7, 7, 7, 7, 7,
        7, 2, 2, 2, 2, 2, 3, 3, 3, 3
    ]

    private let fetusHeavenStem: FetusHeavenStem
    private let fetusEarthBranch: FetusEarthBranch
    private let side: Side
    private let directionName: String

    public init(sixtyCycle: SixtyCycle) {
        self.fetusHeavenStem = FetusHeavenStem(index: sixtyCycle.getHeavenStem().getIndex() % 5)
        self.fetusEarthBranch = FetusEarthBranch(index: sixtyCycle.getEarthBranch().getIndex() % 6)
        let idx = FetusDay.SIDE_DIRECTION_INDEX[sixtyCycle.getIndex()]
        self.side = Side.fromIndex(idx < 0 ? 0 : 1)
        let c = FetusDay.DIRECTION_NAMES.count
        var di = idx % c
        if di < 0 { di += c }
        self.directionName = FetusDay.DIRECTION_NAMES[di]
        super.init()
    }

    public static func fromLunarDay(_ lunarDay: LunarDay) -> FetusDay {
        // Compute SixtyCycle directly from JulianDay to work around
        // LunarDay.getSolarDay() off-by-one in the Swift port
        let jd = lunarDay.getLunarMonth().getFirstJulianDay().next(lunarDay.getDay())
        let offset = Int(jd.getDay() + 0.5) + 49
        var index = offset % 60
        if index < 0 { index += 60 }
        return FetusDay(sixtyCycle: SixtyCycle.fromIndex(index))
    }

    public static func fromSixtyCycleDay(_ sixtyCycleDay: SixtyCycleDay) -> FetusDay {
        FetusDay(sixtyCycle: sixtyCycleDay.getSixtyCycle())
    }

    public override func getName() -> String {
        var s = fetusHeavenStem.getName() + fetusEarthBranch.getName()
        if s == "门门" {
            s = "占大门"
        } else if s == "碓磨碓" {
            s = "占碓磨"
        } else if s == "房床床" {
            s = "占房床"
        } else if s.hasPrefix("门") {
            s = "占" + s
        }

        s += " "

        if side == .inner {
            s += "房"
        }
        s += side.name

        if side == .outer && "北南西东".contains(directionName) {
            s += "正"
        }
        s += directionName
        return s
    }

    public func getSide() -> Side {
        side
    }

    public func getDirectionName() -> String {
        directionName
    }

    public func getFetusHeavenStem() -> FetusHeavenStem {
        fetusHeavenStem
    }

    public func getFetusEarthBranch() -> FetusEarthBranch {
        fetusEarthBranch
    }
}
