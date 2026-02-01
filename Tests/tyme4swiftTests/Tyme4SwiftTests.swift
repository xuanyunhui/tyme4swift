import XCTest
@testable import tyme4swift

final class Tyme4SwiftTests: XCTestCase {
    func testJulianDay() throws {
        let jd = JulianDay.fromYmdHms(year: 2000, month: 1, day: 1)
        let solar = jd.getSolarDay()
        XCTAssertEqual(solar.getYear(), 2000)
        XCTAssertEqual(solar.getMonth(), 1)
        XCTAssertEqual(solar.getDay(), 1)
    }
    
    func testSolarDay() throws {
        let solar = SolarDay(year: 2024, month: 2, day: 10)
        XCTAssertEqual(solar.getYear(), 2024)
        XCTAssertEqual(solar.getMonth(), 2)
        XCTAssertEqual(solar.getDay(), 10)
    }
    
    func testLunarYear() throws {
        let lunar = LunarYear.fromYear(2024)
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar.getYear(), 2024)
    }
    
    func testHeavenStem() throws {
        let stem = HeavenStem.fromIndex(0)
        XCTAssertEqual(stem.getName(), "甲")
        let stem2 = stem.next(1)
        XCTAssertEqual(stem2.getName(), "乙")
    }
    
    func testEarthBranch() throws {
        let branch = EarthBranch.fromIndex(0)
        XCTAssertEqual(branch.getName(), "子")
        let branch2 = branch.next(1)
        XCTAssertEqual(branch2.getName(), "丑")
    }
    
    func testSixtyCycle() throws {
        let cycle = SixtyCycle.fromIndex(0)
        XCTAssertEqual(cycle.getName(), "甲子")
        let cycle2 = cycle.next(1)
        XCTAssertEqual(cycle2.getName(), "乙丑")
    }
    
    func testSolarTerm() throws {
        let term = SolarTerm(year: 2024, index: 0)
        XCTAssertEqual(term.getName(), "冬至")
        XCTAssertEqual(term.getYear(), 2024)
    }
}
