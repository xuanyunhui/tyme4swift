import XCTest
@testable import tyme

final class CultureTests: XCTestCase {
    func testZodiac() throws {
        // Test fromIndex
        let rat = Zodiac.fromIndex(0)
        XCTAssertEqual(rat.getName(), "鼠")
        XCTAssertEqual(rat.getIndex(), 0)
        
        // Test fromName
        let ox = try Zodiac.fromName("牛")
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
    func testPengZuHeavenStem() throws {
        // Test fromIndex
        let jia = PengZuHeavenStem.fromIndex(0)
        XCTAssertEqual(jia.getName(), "甲不开仓财物耗散")
        XCTAssertEqual(jia.getIndex(), 0)

        // Test fromName
        let yi = try PengZuHeavenStem.fromName("乙不栽植千株不长")
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
        let chou = try PengZuEarthBranch.fromName("丑不冠带主不还乡")
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
        let ji2 = try Luck.fromName("吉")
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
        let sun = try SevenStar.fromName("日")
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
        let sensho = try SixStar.fromName("先胜")
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
        let bijian = try TenStar.fromName("比肩")
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
        let huangdao2 = try Ecliptic.fromName("黄道")
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
        let qinglong = try TwelveStar.fromName("青龙")
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
        let east = try Zone.fromName("东")
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
        let qinglong = try Beast.fromName("青龙")
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
        let xuantian = try Land.fromName("玄天")
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
        let jiao = try Animal.fromName("蛟")
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
        let jiao = try TwentyEightStar.fromName("角")
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
        let jian = try Duty.fromName("建")
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
        let aries = try Constellation.fromName("白羊")
        XCTAssertEqual(aries.getIndex(), 0)

        // Test next
        let taurus = aries.next(1)
        XCTAssertEqual(taurus.getName(), "金牛")

        // Test wrap around
        let pisces = Constellation.fromIndex(11)
        let nextAries = pisces.next(1)
        XCTAssertEqual(nextAries.getName(), "白羊")
    }
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
        let gong = try Sound.fromName("宫")
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
        let shangXun = try Phase.fromName("上旬")
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
        let qiuYinJie = try Phenology.fromName("蚯蚓结")
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
        let chuHou = try ThreePhenology.fromName("初候")
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
        let yi = try PhaseDay.fromName("一")
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
        let jia = try TenDay.fromName("甲")
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
        let changSheng = try Terrain.fromName("长生")
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
        let haiZhongJin = try NaYin.fromName("海中金")
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
        let jiaZi = try Sixty.fromName("甲子")
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
        let yi = try Ten.fromName("一")
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
        let chuYi = try Twenty.fromName("初一")
        XCTAssertEqual(chuYi.getIndex(), 0)

        // Test next
        let chuEr = chuYi.next(1)
        XCTAssertEqual(chuEr.getName(), "初二")

        // Test wrap around (20 Twenty)
        let erShi = Twenty.fromIndex(19)
        let nextChuYi = erShi.next(1)
        XCTAssertEqual(nextChuYi.getName(), "初一")
    }
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
    func testDog() throws {
        // Test all three dog periods
        let expectedNames = ["初伏", "中伏", "末伏"]
        for i in 0..<3 {
            let dog = Dog.fromIndex(i)
            XCTAssertEqual(dog.getName(), expectedNames[i])
            XCTAssertEqual(dog.getIndex(), i)
        }

        // Test fromName
        let chuFu = try Dog.fromName("初伏")
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
        let yiJiu = try Nine.fromName("一九")
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
        XCTAssertEqual(0, try MinorRen.fromName("大安").getIndex())
        XCTAssertEqual(3, try MinorRen.fromName("赤口").getIndex())
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
    func testElementFromName() throws {
        XCTAssertEqual("木", try Element.fromName("木").getName())
        XCTAssertEqual("金", try Element.fromName("金").getName())
        XCTAssertEqual("水", try Element.fromName("水").getName())
    }
    func testElementCycle() throws {
        let wood = try Element.fromName("木")
        XCTAssertEqual("火", wood.next(1).getName())
        XCTAssertEqual("土", wood.next(2).getName())
        XCTAssertEqual("金", wood.next(3).getName())
        XCTAssertEqual("水", wood.next(4).getName())
        XCTAssertEqual("木", wood.next(5).getName())
    }
    func testElementYinYang() throws {
        // 木=阳, 火=阴, 土=阳, 金=阴, 水=阳
        XCTAssertEqual("阳", Element.fromIndex(0).getYinYang()) // 木
        XCTAssertEqual("阴", Element.fromIndex(1).getYinYang()) // 火
        XCTAssertEqual("阳", Element.fromIndex(2).getYinYang()) // 土
        XCTAssertEqual("阴", Element.fromIndex(3).getYinYang()) // 金
        XCTAssertEqual("阳", Element.fromIndex(4).getYinYang()) // 水
    }
    func testPhenologyDay() {
        let p = Phenology.fromIndex(0)
        let day = PhenologyDay(phenology: p, dayIndex: 2)
        XCTAssertEqual(day.getPhenology().getName(), "蚯蚓结")
        XCTAssertEqual(day.getDayIndex(), 2)
        XCTAssertEqual(day.getName(), "蚯蚓结")
        XCTAssertEqual(day.description, "蚯蚓结第3天")
    }
    func testRabByungElement() throws {
        let e = try RabByungElement(index: 3) // 金→铁
        XCTAssertEqual(e.getName(), "铁")
        XCTAssertEqual(e.getIndex(), 3)
        XCTAssertEqual(e.getReinforce().getName(), "水")  // 铁生水
        XCTAssertEqual(e.getRestrain().getName(), "木")   // 铁克木
        XCTAssertEqual(e.getReinforced().getName(), "土") // 土生铁
        XCTAssertEqual(e.getRestrained().getName(), "火") // 火克铁

        let e2 = try RabByungElement.fromName("铁")
        XCTAssertEqual(e2.getIndex(), 3)
        XCTAssertEqual(e2.getName(), "铁")

        // Test cycle
        let wood = try RabByungElement.fromName("木")
        XCTAssertEqual(wood.next(1).getName(), "火")
        XCTAssertEqual(wood.next(2).getName(), "土")
        XCTAssertEqual(wood.next(3).getName(), "铁")
        XCTAssertEqual(wood.next(4).getName(), "水")
        XCTAssertEqual(wood.next(5).getName(), "木")
    }
}
