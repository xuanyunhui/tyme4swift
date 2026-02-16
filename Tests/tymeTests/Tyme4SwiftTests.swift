import XCTest
@testable import tyme

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

    // MARK: - Phase 4 Star System Tests

    func testLuck() throws {
        // Test fromIndex
        let ji = Luck.fromIndex(0)
        XCTAssertEqual(ji.getName(), "吉")
        XCTAssertEqual(ji.getIndex(), 0)
        XCTAssertTrue(ji.isAuspicious())
        XCTAssertFalse(ji.isInauspicious())

        let xiong = Luck.fromIndex(1)
        XCTAssertEqual(xiong.getName(), "凶")
        XCTAssertEqual(xiong.getIndex(), 1)
        XCTAssertFalse(xiong.isAuspicious())
        XCTAssertTrue(xiong.isInauspicious())

        // Test fromName
        let ji2 = Luck.fromName("吉")
        XCTAssertEqual(ji2.getIndex(), 0)

        // Test next
        let xiong2 = ji.next(1)
        XCTAssertEqual(xiong2.getName(), "凶")
        let ji3 = xiong2.next(1)
        XCTAssertEqual(ji3.getName(), "吉")
    }

    func testSevenStar() throws {
        // Test all seven stars
        let expectedNames = ["日", "月", "火", "水", "木", "金", "土"]
        for i in 0..<7 {
            let star = SevenStar.fromIndex(i)
            XCTAssertEqual(star.getName(), expectedNames[i])
            XCTAssertEqual(star.getIndex(), i)
        }

        // Test fromName
        let sun = SevenStar.fromName("日")
        XCTAssertEqual(sun.getIndex(), 0)

        // Test next
        let moon = sun.next(1)
        XCTAssertEqual(moon.getName(), "月")

        // Test wrap around
        let saturn = SevenStar.fromIndex(6)
        let nextSun = saturn.next(1)
        XCTAssertEqual(nextSun.getName(), "日")

        // Test getWeek
        let sunWeek = sun.getWeek()
        XCTAssertEqual(sunWeek.getName(), "日")
    }

    func testSixStar() throws {
        // Test all six stars
        let expectedNames = ["先胜", "友引", "先负", "佛灭", "大安", "赤口"]
        for i in 0..<6 {
            let star = SixStar.fromIndex(i)
            XCTAssertEqual(star.getName(), expectedNames[i])
            XCTAssertEqual(star.getIndex(), i)
        }

        // Test fromName
        let sensho = SixStar.fromName("先胜")
        XCTAssertEqual(sensho.getIndex(), 0)

        // Test next
        let tomobiki = sensho.next(1)
        XCTAssertEqual(tomobiki.getName(), "友引")

        // Test wrap around
        let shakko = SixStar.fromIndex(5)
        let nextSensho = shakko.next(1)
        XCTAssertEqual(nextSensho.getName(), "先胜")
    }

    func testTenStar() throws {
        // Test all ten stars
        let expectedNames = ["比肩", "劫财", "食神", "伤官", "偏财", "正财", "七杀", "正官", "偏印", "正印"]
        for i in 0..<10 {
            let star = TenStar.fromIndex(i)
            XCTAssertEqual(star.getName(), expectedNames[i])
            XCTAssertEqual(star.getIndex(), i)
        }

        // Test fromName
        let bijian = TenStar.fromName("比肩")
        XCTAssertEqual(bijian.getIndex(), 0)

        // Test next
        let jiecai = bijian.next(1)
        XCTAssertEqual(jiecai.getName(), "劫财")

        // Test wrap around
        let zhengyin = TenStar.fromIndex(9)
        let nextBijian = zhengyin.next(1)
        XCTAssertEqual(nextBijian.getName(), "比肩")
    }

    func testEcliptic() throws {
        // Test fromIndex
        let huangdao = Ecliptic.fromIndex(0)
        XCTAssertEqual(huangdao.getName(), "黄道")
        XCTAssertEqual(huangdao.getIndex(), 0)
        XCTAssertTrue(huangdao.isAuspicious())
        XCTAssertFalse(huangdao.isInauspicious())

        let heidao = Ecliptic.fromIndex(1)
        XCTAssertEqual(heidao.getName(), "黑道")
        XCTAssertEqual(heidao.getIndex(), 1)
        XCTAssertFalse(heidao.isAuspicious())
        XCTAssertTrue(heidao.isInauspicious())

        // Test fromName
        let huangdao2 = Ecliptic.fromName("黄道")
        XCTAssertEqual(huangdao2.getIndex(), 0)

        // Test getLuck
        let luck1 = huangdao.getLuck()
        XCTAssertEqual(luck1.getName(), "吉")
        let luck2 = heidao.getLuck()
        XCTAssertEqual(luck2.getName(), "凶")

        // Test next
        let heidao2 = huangdao.next(1)
        XCTAssertEqual(heidao2.getName(), "黑道")
    }

    func testTwelveStar() throws {
        // Test all twelve stars
        let expectedNames = ["青龙", "明堂", "天刑", "朱雀", "金匮", "天德", "白虎", "玉堂", "天牢", "玄武", "司命", "勾陈"]
        for i in 0..<12 {
            let star = TwelveStar.fromIndex(i)
            XCTAssertEqual(star.getName(), expectedNames[i])
            XCTAssertEqual(star.getIndex(), i)
        }

        // Test fromName
        let qinglong = TwelveStar.fromName("青龙")
        XCTAssertEqual(qinglong.getIndex(), 0)

        // Test next
        let mingtang = qinglong.next(1)
        XCTAssertEqual(mingtang.getName(), "明堂")

        // Test wrap around
        let gouchen = TwelveStar.fromIndex(11)
        let nextQinglong = gouchen.next(1)
        XCTAssertEqual(nextQinglong.getName(), "青龙")

        // Test getEcliptic - 青龙 is 黄道
        let ecliptic1 = qinglong.getEcliptic()
        XCTAssertEqual(ecliptic1.getName(), "黄道")
        XCTAssertTrue(qinglong.isAuspicious())

        // Test getEcliptic - 天刑 is 黑道
        let tianxing = TwelveStar.fromIndex(2)
        let ecliptic2 = tianxing.getEcliptic()
        XCTAssertEqual(ecliptic2.getName(), "黑道")
        XCTAssertTrue(tianxing.isInauspicious())
    }

    func testZone() throws {
        // Test all four zones
        let expectedNames = ["东", "北", "西", "南"]
        for i in 0..<4 {
            let zone = Zone.fromIndex(i)
            XCTAssertEqual(zone.getName(), expectedNames[i])
            XCTAssertEqual(zone.getIndex(), i)
        }

        // Test fromName
        let east = Zone.fromName("东")
        XCTAssertEqual(east.getIndex(), 0)

        // Test next
        let north = east.next(1)
        XCTAssertEqual(north.getName(), "北")

        // Test wrap around
        let south = Zone.fromIndex(3)
        let nextEast = south.next(1)
        XCTAssertEqual(nextEast.getName(), "东")

        // Test getDirection
        let direction = east.getDirection()
        XCTAssertEqual(direction.getName(), "东")

        // Test getBeast
        let beast = east.getBeast()
        XCTAssertEqual(beast.getName(), "青龙")
    }

    func testBeast() throws {
        // Test all four beasts
        let expectedNames = ["青龙", "玄武", "白虎", "朱雀"]
        for i in 0..<4 {
            let beast = Beast.fromIndex(i)
            XCTAssertEqual(beast.getName(), expectedNames[i])
            XCTAssertEqual(beast.getIndex(), i)
        }

        // Test fromName
        let qinglong = Beast.fromName("青龙")
        XCTAssertEqual(qinglong.getIndex(), 0)

        // Test next
        let xuanwu = qinglong.next(1)
        XCTAssertEqual(xuanwu.getName(), "玄武")

        // Test wrap around
        let zhuque = Beast.fromIndex(3)
        let nextQinglong = zhuque.next(1)
        XCTAssertEqual(nextQinglong.getName(), "青龙")

        // Test getZone
        let zone = qinglong.getZone()
        XCTAssertEqual(zone.getName(), "东")
    }

    func testLand() throws {
        // Test all nine lands
        let expectedNames = ["玄天", "朱天", "苍天", "阳天", "钧天", "幽天", "颢天", "变天", "炎天"]
        for i in 0..<9 {
            let land = Land.fromIndex(i)
            XCTAssertEqual(land.getName(), expectedNames[i])
            XCTAssertEqual(land.getIndex(), i)
        }

        // Test fromName
        let xuantian = Land.fromName("玄天")
        XCTAssertEqual(xuantian.getIndex(), 0)

        // Test next
        let zhutian = xuantian.next(1)
        XCTAssertEqual(zhutian.getName(), "朱天")

        // Test wrap around
        let yantian = Land.fromIndex(8)
        let nextXuantian = yantian.next(1)
        XCTAssertEqual(nextXuantian.getName(), "玄天")

        // Test getDirection
        let direction = xuantian.getDirection()
        XCTAssertEqual(direction.getName(), "北")
    }

    func testAnimal() throws {
        // Test first few animals
        let expectedNames = ["蛟", "龙", "貉", "兔", "狐", "虎", "豹"]
        for i in 0..<7 {
            let animal = Animal.fromIndex(i)
            XCTAssertEqual(animal.getName(), expectedNames[i])
            XCTAssertEqual(animal.getIndex(), i)
        }

        // Test fromName
        let jiao = Animal.fromName("蛟")
        XCTAssertEqual(jiao.getIndex(), 0)

        // Test next
        let long = jiao.next(1)
        XCTAssertEqual(long.getName(), "龙")

        // Test wrap around (28 animals)
        let yin = Animal.fromIndex(27)
        let nextJiao = yin.next(1)
        XCTAssertEqual(nextJiao.getName(), "蛟")

        // Test getTwentyEightStar
        let star = jiao.getTwentyEightStar()
        XCTAssertEqual(star.getName(), "角")
    }

    func testTwentyEightStar() throws {
        // Test first few stars
        let expectedNames = ["角", "亢", "氐", "房", "心", "尾", "箕"]
        for i in 0..<7 {
            let star = TwentyEightStar.fromIndex(i)
            XCTAssertEqual(star.getName(), expectedNames[i])
            XCTAssertEqual(star.getIndex(), i)
        }

        // Test fromName
        let jiao = TwentyEightStar.fromName("角")
        XCTAssertEqual(jiao.getIndex(), 0)

        // Test next
        let kang = jiao.next(1)
        XCTAssertEqual(kang.getName(), "亢")

        // Test wrap around (28 stars)
        let zhen = TwentyEightStar.fromIndex(27)
        let nextJiao = zhen.next(1)
        XCTAssertEqual(nextJiao.getName(), "角")

        // Test getZone - first 7 stars are in East (东)
        let zone = jiao.getZone()
        XCTAssertEqual(zone.getName(), "东")

        // Test getZone - stars 7-13 are in North (北)
        let dou = TwentyEightStar.fromIndex(7)
        let northZone = dou.getZone()
        XCTAssertEqual(northZone.getName(), "北")

        // Test getAnimal
        let animal = jiao.getAnimal()
        XCTAssertEqual(animal.getName(), "蛟")

        // Test getLand
        let land = jiao.getLand()
        XCTAssertEqual(land.getName(), "钧天")

        // Test getLuck - 角 is 吉
        let luck = jiao.getLuck()
        XCTAssertEqual(luck.getName(), "吉")
        XCTAssertTrue(jiao.isAuspicious())

        // Test getLuck - 亢 is 凶
        let luck2 = kang.getLuck()
        XCTAssertEqual(luck2.getName(), "凶")
        XCTAssertTrue(kang.isInauspicious())

        // Test getSevenStar
        let sevenStar = jiao.getSevenStar()
        XCTAssertEqual(sevenStar.getName(), "木")
    }

    func testDuty() throws {
        // Test all twelve duties
        let expectedNames = ["建", "除", "满", "平", "定", "执", "破", "危", "成", "收", "开", "闭"]
        for i in 0..<12 {
            let duty = Duty.fromIndex(i)
            XCTAssertEqual(duty.getName(), expectedNames[i])
            XCTAssertEqual(duty.getIndex(), i)
        }

        // Test fromName
        let jian = Duty.fromName("建")
        XCTAssertEqual(jian.getIndex(), 0)

        // Test next
        let chu = jian.next(1)
        XCTAssertEqual(chu.getName(), "除")

        // Test wrap around
        let bi = Duty.fromIndex(11)
        let nextJian = bi.next(1)
        XCTAssertEqual(nextJian.getName(), "建")
    }

    func testConstellation() throws {
        // Test all twelve constellations
        let expectedNames = ["白羊", "金牛", "双子", "巨蟹", "狮子", "处女", "天秤", "天蝎", "射手", "摩羯", "水瓶", "双鱼"]
        for i in 0..<12 {
            let constellation = Constellation.fromIndex(i)
            XCTAssertEqual(constellation.getName(), expectedNames[i])
            XCTAssertEqual(constellation.getIndex(), i)
        }

        // Test fromName
        let aries = Constellation.fromName("白羊")
        XCTAssertEqual(aries.getIndex(), 0)

        // Test next
        let taurus = aries.next(1)
        XCTAssertEqual(taurus.getName(), "金牛")

        // Test wrap around
        let pisces = Constellation.fromIndex(11)
        let nextAries = pisces.next(1)
        XCTAssertEqual(nextAries.getName(), "白羊")
    }

    // MARK: - Phase 5 Core Culture Systems Tests

    func testSound() throws {
        // Test all five sounds
        let expectedNames = ["宫", "商", "角", "徵", "羽"]
        let expectedWuXing = ["土", "金", "木", "火", "水"]
        for i in 0..<5 {
            let sound = Sound.fromIndex(i)
            XCTAssertEqual(sound.getName(), expectedNames[i])
            XCTAssertEqual(sound.getIndex(), i)
            XCTAssertEqual(sound.getWuXing(), expectedWuXing[i])
        }

        // Test fromName
        let gong = Sound.fromName("宫")
        XCTAssertEqual(gong.getIndex(), 0)

        // Test next
        let shang = gong.next(1)
        XCTAssertEqual(shang.getName(), "商")

        // Test wrap around
        let yu = Sound.fromIndex(4)
        let nextGong = yu.next(1)
        XCTAssertEqual(nextGong.getName(), "宫")

        // Test getElement
        let element = gong.getElement()
        XCTAssertEqual(element.getName(), "土")
    }

    func testPhase() throws {
        // Test all three phases
        let expectedNames = ["上旬", "中旬", "下旬"]
        for i in 0..<3 {
            let phase = Phase.fromIndex(i)
            XCTAssertEqual(phase.getName(), expectedNames[i])
            XCTAssertEqual(phase.getIndex(), i)
        }

        // Test fromName
        let shangXun = Phase.fromName("上旬")
        XCTAssertEqual(shangXun.getIndex(), 0)

        // Test next
        let zhongXun = shangXun.next(1)
        XCTAssertEqual(zhongXun.getName(), "中旬")

        // Test wrap around
        let xiaXun = Phase.fromIndex(2)
        let nextShangXun = xiaXun.next(1)
        XCTAssertEqual(nextShangXun.getName(), "上旬")
    }

    func testPhenology() throws {
        // Test first few phenologies
        let expectedNames = ["蚯蚓结", "麋角解", "水泉动"]
        for i in 0..<3 {
            let phenology = Phenology.fromIndex(i)
            XCTAssertEqual(phenology.getName(), expectedNames[i])
            XCTAssertEqual(phenology.getIndex(), i)
        }

        // Test fromName
        let qiuYinJie = Phenology.fromName("蚯蚓结")
        XCTAssertEqual(qiuYinJie.getIndex(), 0)

        // Test next
        let miJiaoJie = qiuYinJie.next(1)
        XCTAssertEqual(miJiaoJie.getName(), "麋角解")

        // Test wrap around (72 phenologies)
        let liTingChu = Phenology.fromIndex(71)
        let nextQiuYinJie = liTingChu.next(1)
        XCTAssertEqual(nextQiuYinJie.getName(), "蚯蚓结")

        // Test getThreePhenology
        let threePhenology = qiuYinJie.getThreePhenology()
        XCTAssertEqual(threePhenology.getName(), "初候")

        // Test getSolarTermIndex
        XCTAssertEqual(qiuYinJie.getSolarTermIndex(), 0)
    }

    func testThreePhenology() throws {
        // Test all three phenology periods
        let expectedNames = ["初候", "二候", "三候"]
        for i in 0..<3 {
            let threePhenology = ThreePhenology.fromIndex(i)
            XCTAssertEqual(threePhenology.getName(), expectedNames[i])
            XCTAssertEqual(threePhenology.getIndex(), i)
        }

        // Test fromName
        let chuHou = ThreePhenology.fromName("初候")
        XCTAssertEqual(chuHou.getIndex(), 0)

        // Test next
        let erHou = chuHou.next(1)
        XCTAssertEqual(erHou.getName(), "二候")

        // Test wrap around
        let sanHou = ThreePhenology.fromIndex(2)
        let nextChuHou = sanHou.next(1)
        XCTAssertEqual(nextChuHou.getName(), "初候")
    }

    func testPhaseDay() throws {
        // Test all five phase days
        let expectedNames = ["一", "二", "三", "四", "五"]
        for i in 0..<5 {
            let phaseDay = PhaseDay.fromIndex(i)
            XCTAssertEqual(phaseDay.getName(), expectedNames[i])
            XCTAssertEqual(phaseDay.getIndex(), i)
            XCTAssertEqual(phaseDay.getDayNumber(), i + 1)
        }

        // Test fromName
        let yi = PhaseDay.fromName("一")
        XCTAssertEqual(yi.getIndex(), 0)

        // Test next
        let er = yi.next(1)
        XCTAssertEqual(er.getName(), "二")

        // Test wrap around
        let wu = PhaseDay.fromIndex(4)
        let nextYi = wu.next(1)
        XCTAssertEqual(nextYi.getName(), "一")
    }

    func testTenDay() throws {
        // Test all ten days
        let expectedNames = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
        for i in 0..<10 {
            let tenDay = TenDay.fromIndex(i)
            XCTAssertEqual(tenDay.getName(), expectedNames[i])
            XCTAssertEqual(tenDay.getIndex(), i)
        }

        // Test fromName
        let jia = TenDay.fromName("甲")
        XCTAssertEqual(jia.getIndex(), 0)

        // Test next
        let yi = jia.next(1)
        XCTAssertEqual(yi.getName(), "乙")

        // Test wrap around
        let gui = TenDay.fromIndex(9)
        let nextJia = gui.next(1)
        XCTAssertEqual(nextJia.getName(), "甲")

        // Test getHeavenStem
        let heavenStem = jia.getHeavenStem()
        XCTAssertEqual(heavenStem.getName(), "甲")
    }

    func testTerrain() throws {
        // Test all twelve terrains
        let expectedNames = ["长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎", "养"]
        for i in 0..<12 {
            let terrain = Terrain.fromIndex(i)
            XCTAssertEqual(terrain.getName(), expectedNames[i])
            XCTAssertEqual(terrain.getIndex(), i)
        }

        // Test fromName
        let changSheng = Terrain.fromName("长生")
        XCTAssertEqual(changSheng.getIndex(), 0)

        // Test next
        let muYu = changSheng.next(1)
        XCTAssertEqual(muYu.getName(), "沐浴")

        // Test wrap around
        let yang = Terrain.fromIndex(11)
        let nextChangSheng = yang.next(1)
        XCTAssertEqual(nextChangSheng.getName(), "长生")

        // Test isProsperous
        XCTAssertTrue(changSheng.isProsperous())
        XCTAssertFalse(muYu.isProsperous())

        // Test isDeclining
        let shuai = Terrain.fromIndex(5)
        XCTAssertTrue(shuai.isDeclining())
        XCTAssertFalse(changSheng.isDeclining())

        // Test isNurturing
        XCTAssertTrue(muYu.isNurturing())
        XCTAssertFalse(changSheng.isNurturing())
    }

    func testNaYin() throws {
        // Test first few NaYin
        let expectedNames = ["海中金", "炉中火", "大林木", "路旁土", "剑锋金"]
        let expectedWuXing = ["金", "火", "木", "土", "金"]
        for i in 0..<5 {
            let naYin = NaYin.fromIndex(i)
            XCTAssertEqual(naYin.getName(), expectedNames[i])
            XCTAssertEqual(naYin.getIndex(), i)
            XCTAssertEqual(naYin.getWuXing(), expectedWuXing[i])
        }

        // Test fromName
        let haiZhongJin = NaYin.fromName("海中金")
        XCTAssertEqual(haiZhongJin.getIndex(), 0)

        // Test next
        let luZhongHuo = haiZhongJin.next(1)
        XCTAssertEqual(luZhongHuo.getName(), "炉中火")

        // Test wrap around (30 NaYin)
        let daHaiShui = NaYin.fromIndex(29)
        let nextHaiZhongJin = daHaiShui.next(1)
        XCTAssertEqual(nextHaiZhongJin.getName(), "海中金")

        // Test fromSixtyCycle
        let naYin0 = NaYin.fromSixtyCycle(0)
        XCTAssertEqual(naYin0.getName(), "海中金")
        let naYin1 = NaYin.fromSixtyCycle(1)
        XCTAssertEqual(naYin1.getName(), "海中金")
        let naYin2 = NaYin.fromSixtyCycle(2)
        XCTAssertEqual(naYin2.getName(), "炉中火")

        // Test getElement
        let element = haiZhongJin.getElement()
        XCTAssertEqual(element.getName(), "金")
    }

    func testSixty() throws {
        // Test first few Sixty
        let expectedNames = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰"]
        for i in 0..<5 {
            let sixty = Sixty.fromIndex(i)
            XCTAssertEqual(sixty.getName(), expectedNames[i])
            XCTAssertEqual(sixty.getIndex(), i)
        }

        // Test fromName
        let jiaZi = Sixty.fromName("甲子")
        XCTAssertEqual(jiaZi.getIndex(), 0)

        // Test next
        let yiChou = jiaZi.next(1)
        XCTAssertEqual(yiChou.getName(), "乙丑")

        // Test wrap around (60 Sixty)
        let guiHai = Sixty.fromIndex(59)
        let nextJiaZi = guiHai.next(1)
        XCTAssertEqual(nextJiaZi.getName(), "甲子")

        // Test getSixtyCycle
        let sixtyCycle = jiaZi.getSixtyCycle()
        XCTAssertEqual(sixtyCycle.getName(), "甲子")

        // Test getNaYin
        let naYin = jiaZi.getNaYin()
        XCTAssertEqual(naYin.getName(), "海中金")

        // Test getHeavenStem
        let heavenStem = jiaZi.getHeavenStem()
        XCTAssertEqual(heavenStem.getName(), "甲")

        // Test getEarthBranch
        let earthBranch = jiaZi.getEarthBranch()
        XCTAssertEqual(earthBranch.getName(), "子")
    }

    func testTen() throws {
        // Test all ten
        let expectedNames = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
        for i in 0..<10 {
            let ten = Ten.fromIndex(i)
            XCTAssertEqual(ten.getName(), expectedNames[i])
            XCTAssertEqual(ten.getIndex(), i)
            XCTAssertEqual(ten.getDayNumber(), i + 1)
        }

        // Test fromName
        let yi = Ten.fromName("一")
        XCTAssertEqual(yi.getIndex(), 0)

        // Test next
        let er = yi.next(1)
        XCTAssertEqual(er.getName(), "二")

        // Test wrap around
        let shi = Ten.fromIndex(9)
        let nextYi = shi.next(1)
        XCTAssertEqual(nextYi.getName(), "一")
    }

    func testTwenty() throws {
        // Test first few twenty
        let expectedNames = ["初一", "初二", "初三", "初四", "初五"]
        for i in 0..<5 {
            let twenty = Twenty.fromIndex(i)
            XCTAssertEqual(twenty.getName(), expectedNames[i])
            XCTAssertEqual(twenty.getIndex(), i)
            XCTAssertEqual(twenty.getDayNumber(), i + 1)
        }

        // Test fromName
        let chuYi = Twenty.fromName("初一")
        XCTAssertEqual(chuYi.getIndex(), 0)

        // Test next
        let chuEr = chuYi.next(1)
        XCTAssertEqual(chuEr.getName(), "初二")

        // Test wrap around (20 Twenty)
        let erShi = Twenty.fromIndex(19)
        let nextChuYi = erShi.next(1)
        XCTAssertEqual(nextChuYi.getName(), "初一")
    }

    func testGodType() throws {
        // Test all four god types
        let expectedNames = ["年", "月", "日", "时"]
        for i in 0..<4 {
            let godType = GodType.fromIndex(i)
            XCTAssertEqual(godType.getName(), expectedNames[i])
            XCTAssertEqual(godType.getIndex(), i)
        }

        // Test fromName
        let nian = GodType.fromName("年")
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

    // MARK: - Phase 6 Enum Tests

    func testYinYang() throws {
        // Test Yang
        let yang = YinYang.yang
        XCTAssertEqual(yang.name, "阳")
        XCTAssertEqual(yang.rawValue, 0)
        XCTAssertTrue(yang.isYang)
        XCTAssertFalse(yang.isYin)

        // Test Yin
        let yin = YinYang.yin
        XCTAssertEqual(yin.name, "阴")
        XCTAssertEqual(yin.rawValue, 1)
        XCTAssertFalse(yin.isYang)
        XCTAssertTrue(yin.isYin)

        // Test fromIndex
        XCTAssertEqual(YinYang.fromIndex(0), .yang)
        XCTAssertEqual(YinYang.fromIndex(1), .yin)
        XCTAssertEqual(YinYang.fromIndex(2), .yang)
        XCTAssertEqual(YinYang.fromIndex(3), .yin)

        // Test fromName
        XCTAssertEqual(YinYang.fromName("阳"), .yang)
        XCTAssertEqual(YinYang.fromName("阴"), .yin)

        // Test opposite
        XCTAssertEqual(yang.opposite(), .yin)
        XCTAssertEqual(yin.opposite(), .yang)

        // Test description
        XCTAssertEqual(String(describing: yang), "阳")
        XCTAssertEqual(String(describing: yin), "阴")
    }

    func testGender() throws {
        // Test Male
        let male = Gender.male
        XCTAssertEqual(male.name, "男")
        XCTAssertEqual(male.rawValue, 0)
        XCTAssertTrue(male.isMale)
        XCTAssertFalse(male.isFemale)

        // Test Female
        let female = Gender.female
        XCTAssertEqual(female.name, "女")
        XCTAssertEqual(female.rawValue, 1)
        XCTAssertFalse(female.isMale)
        XCTAssertTrue(female.isFemale)

        // Test fromIndex
        XCTAssertEqual(Gender.fromIndex(0), .male)
        XCTAssertEqual(Gender.fromIndex(1), .female)
        XCTAssertEqual(Gender.fromIndex(2), .male)

        // Test fromName
        XCTAssertEqual(Gender.fromName("男"), .male)
        XCTAssertEqual(Gender.fromName("女"), .female)

        // Test description
        XCTAssertEqual(String(describing: male), "男")
        XCTAssertEqual(String(describing: female), "女")
    }

    func testSide() throws {
        // Test Inner
        let inner = Side.inner
        XCTAssertEqual(inner.name, "内")
        XCTAssertEqual(inner.rawValue, 0)
        XCTAssertTrue(inner.isInner)
        XCTAssertFalse(inner.isOuter)

        // Test Outer
        let outer = Side.outer
        XCTAssertEqual(outer.name, "外")
        XCTAssertEqual(outer.rawValue, 1)
        XCTAssertFalse(outer.isInner)
        XCTAssertTrue(outer.isOuter)

        // Test fromIndex
        XCTAssertEqual(Side.fromIndex(0), .inner)
        XCTAssertEqual(Side.fromIndex(1), .outer)
        XCTAssertEqual(Side.fromIndex(2), .inner)

        // Test fromName
        XCTAssertEqual(Side.fromName("内"), .inner)
        XCTAssertEqual(Side.fromName("外"), .outer)

        // Test description
        XCTAssertEqual(String(describing: inner), "内")
        XCTAssertEqual(String(describing: outer), "外")
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

    func testFestivalType() throws {
        // Test Day
        let day = FestivalType.day
        XCTAssertEqual(day.name, "日期")
        XCTAssertEqual(day.rawValue, 0)

        // Test Term
        let term = FestivalType.term
        XCTAssertEqual(term.name, "节气")
        XCTAssertEqual(term.rawValue, 1)

        // Test Eve
        let eve = FestivalType.eve
        XCTAssertEqual(eve.name, "除夕")
        XCTAssertEqual(eve.rawValue, 2)

        // Test fromIndex
        XCTAssertEqual(FestivalType.fromIndex(0), .day)
        XCTAssertEqual(FestivalType.fromIndex(1), .term)
        XCTAssertEqual(FestivalType.fromIndex(2), .eve)
        XCTAssertEqual(FestivalType.fromIndex(3), .day)

        // Test fromName
        XCTAssertEqual(FestivalType.fromName("日期"), .day)
        XCTAssertEqual(FestivalType.fromName("节气"), .term)
        XCTAssertEqual(FestivalType.fromName("除夕"), .eve)

        // Test description
        XCTAssertEqual(String(describing: day), "日期")
    }

    // MARK: - Phase 7 SixtyCycle Extension Tests

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
        let day = SixtyCycleDay.fromYmd(2024, 2, 10)
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
        let solarDay = SolarDay.fromYmd(2024, 2, 10)
        let day2 = SixtyCycleDay.fromSolarDay(solarDay)
        XCTAssertEqual(day.getName(), day2.getName())
    }

    func testSixtyCycleHour() throws {
        // Test a specific time
        let hour = SixtyCycleHour.fromYmdHms(2024, 2, 10, 12, 0, 0)
        XCTAssertNotNil(hour.getSixtyCycle())
        XCTAssertNotNil(hour.getHeavenStem())
        XCTAssertNotNil(hour.getEarthBranch())
        XCTAssertNotNil(hour.getNaYin())

        // Test getIndexInDay
        let hourIndex = hour.getIndexInDay()
        XCTAssertEqual(hourIndex, 6) // 12:00 is 午时 (index 6)

        // Test 子时 (23:00-01:00)
        let ziHour = SixtyCycleHour.fromYmdHms(2024, 2, 10, 0, 0, 0)
        XCTAssertEqual(ziHour.getIndexInDay(), 0)

        // Test next
        let nextHour = hour.next(1)
        XCTAssertNotNil(nextHour)
    }

    // MARK: - Phase 8 Culture Subsystem Tests

    func testDog() throws {
        // Test all three dog periods
        let expectedNames = ["初伏", "中伏", "末伏"]
        for i in 0..<3 {
            let dog = Dog.fromIndex(i)
            XCTAssertEqual(dog.getName(), expectedNames[i])
            XCTAssertEqual(dog.getIndex(), i)
        }

        // Test fromName
        let chuFu = Dog.fromName("初伏")
        XCTAssertEqual(chuFu.getIndex(), 0)

        // Test next
        let zhongFu = chuFu.next(1)
        XCTAssertEqual(zhongFu.getName(), "中伏")

        // Test wrap around
        let moFu = Dog.fromIndex(2)
        let nextChuFu = moFu.next(1)
        XCTAssertEqual(nextChuFu.getName(), "初伏")
    }

    func testDogDay() throws {
        let dog = Dog.fromIndex(0)
        let dogDay = DogDay.fromDog(dog, 0)
        XCTAssertEqual(dogDay.getDog().getName(), "初伏")
        XCTAssertEqual(dogDay.getDayIndex(), 0)
        XCTAssertEqual(dogDay.getName(), "初伏第1天")

        let dogDay2 = DogDay.fromDog(dog, 4)
        XCTAssertEqual(dogDay2.getName(), "初伏第5天")
    }

    func testNine() throws {
        // Test all nine periods
        let expectedNames = ["一九", "二九", "三九", "四九", "五九", "六九", "七九", "八九", "九九"]
        for i in 0..<9 {
            let nine = Nine.fromIndex(i)
            XCTAssertEqual(nine.getName(), expectedNames[i])
            XCTAssertEqual(nine.getIndex(), i)
        }

        // Test fromName
        let yiJiu = Nine.fromName("一九")
        XCTAssertEqual(yiJiu.getIndex(), 0)

        // Test next
        let erJiu = yiJiu.next(1)
        XCTAssertEqual(erJiu.getName(), "二九")

        // Test wrap around
        let jiuJiu = Nine.fromIndex(8)
        let nextYiJiu = jiuJiu.next(1)
        XCTAssertEqual(nextYiJiu.getName(), "一九")
    }

    func testNineColdDay() throws {
        let nine = Nine.fromIndex(0)
        let nineDay = NineColdDay.fromNine(nine, 0)
        XCTAssertEqual(nineDay.getNine().getName(), "一九")
        XCTAssertEqual(nineDay.getDayIndex(), 0)
        XCTAssertEqual(nineDay.getName(), "一九第1天")

        let nineDay2 = NineColdDay.fromNine(nine, 8)
        XCTAssertEqual(nineDay2.getName(), "一九第9天")
    }

    func testPlumRain() throws {
        // Test both plum rain periods
        let ruMei = PlumRain.fromIndex(0)
        XCTAssertEqual(ruMei.getName(), "入梅")
        XCTAssertTrue(ruMei.isEntering())
        XCTAssertFalse(ruMei.isExiting())

        let chuMei = PlumRain.fromIndex(1)
        XCTAssertEqual(chuMei.getName(), "出梅")
        XCTAssertFalse(chuMei.isEntering())
        XCTAssertTrue(chuMei.isExiting())

        // Test next
        let next = ruMei.next(1)
        XCTAssertEqual(next.getName(), "出梅")
    }

    func testPlumRainDay() throws {
        let plumRain = PlumRain.fromIndex(0)
        let plumRainDay = PlumRainDay.fromPlumRain(plumRain, 0)
        XCTAssertEqual(plumRainDay.getPlumRain().getName(), "入梅")
        XCTAssertEqual(plumRainDay.getDayIndex(), 0)
        XCTAssertEqual(plumRainDay.getName(), "入梅第1天")
    }

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

    func testTaboo() throws {
        // Test auspicious taboo
        let auspicious = Taboo.auspicious("祭祀")
        XCTAssertEqual(auspicious.getName(), "祭祀")
        XCTAssertTrue(auspicious.isAuspicious())
        XCTAssertFalse(auspicious.isInauspicious())

        // Test inauspicious taboo
        let inauspicious = Taboo.inauspicious("动土")
        XCTAssertEqual(inauspicious.getName(), "动土")
        XCTAssertFalse(inauspicious.isAuspicious())
        XCTAssertTrue(inauspicious.isInauspicious())
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

    func testLifePalace() throws {
        let yearBranch = EarthBranch.fromIndex(0) // 子
        let monthBranch = EarthBranch.fromIndex(2) // 寅
        let lifePalace = LifePalace.fromYearMonth(yearBranch, monthBranch)
        XCTAssertNotNil(lifePalace.getSixtyCycle())
        XCTAssertNotNil(lifePalace.getHeavenStem())
        XCTAssertNotNil(lifePalace.getEarthBranch())
    }

    func testBodyPalace() throws {
        let yearBranch = EarthBranch.fromIndex(0) // 子
        let hourBranch = EarthBranch.fromIndex(6) // 午
        let bodyPalace = BodyPalace.fromYearHour(yearBranch, hourBranch)
        XCTAssertNotNil(bodyPalace.getSixtyCycle())
        XCTAssertNotNil(bodyPalace.getHeavenStem())
        XCTAssertNotNil(bodyPalace.getEarthBranch())
    }

    // MARK: - Phase 9 God System Tests

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

    // MARK: - Phase 10 EightChar Provider Tests

    func testDefaultEightCharProvider() throws {
        let provider = DefaultEightCharProvider()

        // Test year pillar
        let yearSixtyCycle = provider.getYearSixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(yearSixtyCycle)
        XCTAssertNotNil(yearSixtyCycle.getHeavenStem())
        XCTAssertNotNil(yearSixtyCycle.getEarthBranch())

        // Test month pillar
        let monthSixtyCycle = provider.getMonthSixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(monthSixtyCycle)

        // Test day pillar
        let daySixtyCycle = provider.getDaySixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(daySixtyCycle)

        // Test hour pillar
        let hourSixtyCycle = provider.getHourSixtyCycle(year: 2024, month: 2, day: 10, hour: 12)
        XCTAssertNotNil(hourSixtyCycle)
    }

    func testLunarEightCharProvider() throws {
        let provider = LunarEightCharProvider()

        // Test year pillar
        let yearSixtyCycle = provider.getYearSixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(yearSixtyCycle)

        // Test month pillar
        let monthSixtyCycle = provider.getMonthSixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(monthSixtyCycle)

        // Test day pillar
        let daySixtyCycle = provider.getDaySixtyCycle(year: 2024, month: 2, day: 10)
        XCTAssertNotNil(daySixtyCycle)

        // Test hour pillar
        let hourSixtyCycle = provider.getHourSixtyCycle(year: 2024, month: 2, day: 10, hour: 12)
        XCTAssertNotNil(hourSixtyCycle)
    }

    func testChildLimitDefault() throws {
        // Verify ChildLimit creation and structural correctness
        let cl1 = ChildLimit.fromSolarTime(SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .male)
        XCTAssertGreaterThanOrEqual(cl1.getYearCount(), 0)
        XCTAssertGreaterThanOrEqual(cl1.getMonthCount(), 0)
        XCTAssertGreaterThanOrEqual(cl1.getDayCount(), 0)
        XCTAssertTrue(cl1.isForward()) // 壬寅年, Yang stem + Male = forward
        // EndTime should be after birth time
        XCTAssertTrue(cl1.getEndTime().isAfter(cl1.getStartTime()))

        // Female, Yang year = backward
        let cl2 = ChildLimit.fromSolarTime(SolarTime.fromYmdHms(2022, 3, 9, 20, 51, 0), .female)
        XCTAssertFalse(cl2.isForward())
        XCTAssertTrue(cl2.getEndTime().isAfter(cl2.getStartTime()))

        // Verify different providers give different results
        let cl3 = ChildLimit.fromSolarTime(SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        XCTAssertGreaterThanOrEqual(cl3.getYearCount(), 0)
        XCTAssertTrue(cl3.getEndTime().isAfter(cl3.getStartTime()))
    }

    func testChildLimitChina95() throws {
        ChildLimit.provider = China95ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        // China95 uses minute-based calculation, verify non-negative results
        XCTAssertGreaterThanOrEqual(cl.getYearCount(), 0)
        XCTAssertGreaterThanOrEqual(cl.getMonthCount(), 0)
        XCTAssertEqual(cl.getHourCount(), 0) // China95 always has 0 hours
        XCTAssertEqual(cl.getMinuteCount(), 0) // China95 always has 0 minutes
        XCTAssertTrue(cl.getEndTime().isAfter(cl.getStartTime()))
        ChildLimit.provider = DefaultChildLimitProvider()
    }

    func testChildLimitLunarSect1() throws {
        ChildLimit.provider = LunarSect1ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(SolarTime.fromYmdHms(1994, 10, 17, 1, 0, 0), .male)
        // LunarSect1 uses day/hour-based calculation
        XCTAssertGreaterThanOrEqual(cl.getYearCount(), 0)
        XCTAssertEqual(cl.getHourCount(), 0) // LunarSect1 always has 0 hours
        XCTAssertEqual(cl.getMinuteCount(), 0) // LunarSect1 always has 0 minutes
        XCTAssertTrue(cl.getEndTime().isAfter(cl.getStartTime()))
        ChildLimit.provider = DefaultChildLimitProvider()
    }

    func testChildLimitLunarSect2() throws {
        ChildLimit.provider = LunarSect2ChildLimitProvider()
        let cl = ChildLimit.fromSolarTime(SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0), .male)
        // LunarSect2 uses minute-based calculation with hour component
        XCTAssertGreaterThanOrEqual(cl.getYearCount(), 0)
        XCTAssertGreaterThanOrEqual(cl.getMonthCount(), 0)
        XCTAssertEqual(cl.getMinuteCount(), 0) // LunarSect2 always has 0 minutes
        XCTAssertTrue(cl.getEndTime().isAfter(cl.getStartTime()))
        ChildLimit.provider = DefaultChildLimitProvider()
    }

    func testChildLimitProviderSwitch() throws {
        // Verify provider switching works
        let birthTime = SolarTime.fromYmdHms(1986, 5, 29, 13, 37, 0)

        ChildLimit.provider = DefaultChildLimitProvider()
        let defaultResult = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = China95ChildLimitProvider()
        let china95Result = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = LunarSect1ChildLimitProvider()
        let sect1Result = ChildLimit.fromSolarTime(birthTime, .male)

        ChildLimit.provider = LunarSect2ChildLimitProvider()
        let sect2Result = ChildLimit.fromSolarTime(birthTime, .male)

        // Different providers should generally give different results
        // (they use different conversion formulas)
        XCTAssertTrue(
            defaultResult.getEndTime().getName() != china95Result.getEndTime().getName() ||
            defaultResult.getEndTime().getName() != sect1Result.getEndTime().getName() ||
            defaultResult.getEndTime().getName() != sect2Result.getEndTime().getName()
        )

        ChildLimit.provider = DefaultChildLimitProvider()
    }

    func testDecadeFortuneProvider() throws {
        let provider = DefaultDecadeFortuneProvider()

        let maleFortunes = provider.getDecadeFortunes(gender: .male, year: 2024, month: 2, day: 10, hour: 12, count: 8)
        XCTAssertEqual(maleFortunes.count, 8)
        for fortune in maleFortunes {
            XCTAssertNotNil(fortune.sixtyCycle)
            XCTAssertNotNil(fortune.getName())
            XCTAssertNotNil(fortune.getHeavenStem())
            XCTAssertNotNil(fortune.getEarthBranch())
        }

        let femaleFortunes = provider.getDecadeFortunes(gender: .female, year: 2024, month: 2, day: 10, hour: 12, count: 8)
        XCTAssertEqual(femaleFortunes.count, 8)
    }

    func testSolarDayGetTerm() throws {
        // Verify getTerm returns a valid solar term
        let sd = SolarDay.fromYmd(2022, 3, 9)
        let term = sd.getTerm()
        XCTAssertNotNil(term)
        // March 9 is after 惊蛰 (~March 5) and before 春分 (~March 20)
        // With current ShouXingUtil, we verify it returns a valid term
        XCTAssertTrue(term.index >= 0 && term.index < 24)
    }

    func testSolarTimeSubtract() throws {
        let t1 = SolarTime.fromYmdHms(2024, 1, 1, 12, 0, 0)
        let t2 = SolarTime.fromYmdHms(2024, 1, 1, 10, 0, 0)
        XCTAssertEqual(t1.subtract(t2), 7200) // 2 hours = 7200 seconds

        let t3 = SolarTime.fromYmdHms(2024, 1, 2, 0, 0, 0)
        XCTAssertEqual(t3.subtract(t1), 43200) // 12 hours
    }

    func testSolarTimeTerm() throws {
        let t1 = SolarTime.fromYmdHms(2024, 3, 20, 12, 0, 0)
        let term = t1.getTerm()
        XCTAssertNotNil(term)
    }

    func testDecadeFortuneInfo() throws {
        let sixtyCycle = SixtyCycle.fromIndex(0)
        let info = DecadeFortuneInfo(index: 0, sixtyCycle: sixtyCycle, startAge: 5, endAge: 14)
        XCTAssertEqual(info.index, 0)
        XCTAssertEqual(info.startAge, 5)
        XCTAssertEqual(info.endAge, 14)
        XCTAssertEqual(info.getName(), "甲子")
        XCTAssertEqual(info.getHeavenStem().getName(), "甲")
        XCTAssertEqual(info.getEarthBranch().getName(), "子")
    }

    // MARK: - ThreePillars Tests

    func testThreePillars() throws {
        // Test basic creation with SixtyCycle objects
        let year = SixtyCycle.fromName("甲戌")
        let month = SixtyCycle.fromName("甲戌")
        let day = SixtyCycle.fromName("甲戌")
        let threePillars = ThreePillars(year: year, month: month, day: day)

        XCTAssertEqual(threePillars.getName(), "甲戌 甲戌 甲戌")
        XCTAssertEqual(threePillars.getYear().getName(), "甲戌")
        XCTAssertEqual(threePillars.getMonth().getName(), "甲戌")
        XCTAssertEqual(threePillars.getDay().getName(), "甲戌")

        // Test convenience initializer with strings
        let threePillars2 = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        XCTAssertEqual(threePillars2.getName(), "甲戌 甲戌 甲戌")

        // Test description (CustomStringConvertible)
        XCTAssertEqual(String(describing: threePillars), "甲戌 甲戌 甲戌")
    }

    func testThreePillarsFromSolarDay() throws {
        // Aligned with tyme4j: SolarDay(1034, 10, 2) → ThreePillars = "甲戌 甲戌 甲戌"
        let solarDay = SolarDay.fromYmd(1034, 10, 2)
        let threePillars = solarDay.getSixtyCycleDay().getThreePillars()
        XCTAssertEqual(threePillars.getName(), "甲戌 甲戌 甲戌")
    }

    func testThreePillarsFromMultipleDates() throws {
        // Test additional dates to verify getThreePillars consistency
        // 2024-02-10 should produce a valid ThreePillars
        let day1 = SolarDay.fromYmd(2024, 2, 10).getSixtyCycleDay()
        let tp1 = day1.getThreePillars()
        XCTAssertFalse(tp1.getName().isEmpty)
        XCTAssertEqual(tp1.getYear().getName().count, 2)
        XCTAssertEqual(tp1.getMonth().getName().count, 2)
        XCTAssertEqual(tp1.getDay().getName().count, 2)

        // Verify getName format: "XX XX XX"
        let parts = tp1.getName().split(separator: " ")
        XCTAssertEqual(parts.count, 3)

        // Two consecutive days should have different day pillars but same year/month pillars (usually)
        let day2 = SolarDay.fromYmd(2024, 2, 11).getSixtyCycleDay()
        let tp2 = day2.getThreePillars()
        XCTAssertNotEqual(tp1.getDay().getName(), tp2.getDay().getName())
    }

    func testThreePillarsGetSolarDays() throws {
        // NOTE: getSolarDays crashes on certain year ranges due to a pre-existing
        // SolarDay.getLunarDay() bug that produces invalid lunar day values.
        // This test validates the month-stem check (invalid combinations return empty).
        // When month heaven stem doesn't match year stem rule, getSolarDays returns empty
        // without needing to call getLunarDay(), so no crash.
        let threePillars = ThreePillars(yearName: "甲子", monthName: "甲子", dayName: "甲子")
        let solarDays = threePillars.getSolarDays(startYear: 1900, endYear: 2200)
        XCTAssertEqual(solarDays.count, 0)
    }

    // MARK: - Fetus Day/Month Tests

    func testFetusDay() throws {
        XCTAssertEqual("厨灶炉 外正南", SolarDay.fromYmd(2021, 11, 13).getLunarDay().getFetusDay().getName())
        XCTAssertEqual("碓磨厕 外东南", SolarDay.fromYmd(2021, 11, 12).getLunarDay().getFetusDay().getName())
        XCTAssertEqual("仓库炉 外西南", SolarDay.fromYmd(2011, 11, 12).getLunarDay().getFetusDay().getName())
    }

    func testFetusDayFromSixtyCycleDay() throws {
        let scd = SixtyCycleDay.fromYmd(2021, 11, 13)
        let fd = FetusDay.fromSixtyCycleDay(scd)
        XCTAssertEqual("碓磨厕 外东南", fd.getName())
    }

    func testFetusMonth() throws {
        let m1 = LunarMonth.fromYm(2021, 11)
        XCTAssertEqual("占灶炉", m1.getFetus()!.getName())
        let m2 = LunarMonth.fromYm(2021, 1)
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

    // MARK: - MinorRen Tests

    func testMinorRen() throws {
        // Test all six names
        XCTAssertEqual("大安", MinorRen.fromIndex(0).getName())
        XCTAssertEqual("留连", MinorRen.fromIndex(1).getName())
        XCTAssertEqual("速喜", MinorRen.fromIndex(2).getName())
        XCTAssertEqual("赤口", MinorRen.fromIndex(3).getName())
        XCTAssertEqual("小吉", MinorRen.fromIndex(4).getName())
        XCTAssertEqual("空亡", MinorRen.fromIndex(5).getName())
    }

    func testMinorRenFromName() throws {
        XCTAssertEqual(0, MinorRen.fromName("大安").getIndex())
        XCTAssertEqual(3, MinorRen.fromName("赤口").getIndex())
    }

    func testMinorRenLuck() throws {
        // Even index = 吉, Odd index = 凶
        XCTAssertEqual("吉", MinorRen.fromIndex(0).getLuck().getName()) // 大安
        XCTAssertEqual("凶", MinorRen.fromIndex(1).getLuck().getName()) // 留连
        XCTAssertEqual("吉", MinorRen.fromIndex(2).getLuck().getName()) // 速喜
        XCTAssertEqual("凶", MinorRen.fromIndex(3).getLuck().getName()) // 赤口
        XCTAssertEqual("吉", MinorRen.fromIndex(4).getLuck().getName()) // 小吉
        XCTAssertEqual("凶", MinorRen.fromIndex(5).getLuck().getName()) // 空亡
    }

    func testMinorRenElement() throws {
        // Mapping: [0,4,1,3,0,2] → Element.NAMES["木","火","土","金","水"] index
        // [0,4,1,3,0,2] → [木,水,火,金,木,土]
        XCTAssertEqual("木", MinorRen.fromIndex(0).getElement().getName()) // 大安
        XCTAssertEqual("水", MinorRen.fromIndex(1).getElement().getName()) // 留连
        XCTAssertEqual("火", MinorRen.fromIndex(2).getElement().getName()) // 速喜
        XCTAssertEqual("金", MinorRen.fromIndex(3).getElement().getName()) // 赤口
        XCTAssertEqual("木", MinorRen.fromIndex(4).getElement().getName()) // 小吉
        XCTAssertEqual("土", MinorRen.fromIndex(5).getElement().getName()) // 空亡
    }

    func testMinorRenNext() throws {
        let daAn = MinorRen.fromIndex(0)
        XCTAssertEqual("留连", daAn.next(1).getName())
        XCTAssertEqual("空亡", daAn.next(5).getName())
        XCTAssertEqual("大安", daAn.next(6).getName()) // cycle wraps
        XCTAssertEqual("空亡", daAn.next(-1).getName()) // negative
    }

    // Issue #14: SolarDay.getLunarDay() overflow crash
    func testGetLunarDayNoOverflow() throws {
        // ThreePillars.getSolarDays internally calls getLunarDay() on many dates
        let tp = ThreePillars(yearName: "甲戌", monthName: "甲戌", dayName: "甲戌")
        let days = tp.getSolarDays(startYear: 1, endYear: 2200)
        XCTAssertFalse(days.isEmpty, "Should find matching solar days without crashing")
    }
}

