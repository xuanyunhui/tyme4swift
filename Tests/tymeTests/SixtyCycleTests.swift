import Testing
@testable import tyme

@Suite struct SixtyCycleTests {
    @Test func testHeavenStem() throws {
        let stem = HeavenStem.fromIndex(0)
        #expect(stem.getName() == "甲")
        let stem2 = stem.next(1)
        #expect(stem2.getName() == "乙")
    }
    @Test func testEarthBranch() throws {
        let branch = EarthBranch.fromIndex(0)
        #expect(branch.getName() == "子")
        let branch2 = branch.next(1)
        #expect(branch2.getName() == "丑")
    }
    @Test func testSixtyCycle() throws {
        let cycle = SixtyCycle.fromIndex(0)
        #expect(cycle.getName() == "甲子")
        let cycle2 = cycle.next(1)
        #expect(cycle2.getName() == "乙丑")
    }
    @Test func testHideHeavenStemType() throws {
        // Test Main
        let main = HideHeavenStemType.main
        #expect(main.name == "本气")
        #expect(main.rawValue == 0)
        #expect(main.isMain)
        #expect(!main.isMiddle)
        #expect(!main.isResidual)

        // Test Middle
        let middle = HideHeavenStemType.middle
        #expect(middle.name == "中气")
        #expect(middle.rawValue == 1)
        #expect(!middle.isMain)
        #expect(middle.isMiddle)
        #expect(!middle.isResidual)

        // Test Residual
        let residual = HideHeavenStemType.residual
        #expect(residual.name == "余气")
        #expect(residual.rawValue == 2)
        #expect(!residual.isMain)
        #expect(!residual.isMiddle)
        #expect(residual.isResidual)

        // Test fromIndex
        #expect(HideHeavenStemType.fromIndex(0) == .main)
        #expect(HideHeavenStemType.fromIndex(1) == .middle)
        #expect(HideHeavenStemType.fromIndex(2) == .residual)
        #expect(HideHeavenStemType.fromIndex(3) == .main)

        // Test fromName
        #expect(HideHeavenStemType.fromName("本气") == .main)
        #expect(HideHeavenStemType.fromName("中气") == .middle)
        #expect(HideHeavenStemType.fromName("余气") == .residual)

        // Test description
        #expect(String(describing: main) == "本气")
    }
    @Test func testHideHeavenStem() throws {
        // Test 子 branch hidden stems (癸)
        let zi = EarthBranch.fromIndex(0)
        let ziHideStems = zi.getHideHeavenStems()
        #expect(ziHideStems.count == 1)
        #expect(ziHideStems[0].getName() == "癸")
        #expect(ziHideStems[0].isMain())

        // Test 丑 branch hidden stems (己癸辛)
        let chou = EarthBranch.fromIndex(1)
        let chouHideStems = chou.getHideHeavenStems()
        #expect(chouHideStems.count == 3)
        #expect(chouHideStems[0].getName() == "己")
        #expect(chouHideStems[1].getName() == "癸")
        #expect(chouHideStems[2].getName() == "辛")

        // Test 寅 branch hidden stems (甲丙戊)
        let yin = EarthBranch.fromIndex(2)
        let yinHideStems = yin.getHideHeavenStems()
        #expect(yinHideStems.count == 3)
        #expect(yinHideStems[0].getName() == "甲")
        #expect(yinHideStems[0].isMain())
        #expect(yinHideStems[1].getName() == "丙")
        #expect(yinHideStems[1].isMiddle())
        #expect(yinHideStems[2].getName() == "戊")
        #expect(yinHideStems[2].isResidual())

        // Test getMainHideHeavenStem
        let mainStem = zi.getMainHideHeavenStem()
        #expect(mainStem != nil)
        #expect(mainStem?.getName() == "癸")
    }
    @Test func testSixtyCycleYear() throws {
        // Test year 2024 (甲辰年)
        let year2024 = SixtyCycleYear.fromYear(2024)
        #expect(year2024.getYear() == 2024)
        #expect(year2024.getName() == "甲辰")
        #expect(year2024.getHeavenStem().getName() == "甲")
        #expect(year2024.getEarthBranch().getName() == "辰")
        #expect(year2024.getZodiac().getName() == "龙")

        // Test year 2023 (癸卯年)
        let year2023 = SixtyCycleYear.fromYear(2023)
        #expect(year2023.getName() == "癸卯")
        #expect(year2023.getZodiac().getName() == "兔")

        // Test next
        let year2025 = year2024.next(1)
        #expect(year2025.getYear() == 2025)
        #expect(year2025.getName() == "乙巳")

        // Test NaYin
        _ = year2024.getNaYin()
    }
    @Test func testSixtyCycleMonth() throws {
        // Test 2024年1月
        let month = SixtyCycleMonth.fromYm(2024, 1)
        #expect(month.getYear() == 2024)
        #expect(month.getMonth() == 1)
        _ = month.getHeavenStem()
        _ = month.getEarthBranch()
        _ = month.getSixtyCycle()
        _ = month.getNaYin()

        // Test next
        let nextMonth = month.next(1)
        #expect(nextMonth.getMonth() == 2)

        // Test wrap around
        let decMonth = SixtyCycleMonth.fromYm(2024, 12)
        let janMonth = decMonth.next(1)
        #expect(janMonth.getYear() == 2025)
        #expect(janMonth.getMonth() == 1)
    }
    @Test func testSixtyCycleDay() throws {
        // Test a specific date
        let day = try SixtyCycleDay.fromYmd(2024, 2, 10)
        _ = day.getSixtyCycle()
        _ = day.getHeavenStem()
        _ = day.getEarthBranch()
        _ = day.getNaYin()
        _ = day.getDuty()
        _ = day.getTwentyEightStar()

        // Test next
        _ = day.next(1)

        // Test fromSolarDay
        let solarDay = try SolarDay.fromYmd(2024, 2, 10)
        let day2 = SixtyCycleDay.fromSolarDay(solarDay)
        #expect(day.getName() == day2.getName())
    }
    @Test func testSixtyCycleHour() throws {
        // Test a specific time
        let hour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        _ = hour.getSixtyCycle()
        _ = hour.getHeavenStem()
        _ = hour.getEarthBranch()
        _ = hour.getNaYin()

        // Test getIndexInDay
        let hourIndex = hour.getIndexInDay()
        #expect(hourIndex == 6) // 12:00 is 午时 (index 6)

        // Test 子时 (23:00-01:00)
        let ziHour = try SixtyCycleHour.fromYmdHms(2024, 2, 10, 0, 0, 0)
        #expect(ziHour.getIndexInDay() == 0)

        // Test next
        _ = hour.next(1)
    }
    @Test func testHideHeavenStemDay() {
        let eb = EarthBranch.fromIndex(0) // 子
        let stems = eb.getHideHeavenStems()
        let day = HideHeavenStemDay(hideHeavenStem: stems[0], dayIndex: 0)
        #expect(day.getHideHeavenStem().getName() == "癸")
        #expect(day.getName() == "癸水")  // 癸的五行是水
        #expect(day.getDayIndex() == 0)
        #expect(day.description == "癸水第1天")
    }
}
