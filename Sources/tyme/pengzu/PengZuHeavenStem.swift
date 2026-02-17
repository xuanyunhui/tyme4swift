import Foundation

/// 天干彭祖百忌 (Pengzu Taboos for Heaven Stems)
/// 彭祖百忌是中国传统的择日禁忌，根据天干地支来判断每日宜忌
/// Each of the 10 Heaven Stems has specific taboo activities
public final class PengZuHeavenStem: LoopTyme {
    /// Names of the 10 Heaven Stem taboos
    /// 甲-癸 对应的彭祖百忌
    public static let NAMES = [
        "甲不开仓财物耗散",  // 甲日不宜开仓库，否则财物会耗散
        "乙不栽植千株不长",  // 乙日不宜栽种植物，否则难以生长
        "丙不修灶必见灾殃",  // 丙日不宜修灶，否则会有灾祸
        "丁不剃头头必生疮",  // 丁日不宜剃头，否则头上会生疮
        "戊不受田田主不祥",  // 戊日不宜买田，否则田主不吉
        "己不破券二比并亡",  // 己日不宜破券（签订契约），否则双方都会受损
        "庚不经络织机虚张",  // 庚日不宜织布，否则织机会空转
        "辛不合酱主人不尝",  // 辛日不宜酿酱，否则主人无法品尝
        "壬不泱水更难提防",  // 壬日不宜决水（开闸放水），否则难以防范
        "癸不词讼理弱敌强"   // 癸日不宜打官司，否则理亏而对方强势
    ]

    /// Initialize with name
    /// - Parameter name: The taboo name
    public init(_ name: String) throws {
        guard let idx = PengZuHeavenStem.NAMES.firstIndex(of: name) else {
            throw TymeError.invalidName(name)
        }
        super.init(names: PengZuHeavenStem.NAMES, index: idx)
    }

    /// Initialize with index
    /// - Parameter index: Index (0-9)
    public init(_ index: Int) {
        super.init(names: PengZuHeavenStem.NAMES, index: index)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    /// Create from name
    /// - Parameter name: The taboo name
    /// - Returns: PengZuHeavenStem instance
    public static func fromName(_ name: String) throws -> PengZuHeavenStem {
        return try PengZuHeavenStem(name)
    }

    /// Create from index
    /// - Parameter index: Index (0-9)
    /// - Returns: PengZuHeavenStem instance
    public static func fromIndex(_ index: Int) -> PengZuHeavenStem {
        return PengZuHeavenStem(index)
    }

    /// Get next PengZuHeavenStem
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next PengZuHeavenStem instance
    public override func next(_ n: Int) -> PengZuHeavenStem {
        return try! PengZuHeavenStem(nextIndex(n))
    }
}
