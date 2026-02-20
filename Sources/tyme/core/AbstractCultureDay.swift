import Foundation

/// 文化节气"第 N 天"的抽象基类，将一个文化对象与天数偏移组合表示。
///
/// 用于表示"某文化节气期间的第 N 天"这类概念，例如：
/// - `DogDay`（三伏）：`culture` 为伏期类型，`dayIndex` 为第几天（0-based）
/// - `NineColdDay`（数九）：`culture` 为九的编号，`dayIndex` 为第几天
/// - `PlumRainDay`（梅雨）：`culture` 为梅雨期类型，`dayIndex` 为第几天
///
/// `description` 默认格式为 `"<文化名称>第<N>天"`，子类可覆写。
open class AbstractCultureDay: AbstractCulture {
    /// 所属的文化节气对象（如具体的伏期、九数等）。
    public let culture: Culture

    /// 在该文化节气中的天数偏移（0-based）。
    public let dayIndex: Int

    /// 通过文化对象和天数偏移构造实例。
    ///
    /// - Parameters:
    ///   - culture: 所属的文化节气对象。
    ///   - dayIndex: 天数偏移，0 表示第一天。
    public init(culture: Culture, dayIndex: Int) {
        self.culture = culture
        self.dayIndex = dayIndex
        super.init()
    }

    @available(*, deprecated, renamed: "dayIndex")
    public func getDayIndex() -> Int { dayIndex }

    /// 返回文化节气的名称（不含天数信息）。
    public override func getName() -> String {
        culture.getName()
    }

    /// 文本描述，格式为 `"<文化名称>第<N>天"`（`dayIndex` 从 0 开始，输出时 +1）。
    public override var description: String {
        String(format: "%@第%d天", culture.getName(), dayIndex + 1)
    }
}
