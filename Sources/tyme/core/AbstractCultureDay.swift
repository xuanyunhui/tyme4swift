import Foundation

open class AbstractCultureDay: AbstractCulture {
    public let culture: Culture
    public let dayIndex: Int

    public init(culture: Culture, dayIndex: Int) {
        self.culture = culture
        self.dayIndex = dayIndex
        super.init()
    }

    @available(*, deprecated, renamed: "dayIndex")
    public func getDayIndex() -> Int { dayIndex }

    public override func getName() -> String {
        culture.getName()
    }

    public override var description: String {
        String(format: "%@第%d天", culture.getName(), dayIndex + 1)
    }
}
