import XCTest
@testable import tyme

final class GodTests: XCTestCase {
    func testGodType() throws {
        // Test all four god types
        let expectedNames = ["年", "月", "日", "时"]
        for i in 0..<4 {
            let godType = GodType.fromIndex(i)
            XCTAssertEqual(godType.getName(), expectedNames[i])
            XCTAssertEqual(godType.getIndex(), i)
        }

        // Test fromName
        let nian = try GodType.fromName("年")
        XCTAssertEqual(nian.getIndex(), 0)

        // Test next
        let yue = nian.next(1)
        XCTAssertEqual(yue.getName(), "月")

        // Test wrap around
        let shi = GodType.fromIndex(3)
        let nextNian = shi.next(1)
        XCTAssertEqual(nextNian.getName(), "年")
    }
    func testGod() throws {
        // Test God creation
        let godType = GodType.fromIndex(2) // 日
        let luck = Luck.fromIndex(0) // 吉
        let god = God(type: godType, luck: luck, name: "天德")

        XCTAssertEqual(god.getName(), "天德")
        XCTAssertEqual(god.getGodType().getName(), "日")
        XCTAssertEqual(god.getLuck().getName(), "吉")
        XCTAssertTrue(god.isAuspicious())
        XCTAssertFalse(god.isInauspicious())

        // Test inauspicious god
        let badLuck = Luck.fromIndex(1) // 凶
        let badGod = God(type: godType, luck: badLuck, name: "天刑")
        XCTAssertFalse(badGod.isAuspicious())
        XCTAssertTrue(badGod.isInauspicious())
    }
    func testDayTaboo() throws {
        let dayTaboo = DayTaboo(auspicious: ["祭祀", "祈福"], inauspicious: ["动土", "破土"])
        XCTAssertEqual(dayTaboo.getAuspicious().count, 2)
        XCTAssertEqual(dayTaboo.getInauspicious().count, 2)
        XCTAssertTrue(dayTaboo.isAuspicious("祭祀"))
        XCTAssertTrue(dayTaboo.isInauspicious("动土"))
        XCTAssertFalse(dayTaboo.isAuspicious("动土"))

        let taboos = dayTaboo.getTaboos()
        XCTAssertEqual(taboos.count, 4)
    }
    func testYearGod() throws {
        // Test all year gods
        let expectedNames = ["太岁", "太阳", "丧门", "太阴", "官符", "死符", "岁破", "龙德", "白虎", "福德", "吊客", "病符"]
        for i in 0..<12 {
            let yearGod = YearGod.fromIndex(i)
            XCTAssertEqual(yearGod.getName(), expectedNames[i])
            XCTAssertEqual(yearGod.getIndex(), i)
        }

        // Test fromEarthBranch
        let earthBranch = EarthBranch.fromIndex(0)
        let gods = YearGod.fromEarthBranch(earthBranch)
        XCTAssertEqual(gods.count, 12)
    }
    func testMonthGod() throws {
        // Test first few month gods
        let expectedNames = ["月德", "月空", "月煞", "月刑", "月害"]
        for i in 0..<5 {
            let monthGod = MonthGod.fromIndex(i)
            XCTAssertEqual(monthGod.getName(), expectedNames[i])
            XCTAssertEqual(monthGod.getIndex(), i)
        }
    }
    func testDayGod() throws {
        // Test auspicious day god
        let auspicious = DayGod.auspicious("天德")
        XCTAssertEqual(auspicious.getName(), "天德")
        XCTAssertTrue(auspicious.getIsAuspicious())
        XCTAssertFalse(auspicious.getIsInauspicious())
        XCTAssertEqual(auspicious.getLuck().getName(), "吉")

        // Test inauspicious day god
        let inauspicious = DayGod.inauspicious("月破")
        XCTAssertEqual(inauspicious.getName(), "月破")
        XCTAssertFalse(inauspicious.getIsAuspicious())
        XCTAssertTrue(inauspicious.getIsInauspicious())
        XCTAssertEqual(inauspicious.getLuck().getName(), "凶")
    }
    func testHourGod() throws {
        // Test first few hour gods
        let expectedNames = ["日禄", "喜神", "财神", "阳贵", "阴贵"]
        for i in 0..<5 {
            let hourGod = HourGod.fromIndex(i)
            XCTAssertEqual(hourGod.getName(), expectedNames[i])
            XCTAssertEqual(hourGod.getIndex(), i)
        }
    }
    func testJoyGod() throws {
        // Test joy god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let joyGod = JoyGod.fromHeavenStem(heavenStem)
        XCTAssertEqual(joyGod.getName(), "东北")
        XCTAssertNotNil(joyGod.getDirection())

        // Test from SixtyCycle
        let sixtyCycle = SixtyCycle.fromIndex(0) // 甲子
        let joyGod2 = JoyGod.fromDaySixtyCycle(sixtyCycle)
        XCTAssertEqual(joyGod2.getName(), "东北")
    }
    func testWealthGod() throws {
        // Test wealth god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let wealthGod = WealthGod.fromHeavenStem(heavenStem)
        XCTAssertEqual(wealthGod.getName(), "东南")
        XCTAssertNotNil(wealthGod.getDirection())

        // Test from SixtyCycle
        let sixtyCycle = SixtyCycle.fromIndex(0) // 甲子
        let wealthGod2 = WealthGod.fromDaySixtyCycle(sixtyCycle)
        XCTAssertEqual(wealthGod2.getName(), "东南")
    }
    func testFortuneGod() throws {
        // Test fortune god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let fortuneGod = FortuneGod.fromHeavenStem(heavenStem)
        XCTAssertEqual(fortuneGod.getName(), "东南")
        XCTAssertNotNil(fortuneGod.getDirection())
    }
    func testYangNobleGod() throws {
        // Test yang noble god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let yangNobleGod = YangNobleGod.fromHeavenStem(heavenStem)
        XCTAssertEqual(yangNobleGod.getName(), "西南")
        XCTAssertNotNil(yangNobleGod.getDirection())
    }
    func testYinNobleGod() throws {
        // Test yin noble god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let yinNobleGod = YinNobleGod.fromHeavenStem(heavenStem)
        XCTAssertEqual(yinNobleGod.getName(), "东北")
        XCTAssertNotNil(yinNobleGod.getDirection())
    }
    func testGodLookup() throws {
        // Test God lookup for a known date (2024-01-01)
        let day = try SixtyCycleDay(year: 2024, month: 1, day: 1)
        let gods = day.getGods()

        // Verify gods list is not empty
        XCTAssertFalse(gods.isEmpty, "Gods list should not be empty")

        // Verify returned God objects have correct properties
        for god in gods {
            XCTAssertFalse(god.getName().isEmpty, "God name should not be empty")
            // Verify each god has a valid luck status (auspicious or inauspicious)
            let isValid = god.isAuspicious() || god.isInauspicious()
            XCTAssertTrue(isValid, "God should be either auspicious or inauspicious")
        }
    }
    func testDayRecommends() throws {
        let day = try SixtyCycleDay(year: 2024, month: 1, day: 1)
        let recommends = day.getRecommends()

        // Verify all returned Taboo objects are marked as auspicious
        for taboo in recommends {
            XCTAssertTrue(taboo.isAuspicious(), "All recommends should be auspicious")
            XCTAssertFalse(taboo.isInauspicious(), "Recommends should not be inauspicious")
            XCTAssertFalse(taboo.getName().isEmpty, "Taboo name should not be empty")
        }
    }
    func testDayAvoids() throws {
        let day = try SixtyCycleDay(year: 2024, month: 1, day: 1)
        let avoids = day.getAvoids()

        // Verify all returned Taboo objects are marked as inauspicious
        for taboo in avoids {
            XCTAssertTrue(taboo.isInauspicious(), "All avoids should be inauspicious")
            XCTAssertFalse(taboo.isAuspicious(), "Avoids should not be auspicious")
            XCTAssertFalse(taboo.getName().isEmpty, "Taboo name should not be empty")
        }
    }
}
