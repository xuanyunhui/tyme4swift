import Foundation

/// 大运（10年1大运）
public final class DecadeFortune: AbstractTyme {
    public let childLimit: ChildLimit
    public let index: Int

    public init(childLimit: ChildLimit, index: Int) {
        self.childLimit = childLimit
        self.index = index
        super.init()
    }

    public static func fromChildLimit(_ childLimit: ChildLimit, _ index: Int) -> DecadeFortune {
        DecadeFortune(childLimit: childLimit, index: index)
    }

    /// 开始年龄
    public var startAge: Int {
        childLimit.endSixtyCycleYear.year - childLimit.startSixtyCycleYear.year + 1 + index * 10
    }

    /// 结束年龄
    public var endAge: Int { startAge + 9 }

    /// 开始干支年
    public var startSixtyCycleYear: SixtyCycleYear {
        childLimit.endSixtyCycleYear.next(index * 10)
    }

    /// 结束干支年
    public var endSixtyCycleYear: SixtyCycleYear {
        startSixtyCycleYear.next(9)
    }

    /// 干支
    public var sixtyCycle: SixtyCycle {
        childLimit.eightChar.month.next(childLimit.forward ? index + 1 : -index - 1)
    }

    public override func getName() -> String { sixtyCycle.getName() }

    public override func next(_ n: Int) -> Self {
        // swiftlint:disable:next force_cast
        DecadeFortune.fromChildLimit(childLimit, index + n) as! Self
    }

    /// 开始小运
    public var startFortune: Fortune {
        Fortune.fromChildLimit(childLimit, index * 10)
    }

    @available(*, deprecated, renamed: "startAge")
    public func getStartAge() -> Int { startAge }

    @available(*, deprecated, renamed: "endAge")
    public func getEndAge() -> Int { endAge }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "startSixtyCycleYear")
    public func getStartSixtyCycleYear() -> SixtyCycleYear { startSixtyCycleYear }

    @available(*, deprecated, renamed: "endSixtyCycleYear")
    public func getEndSixtyCycleYear() -> SixtyCycleYear { endSixtyCycleYear }

    @available(*, deprecated, renamed: "startFortune")
    public func getStartFortune() -> Fortune { startFortune }
}
