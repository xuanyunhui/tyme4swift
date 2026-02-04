import Foundation

open class AbstractCultureDay: AbstractCulture {
    internal let culture: Culture
    internal let dayIndex: Int

    public init(culture: Culture, dayIndex: Int) {
        self.culture = culture
        self.dayIndex = dayIndex
        super.init()
    }

    public func getDayIndex() -> Int { dayIndex }

    public override func getName() -> String {
        culture.getName()
    }

    public override var description: String {
        String(format: "%@第%d天", culture.getName(), dayIndex + 1)
    }
}
