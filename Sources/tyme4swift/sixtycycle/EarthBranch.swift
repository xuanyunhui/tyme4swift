import Foundation

public final class EarthBranch: LoopTyme {
    public static let NAMES = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]

    public convenience init(index: Int) {
        self.init(names: EarthBranch.NAMES, index: index)
    }

    public convenience init(name: String) {
        self.init(names: EarthBranch.NAMES, name: name)
    }

    public static func fromIndex(_ index: Int) -> EarthBranch { EarthBranch(index: index) }
    public static func fromName(_ name: String) -> EarthBranch { EarthBranch(name: name) }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = EarthBranch.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> EarthBranch { EarthBranch.fromIndex(nextIndex(n)) }
}
