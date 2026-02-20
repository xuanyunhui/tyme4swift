import Foundation

/// 文化实体协议，所有具有名称的历法文化对象均遵循此协议。
///
/// `Culture` 是整个 tyme4swift 类型体系的根协议，提供统一的名称访问接口。
/// 所有历法元素（干支、节气、神煞等）均通过此协议暴露其文本表示。
public protocol Culture {
    /// 返回该文化实体的名称。
    func getName() -> String
}

public extension Culture {
    /// 文化实体的名称，等同于 `getName()` 的计算属性形式。
    var name: String { getName() }
}
