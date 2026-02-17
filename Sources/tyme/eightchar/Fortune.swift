import Foundation

/// 小运
public final class Fortune: AbstractTyme {
    public let childLimit: ChildLimit
    public let index: Int

    public init(childLimit: ChildLimit, index: Int) {
        self.childLimit = childLimit
        self.index = index
        super.init()
    }

    public static func fromChildLimit(_ childLimit: ChildLimit, _ index: Int) -> Fortune {
        Fortune(childLimit: childLimit, index: index)
    }

    /// 年龄
    public var age: Int {
        childLimit.endSixtyCycleYear.year - childLimit.startSixtyCycleYear.year + 1 + index
    }

    /// 干支年
    public var sixtyCycleYear: SixtyCycleYear {
        childLimit.endSixtyCycleYear.next(index)
    }

    /// 干支
    public var sixtyCycle: SixtyCycle {
        let n = age
        return childLimit.eightChar.hour.next(childLimit.forward ? n : -n)
    }

    public override func getName() -> String { sixtyCycle.getName() }

    public override func next(_ n: Int) -> Self {
        Fortune.fromChildLimit(childLimit, index + n) as! Self
    }

    @available(*, deprecated, renamed: "age")
    public func getAge() -> Int { age }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "sixtyCycleYear")
    public func getSixtyCycleYear() -> SixtyCycleYear { sixtyCycleYear }
}
