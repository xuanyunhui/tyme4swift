import Foundation

/// 逐日胎神
public final class FetusDay: AbstractCulture {
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
    private let direction: Direction

    public init(sixtyCycle: SixtyCycle) {
        self.fetusHeavenStem = FetusHeavenStem(index: sixtyCycle.getHeavenStem().getIndex() % 5)
        self.fetusEarthBranch = FetusEarthBranch(index: sixtyCycle.getEarthBranch().getIndex() % 6)
        let idx = FetusDay.SIDE_DIRECTION_INDEX[sixtyCycle.getIndex()]
        self.side = Side.fromIndex(idx < 0 ? 0 : 1)
        self.direction = Direction.fromIndex(idx)
        super.init()
    }

    public static func fromLunarDay(_ lunarDay: LunarDay) -> FetusDay {
        FetusDay(sixtyCycle: SixtyCycleDay.fromSolarDay(lunarDay.getSolarDay()).getSixtyCycle())
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

        let directionName = direction.getName()
        if side == .outer && "北南西东".contains(directionName) {
            s += "正"
        }
        s += directionName
        return s
    }

    public func getSide() -> Side {
        side
    }

    public func getDirection() -> Direction {
        direction
    }

    public func getFetusHeavenStem() -> FetusHeavenStem {
        fetusHeavenStem
    }

    public func getFetusEarthBranch() -> FetusEarthBranch {
        fetusEarthBranch
    }
}
