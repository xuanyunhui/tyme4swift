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
    
    func testZodiac() throws {
        // Test fromIndex
        let rat = Zodiac.fromIndex(0)
        XCTAssertEqual(rat.getName(), "鼠")
        XCTAssertEqual(rat.getIndex(), 0)
        
        // Test fromName
        let ox = Zodiac.fromName("牛")
        XCTAssertEqual(ox.getName(), "牛")
        XCTAssertEqual(ox.getIndex(), 1)
        
        // Test next
        let tiger = rat.next(2)
        XCTAssertEqual(tiger.getName(), "虎")
        XCTAssertEqual(tiger.getIndex(), 2)
        
        // Test wrap around
        let pig = Zodiac.fromIndex(11)
        XCTAssertEqual(pig.getName(), "猪")
        let nextRat = pig.next(1)
        XCTAssertEqual(nextRat.getName(), "鼠")
        XCTAssertEqual(nextRat.getIndex(), 0)
        
        // Test getEarthBranch
        let ratBranch = rat.getEarthBranch()
        XCTAssertEqual(ratBranch.getName(), "子")
    }

    // MARK: - PengZu Tests

    func testPengZuHeavenStem() throws {
        // Test fromIndex
        let jia = PengZuHeavenStem.fromIndex(0)
        XCTAssertEqual(jia.getName(), "甲不开仓财物耗散")
        XCTAssertEqual(jia.getIndex(), 0)

        // Test fromName
        let yi = PengZuHeavenStem.fromName("乙不栽植千株不长")
        XCTAssertEqual(yi.getName(), "乙不栽植千株不长")
        XCTAssertEqual(yi.getIndex(), 1)

        // Test next
        let bing = jia.next(2)
        XCTAssertEqual(bing.getName(), "丙不修灶必见灾殃")
        XCTAssertEqual(bing.getIndex(), 2)

        // Test wrap around
        let gui = PengZuHeavenStem.fromIndex(9)
        XCTAssertEqual(gui.getName(), "癸不词讼理弱敌强")
        let nextJia = gui.next(1)
        XCTAssertEqual(nextJia.getName(), "甲不开仓财物耗散")
        XCTAssertEqual(nextJia.getIndex(), 0)

        // Test all 10 stems
        let expectedNames = [
            "甲不开仓财物耗散",
            "乙不栽植千株不长",
            "丙不修灶必见灾殃",
            "丁不剃头头必生疮",
            "戊不受田田主不祥",
            "己不破券二比并亡",
            "庚不经络织机虚张",
            "辛不合酱主人不尝",
            "壬不泱水更难提防",
            "癸不词讼理弱敌强"
        ]
        for i in 0..<10 {
            let stem = PengZuHeavenStem.fromIndex(i)
            XCTAssertEqual(stem.getName(), expectedNames[i])
        }
    }

    func testPengZuEarthBranch() throws {
        // Test fromIndex
        let zi = PengZuEarthBranch.fromIndex(0)
        XCTAssertEqual(zi.getName(), "子不问卜自惹祸殃")
        XCTAssertEqual(zi.getIndex(), 0)

        // Test fromName
        let chou = PengZuEarthBranch.fromName("丑不冠带主不还乡")
        XCTAssertEqual(chou.getName(), "丑不冠带主不还乡")
        XCTAssertEqual(chou.getIndex(), 1)

        // Test next
        let yin = zi.next(2)
        XCTAssertEqual(yin.getName(), "寅不祭祀神鬼不尝")
        XCTAssertEqual(yin.getIndex(), 2)

        // Test wrap around
        let hai = PengZuEarthBranch.fromIndex(11)
        XCTAssertEqual(hai.getName(), "亥不嫁娶不利新郎")
        let nextZi = hai.next(1)
        XCTAssertEqual(nextZi.getName(), "子不问卜自惹祸殃")
        XCTAssertEqual(nextZi.getIndex(), 0)

        // Test all 12 branches
        let expectedNames = [
            "子不问卜自惹祸殃",
            "丑不冠带主不还乡",
            "寅不祭祀神鬼不尝",
            "卯不穿井水泉不香",
            "辰不哭泣必主重丧",
            "巳不远行财物伏藏",
            "午不苫盖屋主更张",
            "未不服药毒气入肠",
            "申不安床鬼祟入房",
            "酉不会客醉坐颠狂",
            "戌不吃犬作怪上床",
            "亥不嫁娶不利新郎"
        ]
        for i in 0..<12 {
            let branch = PengZuEarthBranch.fromIndex(i)
            XCTAssertEqual(branch.getName(), expectedNames[i])
        }
    }

    func testPengZu() throws {
        // Test with SixtyCycle 甲子
        let jiaZi = SixtyCycle.fromIndex(0)
        let pengZu1 = PengZu.fromSixtyCycle(jiaZi)
        XCTAssertEqual(pengZu1.getName(), "甲不开仓财物耗散 子不问卜自惹祸殃")
        XCTAssertEqual(pengZu1.getHeavenStemTaboo(), "甲不开仓财物耗散")
        XCTAssertEqual(pengZu1.getEarthBranchTaboo(), "子不问卜自惹祸殃")

        // Test with SixtyCycle 乙丑
        let yiChou = SixtyCycle.fromIndex(1)
        let pengZu2 = PengZu.fromSixtyCycle(yiChou)
        XCTAssertEqual(pengZu2.getName(), "乙不栽植千株不长 丑不冠带主不还乡")

        // Test getTaboos
        let taboos = pengZu1.getTaboos()
        XCTAssertEqual(taboos.count, 2)
        XCTAssertEqual(taboos[0], "甲不开仓财物耗散")
        XCTAssertEqual(taboos[1], "子不问卜自惹祸殃")

        // Test getPengZuHeavenStem and getPengZuEarthBranch
        let heavenStem = pengZu1.getPengZuHeavenStem()
        XCTAssertEqual(heavenStem.getIndex(), 0)
        let earthBranch = pengZu1.getPengZuEarthBranch()
        XCTAssertEqual(earthBranch.getIndex(), 0)

        // Test with SixtyCycle 癸亥 (index 59, last one)
        let guiHai = SixtyCycle.fromIndex(59)
        let pengZu3 = PengZu.fromSixtyCycle(guiHai)
        XCTAssertEqual(pengZu3.getName(), "癸不词讼理弱敌强 亥不嫁娶不利新郎")

        // Test description (CustomStringConvertible)
        XCTAssertEqual(String(describing: pengZu1), "甲不开仓财物耗散 子不问卜自惹祸殃")
    }
}

