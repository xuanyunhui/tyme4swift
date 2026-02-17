import Foundation

open class LoopTyme: AbstractTyme {
    internal let names: [String]
    public let index: Int

    public required init(names: [String], index: Int) {
        self.names = names
        let c = names.count
        var i = index % c
        if i < 0 { i += c }
        self.index = i
        super.init()
    }

    public convenience init(names: [String], name: String) throws {
        guard let i = names.firstIndex(of: name) else {
            throw TymeError.invalidName(name)
        }
        self.init(names: names, index: i)
    }

    @available(*, deprecated, renamed: "index")
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

// MARK: - Equatable

extension LoopTyme: Equatable {
    public static func == (lhs: LoopTyme, rhs: LoopTyme) -> Bool {
        return type(of: lhs) == type(of: rhs) && lhs.index == rhs.index
    }
}

// MARK: - Hashable

extension LoopTyme: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type(of: self)))
        hasher.combine(index)
    }
}
