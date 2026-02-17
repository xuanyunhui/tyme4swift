import XCTest
@testable import tyme

final class EquatableHashableTests: XCTestCase {
    func testLoopTymeEquatable() {
        // Same type, same index → equal
        let e1 = Element.fromIndex(0)
        let e2 = Element.fromIndex(0)
        XCTAssertEqual(e1, e2)
        
        // Same type, different index → not equal
        let e3 = Element.fromIndex(1)
        XCTAssertNotEqual(e1, e3)
        
        // Different type, same index → not equal
        let hs = HeavenStem.fromIndex(0)
        XCTAssertNotEqual(e1 as LoopTyme, hs as LoopTyme)
        
        // Cycle equivalence
        let e4 = Element.fromIndex(5) // wraps to 0
        XCTAssertEqual(e1, e4)
    }
    func testLoopTymeHashable() {
        // Can be used in Set
        let set: Set<Element> = [Element.fromIndex(0), Element.fromIndex(0), Element.fromIndex(1)]
        XCTAssertEqual(set.count, 2)
        
        // Can be used as Dictionary key
        var dict = [HeavenStem: String]()
        dict[HeavenStem.fromIndex(0)] = "甲"
        XCTAssertEqual(dict[HeavenStem.fromIndex(0)], "甲")
    }
}
