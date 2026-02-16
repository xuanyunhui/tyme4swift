import Foundation

public final class Element: LoopTyme {
    public static let NAMES = ["木","火","土","金","水"]
    
    // YinYang mapping (阴阳)
    private static let YIN_YANG = ["阳","阴","阳","阴","阳"]

    public convenience init(index: Int) {
        self.init(names: Element.NAMES, index: index)
    }

    public convenience init(name: String) {
        self.init(names: Element.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> Element {
        Element(index: index)
    }

    public static func fromName(_ name: String) -> Element {
        Element(name: name)
    }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = Element.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> Element {
        Element.fromIndex(nextIndex(n))
    }
    
    // Properties
    public func getYinYang() -> String {
        Element.YIN_YANG[index]
    }
}
