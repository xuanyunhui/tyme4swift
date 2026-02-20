import Foundation

/// 支持时间导航的文化实体抽象基类，同时实现 ``Culture`` 和 ``Tyme`` 协议。
///
/// 继承自 ``AbstractCulture``，并要求子类实现 ``next(_:)`` 方法以支持
/// 在时间序列上的前进/后退导航。
///
/// ## 子类示例
/// - `SolarDay`：公历日，`next(1)` 返回次日
/// - `LunarMonth`：农历月，`next(-1)` 返回上一个农历月
/// - `SolarTerm`：节气，`next(2)` 返回后两个节气
open class AbstractTyme: AbstractCulture, Tyme {
    public override init() { super.init() }

    /// 返回从当前实体偏移 `n` 步后的实体。子类必须覆写此方法。
    ///
    /// - Parameter n: 偏移量，正数向后，负数向前。
    /// - Returns: 偏移后的同类型实体。
    open func next(_ n: Int) -> Self {
        fatalError("Subclasses must override next(_)")
    }
}
