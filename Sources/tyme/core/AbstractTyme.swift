import Foundation

open class AbstractTyme: AbstractCulture, Tyme {
    public override init() { super.init() }

    open func next(_ n: Int) -> Self {
        fatalError("Subclasses must override next(_)")
    }
}
