import Foundation

/// 藏干 (Hidden Heaven Stem)
/// Represents the hidden heaven stems within an earth branch
public final class HideHeavenStem: AbstractCulture {
    private let heavenStem: HeavenStem
    private let hideType: HideHeavenStemType

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

    /// Get heaven stem
    /// - Returns: HeavenStem instance
    public func getHeavenStem() -> HeavenStem {
        return heavenStem
    }

    /// Get hide type
    /// - Returns: HideHeavenStemType
    public func getType() -> HideHeavenStemType {
        return hideType
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
}

/// Extension to EarthBranch for hidden stems
extension EarthBranch {
    /// Hidden stems data for each earth branch
    /// Format: [main, middle, residual] - nil means no stem for that position
    private static let HIDE_STEMS: [[Int?]] = [
        [9, nil, nil],      // 子: 癸
        [5, 9, 7],          // 丑: 己癸辛
        [0, 2, 4],          // 寅: 甲丙戊
        [1, nil, nil],      // 卯: 乙
        [4, 1, 9],          // 辰: 戊乙癸
        [2, 4, 6],          // 巳: 丙戊庚
        [3, 5, nil],        // 午: 丁己
        [5, 3, 1],          // 未: 己丁乙
        [6, 4, 8],          // 申: 庚戊壬
        [7, nil, nil],      // 酉: 辛
        [4, 7, 3],          // 戌: 戊辛丁
        [8, 0, nil]         // 亥: 壬甲
    ]

    /// Get hidden heaven stems
    /// - Returns: Array of HideHeavenStem
    public func getHideHeavenStems() -> [HideHeavenStem] {
        var result: [HideHeavenStem] = []
        let stems = EarthBranch.HIDE_STEMS[index]

        if let mainIndex = stems[0] {
            result.append(HideHeavenStem(heavenStem: HeavenStem.fromIndex(mainIndex), type: .main))
        }
        if let middleIndex = stems[1] {
            result.append(HideHeavenStem(heavenStem: HeavenStem.fromIndex(middleIndex), type: .middle))
        }
        if let residualIndex = stems[2] {
            result.append(HideHeavenStem(heavenStem: HeavenStem.fromIndex(residualIndex), type: .residual))
        }

        return result
    }

    /// Get main hidden heaven stem (本气)
    /// - Returns: HeavenStem or nil
    public func getMainHideHeavenStem() -> HeavenStem? {
        if let mainIndex = EarthBranch.HIDE_STEMS[index][0] {
            return HeavenStem.fromIndex(mainIndex)
        }
        return nil
    }
}
