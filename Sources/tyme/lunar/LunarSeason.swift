import Foundation

public final class LunarSeason: LoopTyme {
    public static let NAMES = ["孟春", "仲春", "季春", "孟夏", "仲夏", "季夏", "孟秋", "仲秋", "季秋", "孟冬", "仲冬", "季冬"]

    public convenience init(index: Int) {
        self.init(names: LunarSeason.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: LunarSeason.NAMES, name: name)
    }

    public static func fromIndex(_ index: Int) -> LunarSeason {
        LunarSeason(index: index)
    }

    public static func fromName(_ name: String) throws -> LunarSeason {
        try LunarSeason(name: name)
    }

    public override func next(_ n: Int) -> LunarSeason {
        LunarSeason.fromIndex(nextIndex(n))
    }
}
