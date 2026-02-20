import Foundation

/// 时间实体协议，在 ``Culture`` 基础上增加时间导航能力。
///
/// 遵循此协议的类型可以通过 ``next(_:)`` 方法在时间序列上前进或后退，
/// 例如从某一天导航到前后 N 天、从某月导航到前后 N 月等。
public protocol Tyme: Culture {
    /// 返回从当前实体偏移 `n` 步后的实体。
    ///
    /// - Parameter n: 偏移量，正数向后，负数向前。
    /// - Returns: 偏移后的同类型实体。
    func next(_ n: Int) -> Self
}
