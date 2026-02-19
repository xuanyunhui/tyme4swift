import Foundation

/// 藏历年
/// 藏历元年为公历1027年（第一饶迥火兔年）
/// 算法对齐 tyme4j com.tyme.rabbyung.RabByungYear
public final class RabByungYear: AbstractTyme {

    /// 饶迥(胜生周)序号，从0开始
    public let rabByungIndex: Int

    /// 干支
    public let sixtyCycle: SixtyCycle

    public init(rabByungIndex: Int, sixtyCycle: SixtyCycle) throws {
        guard rabByungIndex >= 0, rabByungIndex <= 150 else {
            throw TymeError.invalidIndex(rabByungIndex)
        }
        self.rabByungIndex = rabByungIndex
        self.sixtyCycle = sixtyCycle
        super.init()
    }

    // MARK: - Factory Methods

    /// 由公历年推算藏历年（有效范围约 1024-10083，对应饶迥序号 0-150）
    public static func fromYear(_ year: Int) throws -> RabByungYear {
        let rabByungIndex = (year - 1024) / 60
        guard rabByungIndex >= 0, rabByungIndex <= 150 else {
            throw TymeError.invalidYear(year)
        }
        return try RabByungYear(rabByungIndex: rabByungIndex, sixtyCycle: SixtyCycle.fromIndex(year - 4))
    }

    /// 由饶迥序号和干支直接构造
    public static func fromSixtyCycle(_ rabByungIndex: Int, _ sixtyCycle: SixtyCycle) throws -> RabByungYear {
        try RabByungYear(rabByungIndex: rabByungIndex, sixtyCycle: sixtyCycle)
    }

    /// 由饶迥序号、藏历五行和生肖构造
    public static func fromElementZodiac(_ rabByungIndex: Int, _ element: RabByungElement, _ zodiac: Zodiac) throws -> RabByungYear {
        for i in 0..<60 {
            let sc = SixtyCycle.fromIndex(i)
            if sc.earthBranch.zodiac == zodiac && sc.heavenStem.element.index == element.index {
                return try RabByungYear(rabByungIndex: rabByungIndex, sixtyCycle: sc)
            }
        }
        throw TymeError.invalidIndex(rabByungIndex)
    }

    // MARK: - Computed Properties

    /// 公历年
    public var year: Int { 1024 + rabByungIndex * 60 + sixtyCycle.index }

    /// 藏历五行；index 始终在 0-4 范围内，nil 情况实际不可达
    public var element: RabByungElement? { try? RabByungElement(index: sixtyCycle.heavenStem.element.index) }

    /// 生肖
    public var zodiac: Zodiac { sixtyCycle.earthBranch.zodiac }

    /// 名称，格式：第X饶迥五行生肖年
    public override func getName() -> String {
        let digits = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
        let units = ["", "十", "百"]
        var n = rabByungIndex + 1
        var s = ""
        var pos = 0
        while n > 0 {
            let digit = n % 10
            if digit > 0 {
                s = digits[digit] + units[pos] + s
            } else if !s.isEmpty {
                s = digits[digit] + s
            }
            n /= 10
            pos += 1
        }
        if s.hasPrefix("一十") {
            s = String(s.dropFirst())
        }
        return "第\(s)饶迥\(element?.getName() ?? "")\(zodiac.getName())年"
    }

    /// 闰月，0表示无闰月
    public var leapMonth: Int {
        var y = 1
        var m = 4
        var t = 0
        let currentYear = year
        while y < currentYear {
            let i = m - 1 + (t % 2 == 0 ? 33 : 32)
            y = (y * 12 + i) / 12
            m = i % 12 + 1
            t += 1
        }
        return y == currentYear ? m : 0
    }

    /// 对应公历年（年份超出 SolarYear 支持范围 1-9999 时返回 nil）
    public var solarYear: SolarYear? { try? SolarYear.fromYear(year) }

    /// 月份数量（含闰月为13，否则12）
    public var monthCount: Int { leapMonth < 1 ? 12 : 13 }

    /// 向前/后导航 n 个藏历年；超出饶迥合法范围（rabByungIndex 0-150）时返回 self（当前年），
    /// 保持与 AbstractTyme.next() 非抛出签名一致。
    public override func next(_ n: Int) -> RabByungYear {
        (try? RabByungYear.fromYear(year + n)) ?? self
    }

    // MARK: - Deprecated API

    @available(*, deprecated, renamed: "rabByungIndex")
    public func getRabByungIndex() -> Int { rabByungIndex }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "element")
    public func getElement() -> RabByungElement? { element }

    @available(*, deprecated, renamed: "zodiac")
    public func getZodiac() -> Zodiac { zodiac }

    @available(*, deprecated, renamed: "leapMonth")
    public func getLeapMonth() -> Int { leapMonth }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> SolarYear? { solarYear }

    @available(*, deprecated, renamed: "monthCount")
    public func getMonthCount() -> Int { monthCount }
}
