import Foundation

/// 灶马头(灶神的坐骑)
public final class KitchenGodSteed: AbstractCulture {

    public static let NUMBERS = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]

    /// 正月初一的干支
    private let firstDaySixtyCycle: SixtyCycle

    public init(lunarYear: Int) {
        firstDaySixtyCycle = LunarDay.fromYmd(lunarYear, 1, 1).getSixtyCycle()
    }

    public static func fromLunarYear(_ lunarYear: Int) -> KitchenGodSteed {
        KitchenGodSteed(lunarYear: lunarYear)
    }

    private func byHeavenStem(_ n: Int) -> String {
        KitchenGodSteed.NUMBERS[firstDaySixtyCycle.getHeavenStem().stepsTo(n)]
    }

    private func byEarthBranch(_ n: Int) -> String {
        KitchenGodSteed.NUMBERS[firstDaySixtyCycle.getEarthBranch().stepsTo(n)]
    }

    /// 几鼠偷粮
    public func getMouse() -> String {
        "\(byEarthBranch(0))鼠偷粮"
    }

    /// 草子几分
    public func getGrass() -> String {
        "草子\(byEarthBranch(0))分"
    }

    /// 几牛耕田
    public func getCattle() -> String {
        "\(byEarthBranch(1))牛耕田"
    }

    /// 花收几分
    public func getFlower() -> String {
        "花收\(byEarthBranch(3))分"
    }

    /// 几龙治水
    public func getDragon() -> String {
        "\(byEarthBranch(4))龙治水"
    }

    /// 几马驮谷
    public func getHorse() -> String {
        "\(byEarthBranch(6))马驮谷"
    }

    /// 几鸡抢米
    public func getChicken() -> String {
        "\(byEarthBranch(9))鸡抢米"
    }

    /// 几姑看蚕
    public func getSilkworm() -> String {
        "\(byEarthBranch(9))姑看蚕"
    }

    /// 几屠共猪
    public func getPig() -> String {
        "\(byEarthBranch(11))屠共猪"
    }

    /// 甲田几分
    public func getField() -> String {
        "甲田\(byHeavenStem(0))分"
    }

    /// 几人分饼
    public func getCake() -> String {
        "\(byHeavenStem(2))人分饼"
    }

    /// 几日得金
    public func getGold() -> String {
        "\(byHeavenStem(7))日得金"
    }

    /// 几人几丙
    public func getPeopleCakes() -> String {
        "\(byEarthBranch(2))人\(byHeavenStem(2))丙"
    }

    /// 几人几锄
    public func getPeopleHoes() -> String {
        "\(byEarthBranch(2))人\(byHeavenStem(3))锄"
    }

    public override func getName() -> String {
        "灶马头"
    }
}
