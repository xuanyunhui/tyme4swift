import Foundation

/// 梅雨 (Plum Rain)
/// The rainy season in East Asia
public final class PlumRain: LoopTyme {
    /// Plum rain names (梅雨名称)
    public static let NAMES = ["入梅", "出梅"]

    /// Initialize with index
    /// - Parameter index: PlumRain index (0=入梅, 1=出梅)
    public convenience init(index: Int) {
        self.init(names: PlumRain.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: PlumRain name ("入梅" or "出梅")
    public convenience init(name: String) throws {
        try self.init(names: PlumRain.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get PlumRain from index
    /// - Parameter index: PlumRain index (0=入梅, 1=出梅)
    /// - Returns: PlumRain instance
    public static func fromIndex(_ index: Int) -> PlumRain {
        return PlumRain(index: index)
    }

    /// Get PlumRain from name
    /// - Parameter name: PlumRain name ("入梅" or "出梅")
    /// - Returns: PlumRain instance
    public static func fromName(_ name: String) throws -> PlumRain {
        return try PlumRain(name: name)
    }

    /// Get next plum rain
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next PlumRain instance
    public override func next(_ n: Int) -> PlumRain {
        return PlumRain.fromIndex(nextIndex(n))
    }

    public var entering: Bool { index == 0 }
    public var exiting: Bool { index == 1 }

    @available(*, deprecated, renamed: "entering")
    public func isEntering() -> Bool { entering }

    @available(*, deprecated, renamed: "exiting")
    public func isExiting() -> Bool { exiting }
}
