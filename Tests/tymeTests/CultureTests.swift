import Testing
@testable import tyme

@Suite struct CultureTests {
    @Test func testZodiac() throws {
        // Test fromIndex
        let rat = Zodiac.fromIndex(0)
        #expect(rat.getName() == "鼠")
        #expect(rat.getIndex() == 0)

        // Test fromName
        let ox = try Zodiac.fromName("牛")
        #expect(ox.getName() == "牛")
        #expect(ox.getIndex() == 1)

        // Test next
        let tiger = rat.next(2)
        #expect(tiger.getName() == "虎")
        #expect(tiger.getIndex() == 2)

        // Test wrap around
        let pig = Zodiac.fromIndex(11)
        #expect(pig.getName() == "猪")
        let nextRat = pig.next(1)
        #expect(nextRat.getName() == "鼠")
        #expect(nextRat.getIndex() == 0)

        // Test getEarthBranch
        let ratBranch = rat.getEarthBranch()
        #expect(ratBranch.getName() == "子")
    }
    @Test func testPengZuHeavenStem() throws {
        // Test fromIndex
        let jia = PengZuHeavenStem.fromIndex(0)
        #expect(jia.getName() == "甲不开仓财物耗散")
        #expect(jia.getIndex() == 0)

        // Test fromName
        let yi = try PengZuHeavenStem.fromName("乙不栽植千株不长")
        #expect(yi.getName() == "乙不栽植千株不长")
        #expect(yi.getIndex() == 1)

        // Test next
        let bing = jia.next(2)
        #expect(bing.getName() == "丙不修灶必见灾殃")
        #expect(bing.getIndex() == 2)

        // Test wrap around
        let gui = PengZuHeavenStem.fromIndex(9)
        #expect(gui.getName() == "癸不词讼理弱敌强")
        let nextJia = gui.next(1)
        #expect(nextJia.getName() == "甲不开仓财物耗散")
        #expect(nextJia.getIndex() == 0)

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
            #expect(stem.getName() == expectedNames[i])
        }
    }
    @Test func testPengZuEarthBranch() throws {
        // Test fromIndex
        let zi = PengZuEarthBranch.fromIndex(0)
        #expect(zi.getName() == "子不问卜自惹祸殃")
        #expect(zi.getIndex() == 0)

        // Test fromName
        let chou = try PengZuEarthBranch.fromName("丑不冠带主不还乡")
        #expect(chou.getName() == "丑不冠带主不还乡")
        #expect(chou.getIndex() == 1)

        // Test next
        let yin = zi.next(2)
        #expect(yin.getName() == "寅不祭祀神鬼不尝")
        #expect(yin.getIndex() == 2)

        // Test wrap around
        let hai = PengZuEarthBranch.fromIndex(11)
        #expect(hai.getName() == "亥不嫁娶不利新郎")
        let nextZi = hai.next(1)
        #expect(nextZi.getName() == "子不问卜自惹祸殃")
        #expect(nextZi.getIndex() == 0)

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
            #expect(branch.getName() == expectedNames[i])
        }
    }
    @Test func testPengZu() throws {
        // Test with SixtyCycle 甲子
        let jiaZi = SixtyCycle.fromIndex(0)
        let pengZu1 = PengZu.fromSixtyCycle(jiaZi)
        #expect(pengZu1.getName() == "甲不开仓财物耗散 子不问卜自惹祸殃")
        #expect(pengZu1.getHeavenStemTaboo() == "甲不开仓财物耗散")
        #expect(pengZu1.getEarthBranchTaboo() == "子不问卜自惹祸殃")

        // Test with SixtyCycle 乙丑
        let yiChou = SixtyCycle.fromIndex(1)
        let pengZu2 = PengZu.fromSixtyCycle(yiChou)
        #expect(pengZu2.getName() == "乙不栽植千株不长 丑不冠带主不还乡")

        // Test getTaboos
        let taboos = pengZu1.getTaboos()
        #expect(taboos.count == 2)
        #expect(taboos[0] == "甲不开仓财物耗散")
        #expect(taboos[1] == "子不问卜自惹祸殃")

        // Test getPengZuHeavenStem and getPengZuEarthBranch
        let heavenStem = pengZu1.getPengZuHeavenStem()
        #expect(heavenStem.getIndex() == 0)
        let earthBranch = pengZu1.getPengZuEarthBranch()
        #expect(earthBranch.getIndex() == 0)

        // Test with SixtyCycle 癸亥 (index 59, last one)
        let guiHai = SixtyCycle.fromIndex(59)
        let pengZu3 = PengZu.fromSixtyCycle(guiHai)
        #expect(pengZu3.getName() == "癸不词讼理弱敌强 亥不嫁娶不利新郎")

        // Test description (CustomStringConvertible)
        #expect(String(describing: pengZu1) == "甲不开仓财物耗散 子不问卜自惹祸殃")
    }
    @Test func testLuck() throws {
        // Test fromIndex
        let ji = Luck.fromIndex(0)
        #expect(ji.getName() == "吉")
        #expect(ji.getIndex() == 0)
        #expect(ji.isAuspicious())
        #expect(!ji.isInauspicious())

        let xiong = Luck.fromIndex(1)
        #expect(xiong.getName() == "凶")
        #expect(xiong.getIndex() == 1)
        #expect(!xiong.isAuspicious())
        #expect(xiong.isInauspicious())

        // Test fromName
        let ji2 = try Luck.fromName("吉")
        #expect(ji2.getIndex() == 0)

        // Test next
        let xiong2 = ji.next(1)
        #expect(xiong2.getName() == "凶")
        let ji3 = xiong2.next(1)
        #expect(ji3.getName() == "吉")
    }
    @Test func testSevenStar() throws {
        // Test all seven stars
        let expectedNames = ["日", "月", "火", "水", "木", "金", "土"]
        for i in 0..<7 {
            let star = SevenStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.getIndex() == i)
        }

        // Test fromName
        let sun = try SevenStar.fromName("日")
        #expect(sun.getIndex() == 0)

        // Test next
        let moon = sun.next(1)
        #expect(moon.getName() == "月")

        // Test wrap around
        let saturn = SevenStar.fromIndex(6)
        let nextSun = saturn.next(1)
        #expect(nextSun.getName() == "日")

        // Test getWeek
        let sunWeek = sun.getWeek()
        #expect(sunWeek.getName() == "日")
    }
    @Test func testSixStar() throws {
        // Test all six stars
        let expectedNames = ["先胜", "友引", "先负", "佛灭", "大安", "赤口"]
        for i in 0..<6 {
            let star = SixStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.getIndex() == i)
        }

        // Test fromName
        let sensho = try SixStar.fromName("先胜")
        #expect(sensho.getIndex() == 0)

        // Test next
        let tomobiki = sensho.next(1)
        #expect(tomobiki.getName() == "友引")

        // Test wrap around
        let shakko = SixStar.fromIndex(5)
        let nextSensho = shakko.next(1)
        #expect(nextSensho.getName() == "先胜")
    }
    @Test func testTenStar() throws {
        // Test all ten stars
        let expectedNames = ["比肩", "劫财", "食神", "伤官", "偏财", "正财", "七杀", "正官", "偏印", "正印"]
        for i in 0..<10 {
            let star = TenStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.getIndex() == i)
        }

        // Test fromName
        let bijian = try TenStar.fromName("比肩")
        #expect(bijian.getIndex() == 0)

        // Test next
        let jiecai = bijian.next(1)
        #expect(jiecai.getName() == "劫财")

        // Test wrap around
        let zhengyin = TenStar.fromIndex(9)
        let nextBijian = zhengyin.next(1)
        #expect(nextBijian.getName() == "比肩")
    }
    @Test func testEcliptic() throws {
        // Test fromIndex
        let huangdao = Ecliptic.fromIndex(0)
        #expect(huangdao.getName() == "黄道")
        #expect(huangdao.getIndex() == 0)
        #expect(huangdao.isAuspicious())
        #expect(!huangdao.isInauspicious())

        let heidao = Ecliptic.fromIndex(1)
        #expect(heidao.getName() == "黑道")
        #expect(heidao.getIndex() == 1)
        #expect(!heidao.isAuspicious())
        #expect(heidao.isInauspicious())

        // Test fromName
        let huangdao2 = try Ecliptic.fromName("黄道")
        #expect(huangdao2.getIndex() == 0)

        // Test getLuck
        let luck1 = huangdao.getLuck()
        #expect(luck1.getName() == "吉")
        let luck2 = heidao.getLuck()
        #expect(luck2.getName() == "凶")

        // Test next
        let heidao2 = huangdao.next(1)
        #expect(heidao2.getName() == "黑道")
    }
    @Test func testTwelveStar() throws {
        // Test all twelve stars
        let expectedNames = ["青龙", "明堂", "天刑", "朱雀", "金匮", "天德", "白虎", "玉堂", "天牢", "玄武", "司命", "勾陈"]
        for i in 0..<12 {
            let star = TwelveStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.getIndex() == i)
        }

        // Test fromName
        let qinglong = try TwelveStar.fromName("青龙")
        #expect(qinglong.getIndex() == 0)

        // Test next
        let mingtang = qinglong.next(1)
        #expect(mingtang.getName() == "明堂")

        // Test wrap around
        let gouchen = TwelveStar.fromIndex(11)
        let nextQinglong = gouchen.next(1)
        #expect(nextQinglong.getName() == "青龙")

        // Test getEcliptic - 青龙 is 黄道
        let ecliptic1 = qinglong.getEcliptic()
        #expect(ecliptic1.getName() == "黄道")
        #expect(qinglong.isAuspicious())

        // Test getEcliptic - 天刑 is 黑道
        let tianxing = TwelveStar.fromIndex(2)
        let ecliptic2 = tianxing.getEcliptic()
        #expect(ecliptic2.getName() == "黑道")
        #expect(tianxing.isInauspicious())
    }
    @Test func testZone() throws {
        // Test all four zones
        let expectedNames = ["东", "北", "西", "南"]
        for i in 0..<4 {
            let zone = Zone.fromIndex(i)
            #expect(zone.getName() == expectedNames[i])
            #expect(zone.getIndex() == i)
        }

        // Test fromName
        let east = try Zone.fromName("东")
        #expect(east.getIndex() == 0)

        // Test next
        let north = east.next(1)
        #expect(north.getName() == "北")

        // Test wrap around
        let south = Zone.fromIndex(3)
        let nextEast = south.next(1)
        #expect(nextEast.getName() == "东")

        // Test getDirection
        let direction = east.getDirection()
        #expect(direction.getName() == "东")

        // Test getBeast
        let beast = east.getBeast()
        #expect(beast.getName() == "青龙")
    }
    @Test func testBeast() throws {
        // Test all four beasts
        let expectedNames = ["青龙", "玄武", "白虎", "朱雀"]
        for i in 0..<4 {
            let beast = Beast.fromIndex(i)
            #expect(beast.getName() == expectedNames[i])
            #expect(beast.getIndex() == i)
        }

        // Test fromName
        let qinglong = try Beast.fromName("青龙")
        #expect(qinglong.getIndex() == 0)

        // Test next
        let xuanwu = qinglong.next(1)
        #expect(xuanwu.getName() == "玄武")

        // Test wrap around
        let zhuque = Beast.fromIndex(3)
        let nextQinglong = zhuque.next(1)
        #expect(nextQinglong.getName() == "青龙")

        // Test getZone
        let zone = qinglong.getZone()
        #expect(zone.getName() == "东")
    }
    @Test func testLand() throws {
        // Test all nine lands
        let expectedNames = ["玄天", "朱天", "苍天", "阳天", "钧天", "幽天", "颢天", "变天", "炎天"]
        for i in 0..<9 {
            let land = Land.fromIndex(i)
            #expect(land.getName() == expectedNames[i])
            #expect(land.getIndex() == i)
        }

        // Test fromName
        let xuantian = try Land.fromName("玄天")
        #expect(xuantian.getIndex() == 0)

        // Test next
        let zhutian = xuantian.next(1)
        #expect(zhutian.getName() == "朱天")

        // Test wrap around
        let yantian = Land.fromIndex(8)
        let nextXuantian = yantian.next(1)
        #expect(nextXuantian.getName() == "玄天")

        // Test getDirection
        let direction = xuantian.getDirection()
        #expect(direction.getName() == "北")
    }
    @Test func testAnimal() throws {
        // Test first few animals
        let expectedNames = ["蛟", "龙", "貉", "兔", "狐", "虎", "豹"]
        for i in 0..<7 {
            let animal = Animal.fromIndex(i)
            #expect(animal.getName() == expectedNames[i])
            #expect(animal.getIndex() == i)
        }

        // Test fromName
        let jiao = try Animal.fromName("蛟")
        #expect(jiao.getIndex() == 0)

        // Test next
        let long = jiao.next(1)
        #expect(long.getName() == "龙")

        // Test wrap around (28 animals)
        let yin = Animal.fromIndex(27)
        let nextJiao = yin.next(1)
        #expect(nextJiao.getName() == "蛟")

        // Test getTwentyEightStar
        let star = jiao.getTwentyEightStar()
        #expect(star.getName() == "角")
    }
    @Test func testTwentyEightStar() throws {
        // Test first few stars
        let expectedNames = ["角", "亢", "氐", "房", "心", "尾", "箕"]
        for i in 0..<7 {
            let star = TwentyEightStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.getIndex() == i)
        }

        // Test fromName
        let jiao = try TwentyEightStar.fromName("角")
        #expect(jiao.getIndex() == 0)

        // Test next
        let kang = jiao.next(1)
        #expect(kang.getName() == "亢")

        // Test wrap around (28 stars)
        let zhen = TwentyEightStar.fromIndex(27)
        let nextJiao = zhen.next(1)
        #expect(nextJiao.getName() == "角")

        // Test getZone - first 7 stars are in East (东)
        let zone = jiao.getZone()
        #expect(zone.getName() == "东")

        // Test getZone - stars 7-13 are in North (北)
        let dou = TwentyEightStar.fromIndex(7)
        let northZone = dou.getZone()
        #expect(northZone.getName() == "北")

        // Test getAnimal
        let animal = jiao.getAnimal()
        #expect(animal.getName() == "蛟")

        // Test getLand
        let land = jiao.getLand()
        #expect(land.getName() == "钧天")

        // Test getLuck - 角 is 吉
        let luck = jiao.getLuck()
        #expect(luck.getName() == "吉")
        #expect(jiao.isAuspicious())

        // Test getLuck - 亢 is 凶
        let luck2 = kang.getLuck()
        #expect(luck2.getName() == "凶")
        #expect(kang.isInauspicious())

        // Test getSevenStar
        let sevenStar = jiao.getSevenStar()
        #expect(sevenStar.getName() == "木")
    }
    @Test func testDuty() throws {
        // Test all twelve duties
        let expectedNames = ["建", "除", "满", "平", "定", "执", "破", "危", "成", "收", "开", "闭"]
        for i in 0..<12 {
            let duty = Duty.fromIndex(i)
            #expect(duty.getName() == expectedNames[i])
            #expect(duty.getIndex() == i)
        }

        // Test fromName
        let jian = try Duty.fromName("建")
        #expect(jian.getIndex() == 0)

        // Test next
        let chu = jian.next(1)
        #expect(chu.getName() == "除")

        // Test wrap around
        let bi = Duty.fromIndex(11)
        let nextJian = bi.next(1)
        #expect(nextJian.getName() == "建")
    }
    @Test func testConstellation() throws {
        // Test all twelve constellations
        let expectedNames = ["白羊", "金牛", "双子", "巨蟹", "狮子", "处女", "天秤", "天蝎", "射手", "摩羯", "水瓶", "双鱼"]
        for i in 0..<12 {
            let constellation = Constellation.fromIndex(i)
            #expect(constellation.getName() == expectedNames[i])
            #expect(constellation.getIndex() == i)
        }

        // Test fromName
        let aries = try Constellation.fromName("白羊")
        #expect(aries.getIndex() == 0)

        // Test next
        let taurus = aries.next(1)
        #expect(taurus.getName() == "金牛")

        // Test wrap around
        let pisces = Constellation.fromIndex(11)
        let nextAries = pisces.next(1)
        #expect(nextAries.getName() == "白羊")
    }
    @Test func testSound() throws {
        // Test all five sounds
        let expectedNames = ["宫", "商", "角", "徵", "羽"]
        let expectedWuXing = ["土", "金", "木", "火", "水"]
        for i in 0..<5 {
            let sound = Sound.fromIndex(i)
            #expect(sound.getName() == expectedNames[i])
            #expect(sound.getIndex() == i)
            #expect(sound.getWuXing() == expectedWuXing[i])
        }

        // Test fromName
        let gong = try Sound.fromName("宫")
        #expect(gong.getIndex() == 0)

        // Test next
        let shang = gong.next(1)
        #expect(shang.getName() == "商")

        // Test wrap around
        let yu = Sound.fromIndex(4)
        let nextGong = yu.next(1)
        #expect(nextGong.getName() == "宫")

        // Test getElement
        let element = gong.getElement()
        #expect(element.getName() == "土")
    }
    @Test func testPhase() throws {
        // Test all three phases
        let expectedNames = ["上旬", "中旬", "下旬"]
        for i in 0..<3 {
            let phase = Phase.fromIndex(i)
            #expect(phase.getName() == expectedNames[i])
            #expect(phase.getIndex() == i)
        }

        // Test fromName
        let shangXun = try Phase.fromName("上旬")
        #expect(shangXun.getIndex() == 0)

        // Test next
        let zhongXun = shangXun.next(1)
        #expect(zhongXun.getName() == "中旬")

        // Test wrap around
        let xiaXun = Phase.fromIndex(2)
        let nextShangXun = xiaXun.next(1)
        #expect(nextShangXun.getName() == "上旬")
    }
    @Test func testPhenology() throws {
        // Test first few phenologies
        let expectedNames = ["蚯蚓结", "麋角解", "水泉动"]
        for i in 0..<3 {
            let phenology = Phenology.fromIndex(i)
            #expect(phenology.getName() == expectedNames[i])
            #expect(phenology.getIndex() == i)
        }

        // Test fromName
        let qiuYinJie = try Phenology.fromName("蚯蚓结")
        #expect(qiuYinJie.getIndex() == 0)

        // Test next
        let miJiaoJie = qiuYinJie.next(1)
        #expect(miJiaoJie.getName() == "麋角解")

        // Test wrap around (72 phenologies)
        let liTingChu = Phenology.fromIndex(71)
        let nextQiuYinJie = liTingChu.next(1)
        #expect(nextQiuYinJie.getName() == "蚯蚓结")

        // Test getThreePhenology
        let threePhenology = qiuYinJie.getThreePhenology()
        #expect(threePhenology.getName() == "初候")

        // Test getSolarTermIndex
        #expect(qiuYinJie.getSolarTermIndex() == 0)
    }
    @Test func testThreePhenology() throws {
        // Test all three phenology periods
        let expectedNames = ["初候", "二候", "三候"]
        for i in 0..<3 {
            let threePhenology = ThreePhenology.fromIndex(i)
            #expect(threePhenology.getName() == expectedNames[i])
            #expect(threePhenology.getIndex() == i)
        }

        // Test fromName
        let chuHou = try ThreePhenology.fromName("初候")
        #expect(chuHou.getIndex() == 0)

        // Test next
        let erHou = chuHou.next(1)
        #expect(erHou.getName() == "二候")

        // Test wrap around
        let sanHou = ThreePhenology.fromIndex(2)
        let nextChuHou = sanHou.next(1)
        #expect(nextChuHou.getName() == "初候")
    }
    @Test func testPhaseDay() throws {
        // Test all five phase days
        let expectedNames = ["一", "二", "三", "四", "五"]
        for i in 0..<5 {
            let phaseDay = PhaseDay.fromIndex(i)
            #expect(phaseDay.getName() == expectedNames[i])
            #expect(phaseDay.getIndex() == i)
            #expect(phaseDay.getDayNumber() == i + 1)
        }

        // Test fromName
        let yi = try PhaseDay.fromName("一")
        #expect(yi.getIndex() == 0)

        // Test next
        let er = yi.next(1)
        #expect(er.getName() == "二")

        // Test wrap around
        let wu = PhaseDay.fromIndex(4)
        let nextYi = wu.next(1)
        #expect(nextYi.getName() == "一")
    }
    @Test func testTenDay() throws {
        // Test all ten days
        let expectedNames = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
        for i in 0..<10 {
            let tenDay = TenDay.fromIndex(i)
            #expect(tenDay.getName() == expectedNames[i])
            #expect(tenDay.getIndex() == i)
        }

        // Test fromName
        let jia = try TenDay.fromName("甲")
        #expect(jia.getIndex() == 0)

        // Test next
        let yi = jia.next(1)
        #expect(yi.getName() == "乙")

        // Test wrap around
        let gui = TenDay.fromIndex(9)
        let nextJia = gui.next(1)
        #expect(nextJia.getName() == "甲")

        // Test getHeavenStem
        let heavenStem = jia.getHeavenStem()
        #expect(heavenStem.getName() == "甲")
    }
    @Test func testTerrain() throws {
        // Test all twelve terrains
        let expectedNames = ["长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎", "养"]
        for i in 0..<12 {
            let terrain = Terrain.fromIndex(i)
            #expect(terrain.getName() == expectedNames[i])
            #expect(terrain.getIndex() == i)
        }

        // Test fromName
        let changSheng = try Terrain.fromName("长生")
        #expect(changSheng.getIndex() == 0)

        // Test next
        let muYu = changSheng.next(1)
        #expect(muYu.getName() == "沐浴")

        // Test wrap around
        let yang = Terrain.fromIndex(11)
        let nextChangSheng = yang.next(1)
        #expect(nextChangSheng.getName() == "长生")

        // Test isProsperous
        #expect(changSheng.isProsperous())
        #expect(!muYu.isProsperous())

        // Test isDeclining
        let shuai = Terrain.fromIndex(5)
        #expect(shuai.isDeclining())
        #expect(!changSheng.isDeclining())

        // Test isNurturing
        #expect(muYu.isNurturing())
        #expect(!changSheng.isNurturing())
    }
    @Test func testNaYin() throws {
        // Test first few NaYin
        let expectedNames = ["海中金", "炉中火", "大林木", "路旁土", "剑锋金"]
        let expectedWuXing = ["金", "火", "木", "土", "金"]
        for i in 0..<5 {
            let naYin = NaYin.fromIndex(i)
            #expect(naYin.getName() == expectedNames[i])
            #expect(naYin.getIndex() == i)
            #expect(naYin.getWuXing() == expectedWuXing[i])
        }

        // Test fromName
        let haiZhongJin = try NaYin.fromName("海中金")
        #expect(haiZhongJin.getIndex() == 0)

        // Test next
        let luZhongHuo = haiZhongJin.next(1)
        #expect(luZhongHuo.getName() == "炉中火")

        // Test wrap around (30 NaYin)
        let daHaiShui = NaYin.fromIndex(29)
        let nextHaiZhongJin = daHaiShui.next(1)
        #expect(nextHaiZhongJin.getName() == "海中金")

        // Test fromSixtyCycle
        let naYin0 = NaYin.fromSixtyCycle(0)
        #expect(naYin0.getName() == "海中金")
        let naYin1 = NaYin.fromSixtyCycle(1)
        #expect(naYin1.getName() == "海中金")
        let naYin2 = NaYin.fromSixtyCycle(2)
        #expect(naYin2.getName() == "炉中火")

        // Test getElement
        let element = haiZhongJin.getElement()
        #expect(element.getName() == "金")
    }
    @Test func testSixty() throws {
        // Test first few Sixty
        let expectedNames = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰"]
        for i in 0..<5 {
            let sixty = Sixty.fromIndex(i)
            #expect(sixty.getName() == expectedNames[i])
            #expect(sixty.getIndex() == i)
        }

        // Test fromName
        let jiaZi = try Sixty.fromName("甲子")
        #expect(jiaZi.getIndex() == 0)

        // Test next
        let yiChou = jiaZi.next(1)
        #expect(yiChou.getName() == "乙丑")

        // Test wrap around (60 Sixty)
        let guiHai = Sixty.fromIndex(59)
        let nextJiaZi = guiHai.next(1)
        #expect(nextJiaZi.getName() == "甲子")

        // Test getSixtyCycle
        let sixtyCycle = jiaZi.getSixtyCycle()
        #expect(sixtyCycle.getName() == "甲子")

        // Test getNaYin
        let naYin = jiaZi.getNaYin()
        #expect(naYin.getName() == "海中金")

        // Test getHeavenStem
        let heavenStem = jiaZi.getHeavenStem()
        #expect(heavenStem.getName() == "甲")

        // Test getEarthBranch
        let earthBranch = jiaZi.getEarthBranch()
        #expect(earthBranch.getName() == "子")
    }
    @Test func testTen() throws {
        // Test all ten
        let expectedNames = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
        for i in 0..<10 {
            let ten = Ten.fromIndex(i)
            #expect(ten.getName() == expectedNames[i])
            #expect(ten.getIndex() == i)
            #expect(ten.getDayNumber() == i + 1)
        }

        // Test fromName
        let yi = try Ten.fromName("一")
        #expect(yi.getIndex() == 0)

        // Test next
        let er = yi.next(1)
        #expect(er.getName() == "二")

        // Test wrap around
        let shi = Ten.fromIndex(9)
        let nextYi = shi.next(1)
        #expect(nextYi.getName() == "一")
    }
    @Test func testTwenty() throws {
        // Test first few twenty
        let expectedNames = ["初一", "初二", "初三", "初四", "初五"]
        for i in 0..<5 {
            let twenty = Twenty.fromIndex(i)
            #expect(twenty.getName() == expectedNames[i])
            #expect(twenty.getIndex() == i)
            #expect(twenty.getDayNumber() == i + 1)
        }

        // Test fromName
        let chuYi = try Twenty.fromName("初一")
        #expect(chuYi.getIndex() == 0)

        // Test next
        let chuEr = chuYi.next(1)
        #expect(chuEr.getName() == "初二")

        // Test wrap around (20 Twenty)
        let erShi = Twenty.fromIndex(19)
        let nextChuYi = erShi.next(1)
        #expect(nextChuYi.getName() == "初一")
    }
    @Test func testYinYang() throws {
        // Test Yang
        let yang = YinYang.yang
        #expect(yang.name == "阳")
        #expect(yang.rawValue == 0)
        #expect(yang.isYang)
        #expect(!yang.isYin)

        // Test Yin
        let yin = YinYang.yin
        #expect(yin.name == "阴")
        #expect(yin.rawValue == 1)
        #expect(!yin.isYang)
        #expect(yin.isYin)

        // Test fromIndex
        #expect(YinYang.fromIndex(0) == .yang)
        #expect(YinYang.fromIndex(1) == .yin)
        #expect(YinYang.fromIndex(2) == .yang)
        #expect(YinYang.fromIndex(3) == .yin)

        // Test fromName
        #expect(YinYang.fromName("阳") == .yang)
        #expect(YinYang.fromName("阴") == .yin)

        // Test opposite
        #expect(yang.opposite() == .yin)
        #expect(yin.opposite() == .yang)

        // Test description
        #expect(String(describing: yang) == "阳")
        #expect(String(describing: yin) == "阴")
    }
    @Test func testGender() throws {
        // Test Male
        let male = Gender.male
        #expect(male.name == "男")
        #expect(male.rawValue == 0)
        #expect(male.isMale)
        #expect(!male.isFemale)

        // Test Female
        let female = Gender.female
        #expect(female.name == "女")
        #expect(female.rawValue == 1)
        #expect(!female.isMale)
        #expect(female.isFemale)

        // Test fromIndex
        #expect(Gender.fromIndex(0) == .male)
        #expect(Gender.fromIndex(1) == .female)
        #expect(Gender.fromIndex(2) == .male)

        // Test fromName
        #expect(Gender.fromName("男") == .male)
        #expect(Gender.fromName("女") == .female)

        // Test description
        #expect(String(describing: male) == "男")
        #expect(String(describing: female) == "女")
    }
    @Test func testSide() throws {
        // Test Inner
        let inner = Side.inner
        #expect(inner.name == "内")
        #expect(inner.rawValue == 0)
        #expect(inner.isInner)
        #expect(!inner.isOuter)

        // Test Outer
        let outer = Side.outer
        #expect(outer.name == "外")
        #expect(outer.rawValue == 1)
        #expect(!outer.isInner)
        #expect(outer.isOuter)

        // Test fromIndex
        #expect(Side.fromIndex(0) == .inner)
        #expect(Side.fromIndex(1) == .outer)
        #expect(Side.fromIndex(2) == .inner)

        // Test fromName
        #expect(Side.fromName("内") == .inner)
        #expect(Side.fromName("外") == .outer)

        // Test description
        #expect(String(describing: inner) == "内")
        #expect(String(describing: outer) == "外")
    }
    @Test func testFestivalType() throws {
        // Test Day
        let day = FestivalType.day
        #expect(day.name == "日期")
        #expect(day.rawValue == 0)

        // Test Term
        let term = FestivalType.term
        #expect(term.name == "节气")
        #expect(term.rawValue == 1)

        // Test Eve
        let eve = FestivalType.eve
        #expect(eve.name == "除夕")
        #expect(eve.rawValue == 2)

        // Test fromIndex
        #expect(FestivalType.fromIndex(0) == .day)
        #expect(FestivalType.fromIndex(1) == .term)
        #expect(FestivalType.fromIndex(2) == .eve)
        #expect(FestivalType.fromIndex(3) == .day)

        // Test fromName
        #expect(FestivalType.fromName("日期") == .day)
        #expect(FestivalType.fromName("节气") == .term)
        #expect(FestivalType.fromName("除夕") == .eve)

        // Test description
        #expect(String(describing: day) == "日期")
    }
    @Test func testDog() throws {
        // Test all three dog periods
        let expectedNames = ["初伏", "中伏", "末伏"]
        for i in 0..<3 {
            let dog = Dog.fromIndex(i)
            #expect(dog.getName() == expectedNames[i])
            #expect(dog.getIndex() == i)
        }

        // Test fromName
        let chuFu = try Dog.fromName("初伏")
        #expect(chuFu.getIndex() == 0)

        // Test next
        let zhongFu = chuFu.next(1)
        #expect(zhongFu.getName() == "中伏")

        // Test wrap around
        let moFu = Dog.fromIndex(2)
        let nextChuFu = moFu.next(1)
        #expect(nextChuFu.getName() == "初伏")
    }
    @Test func testDogDay() throws {
        let dog = Dog.fromIndex(0)
        let dogDay = DogDay.fromDog(dog, 0)
        #expect(dogDay.getDog().getName() == "初伏")
        #expect(dogDay.getDayIndex() == 0)
        #expect(dogDay.getName() == "初伏第1天")

        let dogDay2 = DogDay.fromDog(dog, 4)
        #expect(dogDay2.getName() == "初伏第5天")
    }
    @Test func testNine() throws {
        // Test all nine periods
        let expectedNames = ["一九", "二九", "三九", "四九", "五九", "六九", "七九", "八九", "九九"]
        for i in 0..<9 {
            let nine = Nine.fromIndex(i)
            #expect(nine.getName() == expectedNames[i])
            #expect(nine.getIndex() == i)
        }

        // Test fromName
        let yiJiu = try Nine.fromName("一九")
        #expect(yiJiu.getIndex() == 0)

        // Test next
        let erJiu = yiJiu.next(1)
        #expect(erJiu.getName() == "二九")

        // Test wrap around
        let jiuJiu = Nine.fromIndex(8)
        let nextYiJiu = jiuJiu.next(1)
        #expect(nextYiJiu.getName() == "一九")
    }
    @Test func testNineColdDay() throws {
        let nine = Nine.fromIndex(0)
        let nineDay = NineColdDay.fromNine(nine, 0)
        #expect(nineDay.getNine().getName() == "一九")
        #expect(nineDay.getDayIndex() == 0)
        #expect(nineDay.getName() == "一九第1天")

        let nineDay2 = NineColdDay.fromNine(nine, 8)
        #expect(nineDay2.getName() == "一九第9天")
    }
    @Test func testPlumRain() throws {
        // Test both plum rain periods
        let ruMei = PlumRain.fromIndex(0)
        #expect(ruMei.getName() == "入梅")
        #expect(ruMei.isEntering())
        #expect(!ruMei.isExiting())

        let chuMei = PlumRain.fromIndex(1)
        #expect(chuMei.getName() == "出梅")
        #expect(!chuMei.isEntering())
        #expect(chuMei.isExiting())

        // Test next
        let next = ruMei.next(1)
        #expect(next.getName() == "出梅")
    }
    @Test func testPlumRainDay() throws {
        let plumRain = PlumRain.fromIndex(0)
        let plumRainDay = PlumRainDay.fromPlumRain(plumRain, 0)
        #expect(plumRainDay.getPlumRain().getName() == "入梅")
        #expect(plumRainDay.getDayIndex() == 0)
        #expect(plumRainDay.getName() == "入梅第1天")
    }
    @Test func testTaboo() throws {
        // Test auspicious taboo
        let auspicious = Taboo.auspicious("祭祀")
        #expect(auspicious.getName() == "祭祀")
        #expect(auspicious.isAuspicious())
        #expect(!auspicious.isInauspicious())

        // Test inauspicious taboo
        let inauspicious = Taboo.inauspicious("动土")
        #expect(inauspicious.getName() == "动土")
        #expect(!inauspicious.isAuspicious())
        #expect(inauspicious.isInauspicious())
    }
    @Test func testMinorRen() throws {
        // Test all six names
        #expect("大安" == MinorRen.fromIndex(0).getName())
        #expect("留连" == MinorRen.fromIndex(1).getName())
        #expect("速喜" == MinorRen.fromIndex(2).getName())
        #expect("赤口" == MinorRen.fromIndex(3).getName())
        #expect("小吉" == MinorRen.fromIndex(4).getName())
        #expect("空亡" == MinorRen.fromIndex(5).getName())
    }
    @Test func testMinorRenFromName() throws {
        #expect(0 == (try MinorRen.fromName("大安").getIndex()))
        #expect(3 == (try MinorRen.fromName("赤口").getIndex()))
    }
    @Test func testMinorRenLuck() throws {
        // Even index = 吉, Odd index = 凶
        #expect("吉" == MinorRen.fromIndex(0).getLuck().getName()) // 大安
        #expect("凶" == MinorRen.fromIndex(1).getLuck().getName()) // 留连
        #expect("吉" == MinorRen.fromIndex(2).getLuck().getName()) // 速喜
        #expect("凶" == MinorRen.fromIndex(3).getLuck().getName()) // 赤口
        #expect("吉" == MinorRen.fromIndex(4).getLuck().getName()) // 小吉
        #expect("凶" == MinorRen.fromIndex(5).getLuck().getName()) // 空亡
    }
    @Test func testMinorRenElement() throws {
        // Mapping: [0,4,1,3,0,2] → Element.NAMES["木","火","土","金","水"] index
        // [0,4,1,3,0,2] → [木,水,火,金,木,土]
        #expect("木" == MinorRen.fromIndex(0).getElement().getName()) // 大安
        #expect("水" == MinorRen.fromIndex(1).getElement().getName()) // 留连
        #expect("火" == MinorRen.fromIndex(2).getElement().getName()) // 速喜
        #expect("金" == MinorRen.fromIndex(3).getElement().getName()) // 赤口
        #expect("木" == MinorRen.fromIndex(4).getElement().getName()) // 小吉
        #expect("土" == MinorRen.fromIndex(5).getElement().getName()) // 空亡
    }
    @Test func testMinorRenNext() throws {
        let daAn = MinorRen.fromIndex(0)
        #expect("留连" == daAn.next(1).getName())
        #expect("空亡" == daAn.next(5).getName())
        #expect("大安" == daAn.next(6).getName()) // cycle wraps
        #expect("空亡" == daAn.next(-1).getName()) // negative
    }
    @Test func testElementFromName() throws {
        #expect("木" == (try Element.fromName("木").getName()))
        #expect("金" == (try Element.fromName("金").getName()))
        #expect("水" == (try Element.fromName("水").getName()))
    }
    @Test func testElementCycle() throws {
        let wood = try Element.fromName("木")
        #expect("火" == wood.next(1).getName())
        #expect("土" == wood.next(2).getName())
        #expect("金" == wood.next(3).getName())
        #expect("水" == wood.next(4).getName())
        #expect("木" == wood.next(5).getName())
    }
    @Test func testElementYinYang() throws {
        // 木=阳, 火=阴, 土=阳, 金=阴, 水=阳
        #expect("阳" == Element.fromIndex(0).getYinYang()) // 木
        #expect("阴" == Element.fromIndex(1).getYinYang()) // 火
        #expect("阳" == Element.fromIndex(2).getYinYang()) // 土
        #expect("阴" == Element.fromIndex(3).getYinYang()) // 金
        #expect("阳" == Element.fromIndex(4).getYinYang()) // 水
    }
    @Test func testPhenologyDay() {
        let p = Phenology.fromIndex(0)
        let day = PhenologyDay(phenology: p, dayIndex: 2)
        #expect(day.getPhenology().getName() == "蚯蚓结")
        #expect(day.getDayIndex() == 2)
        #expect(day.getName() == "蚯蚓结")
        #expect(day.description == "蚯蚓结第3天")
    }
    @Test func testRabByungElement() throws {
        let e = try RabByungElement(index: 3) // 金→铁
        #expect(e.getName() == "铁")
        #expect(e.getIndex() == 3)
        #expect(e.getReinforce().getName() == "水")  // 铁生水
        #expect(e.getRestrain().getName() == "木")   // 铁克木
        #expect(e.getReinforced().getName() == "土") // 土生铁
        #expect(e.getRestrained().getName() == "火") // 火克铁

        let e2 = try RabByungElement.fromName("铁")
        #expect(e2.getIndex() == 3)
        #expect(e2.getName() == "铁")

        // Test cycle
        let wood = try RabByungElement.fromName("木")
        #expect(wood.next(1).getName() == "火")
        #expect(wood.next(2).getName() == "土")
        #expect(wood.next(3).getName() == "铁")
        #expect(wood.next(4).getName() == "水")
        #expect(wood.next(5).getName() == "木")
    }
}
