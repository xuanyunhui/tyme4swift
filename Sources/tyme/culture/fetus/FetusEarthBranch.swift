import Foundation

/// 地支六甲胎神
/// 《地支六甲胎神歌》子午二日碓须忌，丑未厕道莫修移。寅申火炉休要动，卯酉大门修当避。辰戌鸡栖巳亥床，犯着六甲身堕胎。
public final class FetusEarthBranch: LoopTyme {
    public static let NAMES = ["碓", "厕", "炉", "门", "栖", "床"]

    public convenience init(index: Int) {
        self.init(names: FetusEarthBranch.NAMES, index: index)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public override func next(_ n: Int) -> FetusEarthBranch {
        FetusEarthBranch(index: nextIndex(n))
    }
}
