import Foundation

/// 灶马头(灶神的坐骑)
public final class KitchenGodSteed: AbstractCulture {

    public static let NUMBERS = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]

    /// 正月初一的干支
    private let firstDaySixtyCycle: SixtyCycle

    public init(lunarYear: Int) {
        guard let ld = try? LunarDay.fromYmd(lunarYear, 1, 1) else {
            preconditionFailure("KitchenGodSteed: invalid lunar day")
        }
        firstDaySixtyCycle = ld.sixtyCycle
    }

    public static func fromLunarYear(_ lunarYear: Int) -> KitchenGodSteed {
        KitchenGodSteed(lunarYear: lunarYear)
    }

    private func byHeavenStem(_ n: Int) -> String {
        KitchenGodSteed.NUMBERS[firstDaySixtyCycle.heavenStem.stepsTo(n)]
    }

    private func byEarthBranch(_ n: Int) -> String {
        KitchenGodSteed.NUMBERS[firstDaySixtyCycle.earthBranch.stepsTo(n)]
    }

    public var mouse: String { "\(byEarthBranch(0))鼠偷粮" }
    public var grass: String { "草子\(byEarthBranch(0))分" }
    public var cattle: String { "\(byEarthBranch(1))牛耕田" }
    public var flower: String { "花收\(byEarthBranch(3))分" }
    public var dragon: String { "\(byEarthBranch(4))龙治水" }
    public var horse: String { "\(byEarthBranch(6))马驮谷" }
    public var chicken: String { "\(byEarthBranch(9))鸡抢米" }
    public var silkworm: String { "\(byEarthBranch(9))姑看蚕" }
    public var pig: String { "\(byEarthBranch(11))屠共猪" }
    public var field: String { "甲田\(byHeavenStem(0))分" }
    public var cake: String { "\(byHeavenStem(2))人分饼" }
    public var gold: String { "\(byHeavenStem(7))日得金" }
    public var peopleCakes: String { "\(byEarthBranch(2))人\(byHeavenStem(2))丙" }
    public var peopleHoes: String { "\(byEarthBranch(2))人\(byHeavenStem(3))锄" }

    @available(*, deprecated, renamed: "mouse") public func getMouse() -> String { mouse }
    @available(*, deprecated, renamed: "grass") public func getGrass() -> String { grass }
    @available(*, deprecated, renamed: "cattle") public func getCattle() -> String { cattle }
    @available(*, deprecated, renamed: "flower") public func getFlower() -> String { flower }
    @available(*, deprecated, renamed: "dragon") public func getDragon() -> String { dragon }
    @available(*, deprecated, renamed: "horse") public func getHorse() -> String { horse }
    @available(*, deprecated, renamed: "chicken") public func getChicken() -> String { chicken }
    @available(*, deprecated, renamed: "silkworm") public func getSilkworm() -> String { silkworm }
    @available(*, deprecated, renamed: "pig") public func getPig() -> String { pig }
    @available(*, deprecated, renamed: "field") public func getField() -> String { field }
    @available(*, deprecated, renamed: "cake") public func getCake() -> String { cake }
    @available(*, deprecated, renamed: "gold") public func getGold() -> String { gold }
    @available(*, deprecated, renamed: "peopleCakes") public func getPeopleCakes() -> String { peopleCakes }
    @available(*, deprecated, renamed: "peopleHoes") public func getPeopleHoes() -> String { peopleHoes }

    public override func getName() -> String {
        "灶马头"
    }
}
