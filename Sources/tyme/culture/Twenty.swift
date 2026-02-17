import Foundation

/// 运（20年=1运，3运=1元）
///
/// Represents the nine "Yun" (运) periods within the traditional Chinese calendar cycle.
/// One Yun spans 20 years, three Yun form one Yuan (元), and three Yuan form one complete cycle.
public final class Twenty: LoopTyme {
    /// Twenty names (九运名称)
    public static let NAMES = ["一运", "二运", "三运", "四运", "五运", "六运", "七运", "八运", "九运"]

    /// Initialize with index
    /// - Parameter index: Twenty index (0-8)
    public convenience init(index: Int) {
        self.init(names: Twenty.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Twenty name (e.g., "一运", "二运", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Twenty.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Twenty from index
    /// - Parameter index: Twenty index (0-8)
    /// - Returns: Twenty instance
    public static func fromIndex(_ index: Int) -> Twenty {
        return Twenty(index: index)
    }

    /// Get Twenty from name
    /// - Parameter name: Twenty name (e.g., "一运", "二运", etc.)
    /// - Returns: Twenty instance
    public static func fromName(_ name: String) throws -> Twenty {
        return try Twenty(name: name)
    }

    /// Get next Twenty
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Twenty instance
    public override func next(_ n: Int) -> Twenty {
        return Twenty.fromIndex(nextIndex(n))
    }

    /// The Yuan (元) this Yun belongs to (every 3 Yun = 1 Yuan)
    public var sixty: Sixty {
        Sixty.fromIndex(index / 3)
    }
}
