import XCTest
@testable import tyme

final class SixtyCycleTests: XCTestCase {
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
    func testHideHeavenStemType() throws {
        // Test Main
        let main = HideHeavenStemType.main
        XCTAssertEqual(main.name, "本气")
        XCTAssertEqual(main.rawValue, 0)
        XCTAssertTrue(main.isMain)
        XCTAssertFalse(main.isMiddle)
        XCTAssertFalse(main.isResidual)

        // Test Middle
        let middle = HideHeavenStemType.middle
        XCTAssertEqual(middle.name, "中气")
        XCTAssertEqual(middle.rawValue, 1)
        XCTAssertFalse(middle.isMain)
        XCTAssertTrue(middle.isMiddle)
        XCTAssertFalse(middle.isResidual)

        // Test Residual
        let residual = HideHeavenStemType.residual
        XCTAssertEqual(residual.name, "余气")
        XCTAssertEqual(residual.rawValue, 2)
        XCTAssertFalse(residual.isMain)
        XCTAssertFalse(residual.isMiddle)
        XCTAssertTrue(residual.isResidual)

        // Test fromIndex
        XCTAssertEqual(HideHeavenStemType.fromIndex(0), .main)
        XCTAssertEqual(HideHeavenStemType.fromIndex(1), .middle)
        XCTAssertEqual(HideHeavenStemType.fromIndex(2), .residual)
        XCTAssertEqual(HideHeavenStemType.fromIndex(3), .main)

        // Test fromName
        XCTAssertEqual(HideHeavenStemType.fromName("本气"), .main)
        XCTAssertEqual(HideHeavenStemType.fromName("中气"), .middle)
        XCTAssertEqual(HideHeavenStemType.fromName("余气"), .residual)

        // Test description
        XCTAssertEqual(String(describing: main), "本气")
    }
    func testHideHeavenStem() throws {
        // Test 子 branch hidden stems (癸)
        let zi = EarthBranch.fromIndex(0)
        let ziHideStems = zi.getHideHeavenStems()
        XCTAssertEqual(ziHideStems.count, 1)
        XCTAssertEqual(ziHideStems[0].getName(), "癸")
        XCTAssertTrue(ziHideStems[0].isMain())

        // Test 丑 branch hidden stems (己癸辛)
        let chou = EarthBranch.fromIndex(1)
        let chouHideStems = chou.getHideHeavenStems()
        XCTAssertEqual(chouHideStems.count, 3)
        XCTAssertEqual(chouHideStems[0].getName(), "己")
        XCTAssertEqual(chouHideStems[1].getName(), "癸")
        XCTAssertEqual(chouHideStems[2].getName(), "辛")

        // Test 寅 branch hidden stems (甲丙戊)
        let yin = EarthBranch.fromIndex(2)
        let yinHideStems = yin.getHideHeavenStems()
        XCTAssertEqual(yinHideStems.count, 3)
        XCTAssertEqual(yinHideStems[0].getName(), "甲")
        XCTAssertTrue(yinHideStems[0].isMain())
        XCTAssertEqual(yinHideStems[1].getName(), "丙")
        XCTAssertTrue(yinHideStems[1].isMiddle())
        XCTAssertEqual(yinHideStems[2].getName(), "戊")
        XCTAssertTrue(yinHideStems[2].isResidual())

        // Test getMainHideHeavenStem
        let mainStem = zi.getMainHideHeavenStem()
        XCTAssertNotNil(mainStem)
        XCTAssertEqual(mainStem?.getName(), "癸")
    }
    func testSixtyCycleYear() throws {
        // Test year 2024 (甲辰年)
        let year2024 = SixtyCycleYear.fromYear(2024)
        XCTAssertEqual(year2024.getYear(), 2024)
        XCTAssertEqual(year2024.getName(), "甲辰")
        XCTAssertEqual(year2024.getHeavenStem().getName(), "甲")
        XCTAssertEqual(year2024.getEarthBranch().getName(), "辰")
        XCTAssertEqual(year2024.getZodiac().getName(), "龙")

        // Test year 2023 (癸卯年)
        let year2023 = SixtyCycleYear.fromYear(2023)
        XCTAssertEqual(year2023.getName(), "癸卯")
        XCTAssertEqual(year2023.getZodiac().getName(), "兔")

        // Test next
        let year2025 = year2024.next(1)
        XCTAssertEqual(year2025.getYear(), 2025)
        XCTAssertEqual(year2025.getName(), "乙巳")

        // Test NaYin
        let naYin = year2024.getNaYin()
        XCTAssertNotNil(naYin)
    }
    func testSixtyCycleMonth() throws {
        // Test 2024年1月
        let month = SixtyCycleMonth.fromYm(2024, 1)
        XCTAssertEqual(month.getYear(), 2024)
        XCTAssertEqual(month.getMonth(), 1)
        XCTAssertNotNil(month.getHeavenStem())
        XCTAssertNotNil(month.getEarthBranch())
        XCTAssertNotNil(month.getSixtyCycle())
        XCTAssertNotNil(month.getNaYin())

        // Test next
        let nextMonth = month.next(1)
        XCTAssertEqual(nextMonth.getMonth(), 2)

        // Test wrap around
        let decMonth = SixtyCycleMonth.fromYm(2024, 12)
        let janMonth = decMonth.next(1)
        XCTAssertEqual(janMonth.getYear(), 2025)
        XCTAssertEqual(janMonth.getMonth(), 1)
    }
    func testSixtyCycleDay() throws {
        // Test a specific date
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        XCTAssertNotNil(day.getSixtyCycle())
        XCTAssertNotNil(day.getHeavenStem())
        XCTAssertNotNil(day.getEarthBranch())
        XCTAssertNotNil(day.getNaYin())
        XCTAssertNotNil(day.getDuty())
        XCTAssertNotNil(day.getTwentyEightStar())

        // Test next
        let nextDay = day.next(1)
        XCTAssertNotNil(nextDay)

        // Test fromSolarDay
        let solarDay = try SolarDay.fromYmd(2024, 2, 10)
        let day2 = SixtyCycleDay.fromSolarDay(solarDay)
        XCTAssertEqual(day.getName(), day2.getName())
    }
    func testSixtyCycleHour() throws {
        // Test a specific time
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        XCTAssertNotNil(hour.getSixtyCycle())
        XCTAssertNotNil(hour.getHeavenStem())
        XCTAssertNotNil(hour.getEarthBranch())
        XCTAssertNotNil(hour.getNaYin())

        // Test getIndexInDay
        let hourIndex = hour.getIndexInDay()
        XCTAssertEqual(hourIndex, 6) // 12:00 is 午时 (index 6)

        // Test 子时 (23:00-01:00)
        let ziHour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 0, 0, 0)
        XCTAssertEqual(ziHour.getIndexInDay(), 0)

        // Test next
        let nextHour = hour.next(1)
        XCTAssertNotNil(nextHour)
    }
    func testHideHeavenStemDay() {
        let eb = EarthBranch.fromIndex(0) // 子
        let stems = eb.getHideHeavenStems()
        let day = HideHeavenStemDay(hideHeavenStem: stems[0], dayIndex: 0)
        XCTAssertEqual(day.getHideHeavenStem().getName(), "癸")
        XCTAssertEqual(day.getName(), "癸水")  // 癸的五行是水
        XCTAssertEqual(day.getDayIndex(), 0)
        XCTAssertEqual(day.description, "癸水第1天")
    }
}
