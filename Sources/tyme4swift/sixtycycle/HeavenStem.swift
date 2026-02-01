import Foundation

public final class HeavenStem: LoopTyme {
    public static let NAMES = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]

    public convenience init(index: Int) {
        self.init(names: HeavenStem.NAMES, index: index)
    }

    public convenience init(name: String) {
        self.init(names: HeavenStem.NAMES, name: name)
    }

    public static func fromIndex(_ index: Int) -> HeavenStem { HeavenStem(index: index) }
    public static func fromName(_ name: String) -> HeavenStem { HeavenStem(name: name) }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = HeavenStem.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> HeavenStem { HeavenStem.fromIndex(nextIndex(n)) }
}
