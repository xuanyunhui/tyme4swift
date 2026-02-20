import Foundation

/// 文化实体的抽象基类，实现 ``Culture`` 协议并提供通用工具方法。
///
/// 所有具体的历法文化类型（如 `HeavenStem`、`SolarTerm` 等）均继承自此类。
/// 子类必须覆写 ``getName()`` 方法以返回各自的名称。
///
/// ## 继承体系
/// ```
/// AbstractCulture
/// ├── AbstractTyme  （支持时间导航的文化类型）
/// └── AbstractCultureDay  （文化节气的第 N 天）
/// ```
open class AbstractCulture: Culture, CustomStringConvertible {
    public init() {}

    /// 返回该文化实体的名称。子类必须覆写此方法。
    open func getName() -> String {
        fatalError("Subclasses must override getName()")
    }

    /// 文本描述，等同于 ``getName()``，用于 `print` 和字符串插值。
    public var description: String {
        getName()
    }

    /// 将任意整数索引规范化到 `[0, size)` 范围内。
    ///
    /// 支持负数索引（向前偏移），确保结果始终非负。
    /// - Parameters:
    ///   - index: 原始索引，可以为负数。
    ///   - size: 循环长度（模数）。
    /// - Returns: 规范化后的非负索引。
    internal func indexOf(_ index: Int, _ size: Int) -> Int {
        var i = index % size
        if i < 0 { i += size }
        return i
    }
}
