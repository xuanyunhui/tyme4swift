import Foundation

open class LoopTyme: AbstractTyme {
    internal let names: [String]
    internal let index: Int

    public required init(names: [String], index: Int) {
        self.names = names
        let c = names.count
        var i = index % c
        if i < 0 { i += c }
        self.index = i
        super.init()
    }

    public convenience init(names: [String], name: String) {
        guard let i = names.firstIndex(of: name) else {
            fatalError("Invalid name: \(name)")
        }
        self.init(names: names, index: i)
    }

    public func getIndex() -> Int { index }

    public func nextIndex(_ n: Int) -> Int {
        let c = names.count
        var i = (index + n) % c
        if i < 0 { i += c }
        return i
    }

    public override func getName() -> String {
        names[index]
    }

    public override func next(_ n: Int) -> Self {
        Self.init(names: names, index: index + n)
    }
}
