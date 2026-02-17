import XCTest
@testable import tyme

final class FetusTests: XCTestCase {
    func testFetus() throws {
        // Test Fetus from SixtyCycle
        let sixtyCycle = SixtyCycle.fromIndex(0)
        let fetus = Fetus.fromSixtyCycle(sixtyCycle)
        XCTAssertNotNil(fetus.getPosition())
        XCTAssertNotNil(fetus.getDirection())
        XCTAssertNotNil(fetus.getName())

        // Test fromIndex
        let fetus2 = Fetus.fromIndex(30)
        XCTAssertEqual(fetus2.getSixtyCycleIndex(), 30)
    }
    func testFetusOrigin() throws {
        // Test FetusOrigin from month pillar
        let monthPillar = SixtyCycle.fromIndex(0) // 甲子
        let fetusOrigin = FetusOrigin.fromMonthPillar(monthPillar)
        XCTAssertNotNil(fetusOrigin.getSixtyCycle())
        XCTAssertNotNil(fetusOrigin.getHeavenStem())
        XCTAssertNotNil(fetusOrigin.getEarthBranch())
    }
    func testFetusDay() throws {
        XCTAssertEqual("厨灶炉 外正南", try SolarDay.fromYmd(2021, 11, 13).getLunarDay().getFetusDay().getName())
        XCTAssertEqual("碓磨厕 外东南", try SolarDay.fromYmd(2021, 11, 12).getLunarDay().getFetusDay().getName())
        XCTAssertEqual("仓库炉 外西南", try SolarDay.fromYmd(2011, 11, 12).getLunarDay().getFetusDay().getName())
    }
    func testFetusDayFromSixtyCycleDay() throws {
        let scd = try SixtyCycleDay.fromYmd(2021, 11, 13)
        let fd = FetusDay.fromSixtyCycleDay(scd)
        XCTAssertEqual("碓磨厕 外东南", fd.getName())
    }
    func testFetusMonth() throws {
        let m1 = try LunarMonth.fromYm(2021, 11)
        XCTAssertEqual("占灶炉", m1.getFetus()!.getName())
        let m2 = try LunarMonth.fromYm(2021, 1)
        XCTAssertEqual("占房床", m2.getFetus()!.getName())
    }
    func testFetusHeavenStem() throws {
        XCTAssertEqual("门", FetusHeavenStem(index: 0).getName())
        XCTAssertEqual("碓磨", FetusHeavenStem(index: 1).getName())
        XCTAssertEqual("厨灶", FetusHeavenStem(index: 2).getName())
        XCTAssertEqual("仓库", FetusHeavenStem(index: 3).getName())
        XCTAssertEqual("房床", FetusHeavenStem(index: 4).getName())
    }
    func testFetusEarthBranch() throws {
        XCTAssertEqual("碓", FetusEarthBranch(index: 0).getName())
        XCTAssertEqual("厕", FetusEarthBranch(index: 1).getName())
        XCTAssertEqual("炉", FetusEarthBranch(index: 2).getName())
        XCTAssertEqual("门", FetusEarthBranch(index: 3).getName())
        XCTAssertEqual("栖", FetusEarthBranch(index: 4).getName())
        XCTAssertEqual("床", FetusEarthBranch(index: 5).getName())
    }
}
