import Foundation

/// 天干六甲胎神
/// 《天干六甲胎神歌》甲己之日占在门，乙庚碓磨休移动。丙辛厨灶莫相干，丁壬仓库忌修弄。戊癸房床若移整，犯之孕妇堕孩童。
public final class FetusHeavenStem: LoopTyme {
    public static let NAMES = ["门", "碓磨", "厨灶", "仓库", "房床"]

    public convenience init(index: Int) {
        self.init(names: FetusHeavenStem.NAMES, index: index)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public override func next(_ n: Int) -> FetusHeavenStem {
        FetusHeavenStem(index: nextIndex(n))
    }
}
