import Foundation

public final class SixtyCycle: LoopTyme {
    public static let NAMES = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉", "甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛巳", "壬午", "癸未", "甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳", "甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸卯", "甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑", "甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥"]

    public convenience init(index: Int) {
        self.init(names: SixtyCycle.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: SixtyCycle.NAMES, name: name)
    }

    public static func fromIndex(_ index: Int) -> SixtyCycle { SixtyCycle(index: index) }
    public static func fromName(_ name: String) throws -> SixtyCycle {
        try SixtyCycle(name: name) }

    public func getHeavenStem() -> HeavenStem {
        HeavenStem.fromIndex(index % HeavenStem.NAMES.count)
    }

    public func getEarthBranch() -> EarthBranch {
        EarthBranch.fromIndex(index % EarthBranch.NAMES.count)
    }

    public override func next(_ n: Int) -> SixtyCycle { SixtyCycle.fromIndex(nextIndex(n)) }
}
