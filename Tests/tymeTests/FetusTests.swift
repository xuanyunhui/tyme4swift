import Testing
@testable import tyme

@Suite struct FetusTests {
    @Test func testFetus() throws {
        // Test Fetus from SixtyCycle
        let sixtyCycle = SixtyCycle.fromIndex(0)
        let fetus = Fetus.fromSixtyCycle(sixtyCycle)
        _ = fetus.getPosition()
        _ = fetus.getDirection()
        _ = fetus.getName()

        // Test fromIndex
        let fetus2 = Fetus.fromIndex(30)
        #expect(fetus2.getSixtyCycleIndex() == 30)
    }
    @Test func testFetusOrigin() throws {
        // Test FetusOrigin from month pillar
        let monthPillar = SixtyCycle.fromIndex(0) // 甲子
        let fetusOrigin = FetusOrigin.fromMonthPillar(monthPillar)
        _ = fetusOrigin.getSixtyCycle()
        _ = fetusOrigin.getHeavenStem()
        _ = fetusOrigin.getEarthBranch()
    }
    @Test func testFetusDay() throws {
        #expect("厨灶炉 外正南" == (try SolarDay.fromYmd(2021, 11, 13).getLunarDay().getFetusDay().getName()))
        #expect("碓磨厕 外东南" == (try SolarDay.fromYmd(2021, 11, 12).getLunarDay().getFetusDay().getName()))
        #expect("仓库炉 外西南" == (try SolarDay.fromYmd(2011, 11, 12).getLunarDay().getFetusDay().getName()))
    }
    @Test func testFetusDayFromSixtyCycleDay() throws {
        let scd = try SixtyCycleDay.fromYmd(2021, 11, 13)
        let fd = FetusDay.fromSixtyCycleDay(scd)
        #expect("碓磨厕 外东南" == fd.getName())
    }
    @Test func testFetusMonth() throws {
        let m1 = try LunarMonth.fromYm(2021, 11)
        #expect(m1.getFetus()!.getName() == "占灶炉")
        let m2 = try LunarMonth.fromYm(2021, 1)
        #expect(m2.getFetus()!.getName() == "占房床")
    }
    @Test func testFetusHeavenStem() throws {
        #expect(FetusHeavenStem(index: 0).getName() == "门")
        #expect(FetusHeavenStem(index: 1).getName() == "碓磨")
        #expect(FetusHeavenStem(index: 2).getName() == "厨灶")
        #expect(FetusHeavenStem(index: 3).getName() == "仓库")
        #expect(FetusHeavenStem(index: 4).getName() == "房床")
    }
    @Test func testFetusEarthBranch() throws {
        #expect(FetusEarthBranch(index: 0).getName() == "碓")
        #expect(FetusEarthBranch(index: 1).getName() == "厕")
        #expect(FetusEarthBranch(index: 2).getName() == "炉")
        #expect(FetusEarthBranch(index: 3).getName() == "门")
        #expect(FetusEarthBranch(index: 4).getName() == "栖")
        #expect(FetusEarthBranch(index: 5).getName() == "床")
    }
}
