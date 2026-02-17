public enum TymeError: Error, CustomStringConvertible {
    case invalidYear(Int)
    case invalidMonth(Int)
    case invalidDay(Int)
    case invalidName(String)
    case invalidIndex(Int)
    case invalidHour(Int)
    case invalidMinute(Int)
    case invalidSecond(Int)
    case invalidDate(String)

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
