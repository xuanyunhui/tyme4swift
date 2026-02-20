import Foundation

/// 循环时间类型的抽象基类，用于表示固定名称数组上的循环枚举。
///
/// `LoopTyme` 是 tyme4swift 中使用最广泛的模式（约 30 个具体类），
/// 所有在固定集合上循环的历法元素均继承自此类，例如：
/// - `HeavenStem`（天干，10 个元素）
/// - `EarthBranch`（地支，12 个元素）
/// - `SixtyCycle`（六十干支，60 个元素）
/// - `Zodiac`（生肖，12 个元素）
/// - `Element`（五行，5 个元素）
///
/// ## 使用模式
///
/// 子类需提供静态 `NAMES` 数组，并通过工厂方法创建实例：
///
/// ```swift
/// let stem = HeavenStem.fromIndex(0)   // 甲
/// let next = stem.next(1)              // 乙
/// let cycle = SixtyCycle.fromName("甲子")
/// ```
///
/// ## Equatable / Hashable
///
/// 相等性基于**运行时类型 + 索引**，不同子类的相同索引不相等：
///
/// ```swift
/// HeavenStem.fromIndex(0) == EarthBranch.fromIndex(0)  // false
/// ```
open class LoopTyme: AbstractTyme {
    /// 名称数组，定义该循环类型的所有合法元素。
    internal let names: [String]

    /// 当前元素在名称数组中的索引（已规范化到 `[0, size)` 范围）。
    public let index: Int

    /// 通过名称数组和整数索引构造实例。
    ///
    /// 索引会自动对数组长度取模并处理负数，确保始终在合法范围内。
    ///
    /// - Parameters:
    ///   - names: 名称数组。
    ///   - index: 原始索引，可以为负数或超出范围的值。
    public required init(names: [String], index: Int) {
        self.names = names
        let c = names.count
        var i = index % c
        if i < 0 { i += c }
        self.index = i
        super.init()
    }

    /// 通过名称数组和名称字符串构造实例。
    ///
    /// - Parameters:
    ///   - names: 名称数组。
    ///   - name: 目标名称，必须存在于 `names` 中。
    /// - Throws: ``TymeError/invalidName(_:)`` 如果名称不在数组中。
    public convenience init(names: [String], name: String) throws {
        guard let i = names.firstIndex(of: name) else {
            throw TymeError.invalidName(name)
        }
        self.init(names: names, index: i)
    }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    /// 循环的元素总数（名称数组长度）。
    public var size: Int { names.count }

    /// 计算从当前索引到目标索引的最短正向步数。
    ///
    /// - Parameter targetIndex: 目标索引。
    /// - Returns: 从当前位置顺序到达目标所需的步数，范围 `[0, size)`。
    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = names.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    /// 计算偏移 `n` 步后的规范化索引。
    ///
    /// - Parameter n: 偏移量，正数向后，负数向前。
    /// - Returns: 规范化后的目标索引，范围 `[0, size)`。
    public func nextIndex(_ n: Int) -> Int {
        let c = names.count
        var i = (index + n) % c
        if i < 0 { i += c }
        return i
    }

    /// 返回当前索引对应的名称。
    public override func getName() -> String {
        names[index]
    }

    /// 返回偏移 `n` 步后的同类型实例。
    ///
    /// - Parameter n: 偏移量，正数向后，负数向前。
    /// - Returns: 新的同类型实例。
    public override func next(_ n: Int) -> Self {
        Self.init(names: names, index: index + n)
    }
}

// MARK: - Equatable

extension LoopTyme: Equatable {
    /// 两个 `LoopTyme` 实例相等，当且仅当运行时类型相同且索引相同。
    public static func == (lhs: LoopTyme, rhs: LoopTyme) -> Bool {
        return type(of: lhs) == type(of: rhs) && lhs.index == rhs.index
    }
}

// MARK: - Hashable

extension LoopTyme: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(index)
    }
}
