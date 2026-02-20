/// tyme4swift 的统一错误类型，涵盖所有输入验证失败场景。
///
/// 所有工厂方法（`fromYmd`、`fromIndex`、`fromName` 等）在输入非法时
/// 抛出此错误，而非使用 `fatalError` 或返回 `nil`。
///
/// ## 常见使用场景
///
/// ```swift
/// do {
///     let day = try SolarDay.fromYmd(2024, 13, 1)  // 月份非法
/// } catch TymeError.invalidMonth(let v) {
///     print("无效月份: \(v)")
/// }
/// ```
public enum TymeError: Error, CustomStringConvertible {
    /// 年份超出支持范围。
    case invalidYear(Int)
    /// 月份不在 1–12（或农历对应范围）内。
    case invalidMonth(Int)
    /// 日期超出当月天数范围。
    case invalidDay(Int)
    /// 名称在对应名称数组中不存在。
    case invalidName(String)
    /// 索引超出对应循环长度范围。
    case invalidIndex(Int)
    /// 小时不在 0–23 范围内。
    case invalidHour(Int)
    /// 分钟不在 0–59 范围内。
    case invalidMinute(Int)
    /// 秒不在 0–59 范围内。
    case invalidSecond(Int)
    /// 日期字符串格式不合法。
    case invalidDate(String)

    /// 人类可读的错误描述。
    public var description: String {
        switch self {
        case .invalidYear(let v): return "Invalid year: \(v)"
        case .invalidMonth(let v): return "Invalid month: \(v)"
        case .invalidDay(let v): return "Invalid day: \(v)"
        case .invalidName(let v): return "Invalid name: \(v)"
        case .invalidIndex(let v): return "Invalid index: \(v)"
        case .invalidHour(let v): return "Invalid hour: \(v)"
        case .invalidMinute(let v): return "Invalid minute: \(v)"
        case .invalidSecond(let v): return "Invalid second: \(v)"
        case .invalidDate(let v): return "Invalid date: \(v)"
        }
    }
}
