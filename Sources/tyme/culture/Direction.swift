import Foundation

public final class Direction: LoopTyme {
    public static let NAMES = ["北","东北","东","东南","南","西南","西","西北"]

    public convenience init(index: Int) {
        self.init(names: Direction.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: Direction.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> Direction {
        Direction(index: index)
    }

    public static func fromName(_ name: String) throws -> Direction {
        try Direction(name: name)
    }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = Direction.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> Direction {
        Direction.fromIndex(nextIndex(n))
    }
    
    // Get angle in degrees (0 = North, 90 = East, 180 = South, 270 = West)
    public func getAngle() -> Int {
        return index * 45  // 8 directions, 45° each
    }
}
