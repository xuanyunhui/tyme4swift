import Foundation

/// 北斗九星
public final class Dipper: LoopTyme {
    public static let NAMES = ["天枢", "天璇", "天玑", "天权", "玉衡", "开阳", "摇光", "洞明", "隐元"]

    public convenience init(index: Int) {
        self.init(names: Dipper.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: Dipper.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> Dipper {
        Dipper(index: index)
    }

    public static func fromName(_ name: String) throws -> Dipper {
        try Dipper(name: name)
    }

    public override func next(_ n: Int) -> Dipper {
        Dipper.fromIndex(nextIndex(n))
    }
}
