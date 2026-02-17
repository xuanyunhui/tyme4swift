import Foundation

public final class Week: LoopTyme {
    public static let NAMES = ["日","一","二","三","四","五","六"]

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public convenience init(index: Int) {
        self.init(names: Week.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: Week.NAMES, name: name)
    }

    public static func fromIndex(_ index: Int) -> Week { Week(index: index) }
    public static func fromName(_ name: String) throws -> Week {
        try Week(name: name) }

    public override func next(_ n: Int) -> Week { Week.fromIndex(nextIndex(n)) }
}
