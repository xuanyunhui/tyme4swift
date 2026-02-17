import Testing
@testable import tyme

@Suite struct GodTests {
    @Test func testGodType() throws {
        // Test all four god types
        let expectedNames = ["年", "月", "日", "时"]
        for i in 0..<4 {
            let godType = GodType.fromIndex(i)
            #expect(godType.getName() == expectedNames[i])
            #expect(godType.index == i)
        }

        // Test fromName
        let nian = try GodType.fromName("年")
        #expect(nian.index == 0)

        // Test next
        let yue = nian.next(1)
        #expect(yue.getName() == "月")

        // Test wrap around
        let shi = GodType.fromIndex(3)
        let nextNian = shi.next(1)
        #expect(nextNian.getName() == "年")
    }
    @Test func testGod() throws {
        // Test God creation
        let godType = GodType.fromIndex(2) // 日
        let luck = Luck.fromIndex(0) // 吉
        let god = God(type: godType, luck: luck, name: "天德")

        #expect(god.getName() == "天德")
        #expect(god.getGodType().getName() == "日")
        #expect(god.getLuck().getName() == "吉")
        #expect(god.isAuspicious())
        #expect(!god.isInauspicious())

        // Test inauspicious god
        let badLuck = Luck.fromIndex(1) // 凶
        let badGod = God(type: godType, luck: badLuck, name: "天刑")
        #expect(!badGod.isAuspicious())
        #expect(badGod.isInauspicious())
    }
    @Test func testDayTaboo() throws {
        let dayTaboo = DayTaboo(auspicious: ["祭祀", "祈福"], inauspicious: ["动土", "破土"])
        #expect(dayTaboo.getAuspicious().count == 2)
        #expect(dayTaboo.getInauspicious().count == 2)
        #expect(dayTaboo.isAuspicious("祭祀"))
        #expect(dayTaboo.isInauspicious("动土"))
        #expect(!dayTaboo.isAuspicious("动土"))

        let taboos = dayTaboo.getTaboos()
        #expect(taboos.count == 4)
    }
    @Test func testYearGod() throws {
        // Test all year gods
        let expectedNames = ["太岁", "太阳", "丧门", "太阴", "官符", "死符", "岁破", "龙德", "白虎", "福德", "吊客", "病符"]
        for i in 0..<12 {
            let yearGod = YearGod.fromIndex(i)
            #expect(yearGod.getName() == expectedNames[i])
            #expect(yearGod.getIndex() == i)
        }

        // Test fromEarthBranch
        let earthBranch = EarthBranch.fromIndex(0)
        let gods = YearGod.fromEarthBranch(earthBranch)
        #expect(gods.count == 12)
    }
    @Test func testMonthGod() throws {
        // Test first few month gods
        let expectedNames = ["月德", "月空", "月煞", "月刑", "月害"]
        for i in 0..<5 {
            let monthGod = MonthGod.fromIndex(i)
            #expect(monthGod.getName() == expectedNames[i])
            #expect(monthGod.getIndex() == i)
        }
    }
    @Test func testDayGod() throws {
        // Test auspicious day god
        let auspicious = DayGod.auspicious("天德")
        #expect(auspicious.getName() == "天德")
        #expect(auspicious.getIsAuspicious())
        #expect(!auspicious.getIsInauspicious())
        #expect(auspicious.getLuck().getName() == "吉")

        // Test inauspicious day god
        let inauspicious = DayGod.inauspicious("月破")
        #expect(inauspicious.getName() == "月破")
        #expect(!inauspicious.getIsAuspicious())
        #expect(inauspicious.getIsInauspicious())
        #expect(inauspicious.getLuck().getName() == "凶")
    }
    @Test func testHourGod() throws {
        // Test first few hour gods
        let expectedNames = ["日禄", "喜神", "财神", "阳贵", "阴贵"]
        for i in 0..<5 {
            let hourGod = HourGod.fromIndex(i)
            #expect(hourGod.getName() == expectedNames[i])
            #expect(hourGod.getIndex() == i)
        }
    }
    @Test func testJoyGod() throws {
        // Test joy god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let joyGod = JoyGod.fromHeavenStem(heavenStem)
        #expect(joyGod.getName() == "东北")
        _ = joyGod.getDirection()

        // Test from SixtyCycle
        let sixtyCycle = SixtyCycle.fromIndex(0) // 甲子
        let joyGod2 = JoyGod.fromDaySixtyCycle(sixtyCycle)
        #expect(joyGod2.getName() == "东北")
    }
    @Test func testWealthGod() throws {
        // Test wealth god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let wealthGod = WealthGod.fromHeavenStem(heavenStem)
        #expect(wealthGod.getName() == "东南")
        _ = wealthGod.getDirection()

        // Test from SixtyCycle
        let sixtyCycle = SixtyCycle.fromIndex(0) // 甲子
        let wealthGod2 = WealthGod.fromDaySixtyCycle(sixtyCycle)
        #expect(wealthGod2.getName() == "东南")
    }
    @Test func testFortuneGod() throws {
        // Test fortune god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let fortuneGod = FortuneGod.fromHeavenStem(heavenStem)
        #expect(fortuneGod.getName() == "东南")
        _ = fortuneGod.getDirection()
    }
    @Test func testYangNobleGod() throws {
        // Test yang noble god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let yangNobleGod = YangNobleGod.fromHeavenStem(heavenStem)
        #expect(yangNobleGod.getName() == "西南")
        _ = yangNobleGod.getDirection()
    }
    @Test func testYinNobleGod() throws {
        // Test yin noble god directions
        let heavenStem = HeavenStem.fromIndex(0) // 甲
        let yinNobleGod = YinNobleGod.fromHeavenStem(heavenStem)
        #expect(yinNobleGod.getName() == "东北")
        _ = yinNobleGod.getDirection()
    }
    @Test func testGodLookup() throws {
        // Test God lookup for a known date (2024-01-01)
        let day = try SixtyCycleDay(year: 2024, month: 1, day: 1)
        let gods = day.getGods()

        // Verify gods list is not empty
        #expect(!gods.isEmpty)

        // Verify returned God objects have correct properties
        for god in gods {
            #expect(!god.getName().isEmpty)
            // Verify each god has a valid luck status (auspicious or inauspicious)
            let isValid = god.isAuspicious() || god.isInauspicious()
            #expect(isValid)
        }
    }
    @Test func testDayRecommends() throws {
        let day = try SixtyCycleDay(year: 2024, month: 1, day: 1)
        let recommends = day.getRecommends()

        // Verify all returned Taboo objects are marked as auspicious
        for taboo in recommends {
            #expect(taboo.isAuspicious())
            #expect(!taboo.isInauspicious())
            #expect(!taboo.getName().isEmpty)
        }
    }
    @Test func testDayAvoids() throws {
        let day = try SixtyCycleDay(year: 2024, month: 1, day: 1)
        let avoids = day.getAvoids()

        // Verify all returned Taboo objects are marked as inauspicious
        for taboo in avoids {
            #expect(taboo.isInauspicious())
            #expect(!taboo.isAuspicious())
            #expect(!taboo.getName().isEmpty)
        }
    }
}
