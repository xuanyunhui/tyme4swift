import Foundation

/// 藏干 (Hidden Heaven Stem)
/// Represents the hidden heaven stems within an earth branch
public final class HideHeavenStem: AbstractCulture {
    public let heavenStem: HeavenStem
    public let hideType: HideHeavenStemType

    /// Initialize with heaven stem and type
    /// - Parameters:
    ///   - heavenStem: The hidden heaven stem
    ///   - type: The type of hidden stem (本气, 中气, 余气)
    public init(heavenStem: HeavenStem, type: HideHeavenStemType) {
        self.heavenStem = heavenStem
        self.hideType = type
        super.init()
    }

    /// Get name
    /// - Returns: Heaven stem name
    public override func getName() -> String {
        return heavenStem.getName()
    }

    /// Check if main qi (本气)
    public func isMain() -> Bool {
        return hideType.isMain
    }

    /// Check if middle qi (中气)
    public func isMiddle() -> Bool {
        return hideType.isMiddle
    }

    /// Check if residual qi (余气)
    public func isResidual() -> Bool {
        return hideType.isResidual
    }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "hideType")
    public func getType() -> HideHeavenStemType { hideType }
}
