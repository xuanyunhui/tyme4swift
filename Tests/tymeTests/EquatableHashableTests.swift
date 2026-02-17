import Testing
@testable import tyme

@Suite struct EquatableHashableTests {
    @Test func testLoopTymeEquatable() {
        // Same type, same index → equal
        let e1 = Element.fromIndex(0)
        let e2 = Element.fromIndex(0)
        #expect(e1 == e2)

        // Same type, different index → not equal
        let e3 = Element.fromIndex(1)
        #expect(e1 != e3)

        // Different type, same index → not equal
        let hs = HeavenStem.fromIndex(0)
        #expect(e1 as LoopTyme != hs as LoopTyme)

        // Cycle equivalence
        let e4 = Element.fromIndex(5) // wraps to 0
        #expect(e1 == e4)
    }
    @Test func testLoopTymeHashable() {
        // Can be used in Set
        let set: Set<Element> = [Element.fromIndex(0), Element.fromIndex(0), Element.fromIndex(1)]
        #expect(set.count == 2)

        // Can be used as Dictionary key
        var dict = [HeavenStem: String]()
        dict[HeavenStem.fromIndex(0)] = "甲"
        #expect(dict[HeavenStem.fromIndex(0)] == "甲")
    }
}
