import Testing
@testable import tyme

@Suite struct CultureTests {
    @Test func testZodiac() throws {
        // Test fromIndex
        let rat = Zodiac.fromIndex(0)
        #expect(rat.getName() == "鼠")
        #expect(rat.index == 0)

        // Test fromName
        let ox = try Zodiac.fromName("牛")
        #expect(ox.getName() == "牛")
        #expect(ox.index == 1)

        // Test next
        let tiger = rat.next(2)
        #expect(tiger.getName() == "虎")
        #expect(tiger.index == 2)

        // Test wrap around
        let pig = Zodiac.fromIndex(11)
        #expect(pig.getName() == "猪")
        let nextRat = pig.next(1)
        #expect(nextRat.getName() == "鼠")
        #expect(nextRat.index == 0)

        // Test earthBranch
        let ratBranch = rat.earthBranch
        #expect(ratBranch.getName() == "子")
    }
    @Test func testPengZuHeavenStem() throws {
        // Test fromIndex
        let jia = PengZuHeavenStem.fromIndex(0)
        #expect(jia.getName() == "甲不开仓财物耗散")
        #expect(jia.index == 0)

        // Test fromName
        let yi = try PengZuHeavenStem.fromName("乙不栽植千株不长")
        #expect(yi.getName() == "乙不栽植千株不长")
        #expect(yi.index == 1)

        // Test next
        let bing = jia.next(2)
        #expect(bing.getName() == "丙不修灶必见灾殃")
        #expect(bing.index == 2)

        // Test wrap around
        let gui = PengZuHeavenStem.fromIndex(9)
        #expect(gui.getName() == "癸不词讼理弱敌强")
        let nextJia = gui.next(1)
        #expect(nextJia.getName() == "甲不开仓财物耗散")
        #expect(nextJia.index == 0)

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
        #expect(zi.index == 0)

        // Test fromName
        let chou = try PengZuEarthBranch.fromName("丑不冠带主不还乡")
        #expect(chou.getName() == "丑不冠带主不还乡")
        #expect(chou.index == 1)

        // Test next
        let yin = zi.next(2)
        #expect(yin.getName() == "寅不祭祀神鬼不尝")
        #expect(yin.index == 2)

        // Test wrap around
        let hai = PengZuEarthBranch.fromIndex(11)
        #expect(hai.getName() == "亥不嫁娶不利新郎")
        let nextZi = hai.next(1)
        #expect(nextZi.getName() == "子不问卜自惹祸殃")
        #expect(nextZi.index == 0)

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
        #expect(pengZu1.heavenStemTaboo == "甲不开仓财物耗散")
        #expect(pengZu1.earthBranchTaboo == "子不问卜自惹祸殃")

        // Test with SixtyCycle 乙丑
        let yiChou = SixtyCycle.fromIndex(1)
        let pengZu2 = PengZu.fromSixtyCycle(yiChou)
        #expect(pengZu2.getName() == "乙不栽植千株不长 丑不冠带主不还乡")

        // Test taboos
        let taboos = pengZu1.taboos
        #expect(taboos.count == 2)
        #expect(taboos[0] == "甲不开仓财物耗散")
        #expect(taboos[1] == "子不问卜自惹祸殃")

        // Test pengZuHeavenStem and pengZuEarthBranch
        let heavenStem = pengZu1.pengZuHeavenStem
        #expect(heavenStem.index == 0)
        let earthBranch = pengZu1.pengZuEarthBranch
        #expect(earthBranch.index == 0)

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
        #expect(ji.index == 0)
        #expect(ji.auspicious)
        #expect(!ji.inauspicious)

        let xiong = Luck.fromIndex(1)
        #expect(xiong.getName() == "凶")
        #expect(xiong.index == 1)
        #expect(!xiong.auspicious)
        #expect(xiong.inauspicious)

        // Test fromName
        let ji2 = try Luck.fromName("吉")
        #expect(ji2.index == 0)

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
            #expect(star.index == i)
        }

        // Test fromName
        let sun = try SevenStar.fromName("日")
        #expect(sun.index == 0)

        // Test next
        let moon = sun.next(1)
        #expect(moon.getName() == "月")

        // Test wrap around
        let saturn = SevenStar.fromIndex(6)
        let nextSun = saturn.next(1)
        #expect(nextSun.getName() == "日")

        // Test week
        let sunWeek = sun.week
        #expect(sunWeek.getName() == "日")
    }
    @Test func testSixStar() throws {
        // Test all six stars
        let expectedNames = ["先胜", "友引", "先负", "佛灭", "大安", "赤口"]
        for i in 0..<6 {
            let star = SixStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.index == i)
        }

        // Test fromName
        let sensho = try SixStar.fromName("先胜")
        #expect(sensho.index == 0)

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
            #expect(star.index == i)
        }

        // Test fromName
        let bijian = try TenStar.fromName("比肩")
        #expect(bijian.index == 0)

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
        #expect(huangdao.index == 0)
        #expect(huangdao.auspicious)
        #expect(!huangdao.inauspicious)

        let heidao = Ecliptic.fromIndex(1)
        #expect(heidao.getName() == "黑道")
        #expect(heidao.index == 1)
        #expect(!heidao.auspicious)
        #expect(heidao.inauspicious)

        // Test fromName
        let huangdao2 = try Ecliptic.fromName("黄道")
        #expect(huangdao2.index == 0)

        // Test luck
        let luck1 = huangdao.luck
        #expect(luck1.getName() == "吉")
        let luck2 = heidao.luck
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
            #expect(star.index == i)
        }

        // Test fromName
        let qinglong = try TwelveStar.fromName("青龙")
        #expect(qinglong.index == 0)

        // Test next
        let mingtang = qinglong.next(1)
        #expect(mingtang.getName() == "明堂")

        // Test wrap around
        let gouchen = TwelveStar.fromIndex(11)
        let nextQinglong = gouchen.next(1)
        #expect(nextQinglong.getName() == "青龙")

        // Test ecliptic - 青龙 is 黄道
        let ecliptic1 = qinglong.ecliptic
        #expect(ecliptic1.getName() == "黄道")
        #expect(qinglong.auspicious)

        // Test ecliptic - 天刑 is 黑道
        let tianxing = TwelveStar.fromIndex(2)
        let ecliptic2 = tianxing.ecliptic
        #expect(ecliptic2.getName() == "黑道")
        #expect(tianxing.inauspicious)
    }
    @Test func testZone() throws {
        // Test all four zones
        let expectedNames = ["东", "北", "西", "南"]
        for i in 0..<4 {
            let zone = Zone.fromIndex(i)
            #expect(zone.getName() == expectedNames[i])
            #expect(zone.index == i)
        }

        // Test fromName
        let east = try Zone.fromName("东")
        #expect(east.index == 0)

        // Test next
        let north = east.next(1)
        #expect(north.getName() == "北")

        // Test wrap around
        let south = Zone.fromIndex(3)
        let nextEast = south.next(1)
        #expect(nextEast.getName() == "东")

        // Test direction
        let direction = east.direction
        #expect(direction.getName() == "东")

        // Test beast
        let beast = east.beast
        #expect(beast.getName() == "青龙")
    }
    @Test func testBeast() throws {
        // Test all four beasts
        let expectedNames = ["青龙", "玄武", "白虎", "朱雀"]
        for i in 0..<4 {
            let beast = Beast.fromIndex(i)
            #expect(beast.getName() == expectedNames[i])
            #expect(beast.index == i)
        }

        // Test fromName
        let qinglong = try Beast.fromName("青龙")
        #expect(qinglong.index == 0)

        // Test next
        let xuanwu = qinglong.next(1)
        #expect(xuanwu.getName() == "玄武")

        // Test wrap around
        let zhuque = Beast.fromIndex(3)
        let nextQinglong = zhuque.next(1)
        #expect(nextQinglong.getName() == "青龙")

        // Test zone
        let zone = qinglong.zone
        #expect(zone.getName() == "东")
    }
    @Test func testLand() throws {
        // Test all nine lands
        let expectedNames = ["玄天", "朱天", "苍天", "阳天", "钧天", "幽天", "颢天", "变天", "炎天"]
        for i in 0..<9 {
            let land = Land.fromIndex(i)
            #expect(land.getName() == expectedNames[i])
            #expect(land.index == i)
        }

        // Test fromName
        let xuantian = try Land.fromName("玄天")
        #expect(xuantian.index == 0)

        // Test next
        let zhutian = xuantian.next(1)
        #expect(zhutian.getName() == "朱天")

        // Test wrap around
        let yantian = Land.fromIndex(8)
        let nextXuantian = yantian.next(1)
        #expect(nextXuantian.getName() == "玄天")

        // Test direction
        let direction = xuantian.direction
        #expect(direction.getName() == "北")
    }
    @Test func testAnimal() throws {
        // Test first few animals
        let expectedNames = ["蛟", "龙", "貉", "兔", "狐", "虎", "豹"]
        for i in 0..<7 {
            let animal = Animal.fromIndex(i)
            #expect(animal.getName() == expectedNames[i])
            #expect(animal.index == i)
        }

        // Test fromName
        let jiao = try Animal.fromName("蛟")
        #expect(jiao.index == 0)

        // Test next
        let long = jiao.next(1)
        #expect(long.getName() == "龙")

        // Test wrap around (28 animals)
        let yin = Animal.fromIndex(27)
        let nextJiao = yin.next(1)
        #expect(nextJiao.getName() == "蛟")

        // Test twentyEightStar
        let star = jiao.twentyEightStar
        #expect(star.getName() == "角")
    }
    @Test func testTwentyEightStar() throws {
        // Test first few stars
        let expectedNames = ["角", "亢", "氐", "房", "心", "尾", "箕"]
        for i in 0..<7 {
            let star = TwentyEightStar.fromIndex(i)
            #expect(star.getName() == expectedNames[i])
            #expect(star.index == i)
        }

        // Test fromName
        let jiao = try TwentyEightStar.fromName("角")
        #expect(jiao.index == 0)

        // Test next
        let kang = jiao.next(1)
        #expect(kang.getName() == "亢")

        // Test wrap around (28 stars)
        let zhen = TwentyEightStar.fromIndex(27)
        let nextJiao = zhen.next(1)
        #expect(nextJiao.getName() == "角")

        // Test zone - first 7 stars are in East (东)
        let zone = jiao.zone
        #expect(zone.getName() == "东")

        // Test zone - stars 7-13 are in North (北)
        let dou = TwentyEightStar.fromIndex(7)
        let northZone = dou.zone
        #expect(northZone.getName() == "北")

        // Test animal
        let animal = jiao.animal
        #expect(animal.getName() == "蛟")

        // Test land
        let land = jiao.land
        #expect(land.getName() == "钧天")

        // Test luck - 角 is 吉
        let luck = jiao.luck
        #expect(luck.getName() == "吉")
        #expect(jiao.auspicious)

        // Test luck - 亢 is 凶
        let luck2 = kang.luck
        #expect(luck2.getName() == "凶")
        #expect(kang.inauspicious)

        // Test sevenStar
        let sevenStar = jiao.sevenStar
        #expect(sevenStar.getName() == "木")
    }
    @Test func testDuty() throws {
        // Test all twelve duties
        let expectedNames = ["建", "除", "满", "平", "定", "执", "破", "危", "成", "收", "开", "闭"]
        for i in 0..<12 {
            let duty = Duty.fromIndex(i)
            #expect(duty.getName() == expectedNames[i])
            #expect(duty.index == i)
        }

        // Test fromName
        let jian = try Duty.fromName("建")
        #expect(jian.index == 0)

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
            #expect(constellation.index == i)
        }

        // Test fromName
        let aries = try Constellation.fromName("白羊")
        #expect(aries.index == 0)

        // Test next
        let taurus = aries.next(1)
        #expect(taurus.getName() == "金牛")

        // Test wrap around
        let pisces = Constellation.fromIndex(11)
        let nextAries = pisces.next(1)
        #expect(nextAries.getName() == "白羊")
    }
    @Test func testSound() throws {
        // Test first few NaYin sounds (纳音, 30 sounds)
        let expectedNames = ["海中金", "炉中火", "大林木", "路旁土", "剑锋金"]
        let expectedWuXing = ["金", "火", "木", "土", "金"]
        for i in 0..<5 {
            let sound = Sound.fromIndex(i)
            #expect(sound.getName() == expectedNames[i])
            #expect(sound.index == i)
            #expect(sound.wuXing == expectedWuXing[i])
        }

        // Test fromName
        let haiZhongJin = try Sound.fromName("海中金")
        #expect(haiZhongJin.index == 0)

        // Test next
        let luZhongHuo = haiZhongJin.next(1)
        #expect(luZhongHuo.getName() == "炉中火")

        // Test wrap around (30 Sound)
        let daHaiShui = Sound.fromIndex(29)
        let nextHaiZhongJin = daHaiShui.next(1)
        #expect(nextHaiZhongJin.getName() == "海中金")

        // Test element
        let element = haiZhongJin.element
        #expect(element.getName() == "金")
    }
    @Test func testPhase() throws {
        // Test all eight lunar phases
        let expectedNames = ["新月", "蛾眉月", "上弦月", "盈凸月", "满月", "亏凸月", "下弦月", "残月"]
        for i in 0..<8 {
            let phase = Phase.fromIndex(2024, 1, i)
            #expect(phase.getName() == expectedNames[i])
            #expect(phase.index == i)
        }

        // Test fromName
        let xinYue = try Phase.fromName(2024, 1, "新月")
        #expect(xinYue.index == 0)

        // Test next
        let eMeiYue = xinYue.next(1)
        #expect(eMeiYue.getName() == "蛾眉月")

        // Test wrap around
        let canYue = Phase.fromIndex(2024, 1, 7)
        let nextXinYue = canYue.next(1)
        #expect(nextXinYue.getName() == "新月")
    }
    @Test func testPhenology() throws {
        // Test first few phenologies
        let expectedNames = ["蚯蚓结", "麋角解", "水泉动"]
        for i in 0..<3 {
            let phenology = Phenology.fromIndex(i)
            #expect(phenology.getName() == expectedNames[i])
            #expect(phenology.index == i)
        }

        // Test fromName
        let qiuYinJie = try Phenology.fromName("蚯蚓结")
        #expect(qiuYinJie.index == 0)

        // Test next
        let miJiaoJie = qiuYinJie.next(1)
        #expect(miJiaoJie.getName() == "麋角解")

        // Test wrap around (72 phenologies)
        let liTingChu = Phenology.fromIndex(71)
        let nextQiuYinJie = liTingChu.next(1)
        #expect(nextQiuYinJie.getName() == "蚯蚓结")

        // Test threePhenology
        let threePhenology = qiuYinJie.threePhenology
        #expect(threePhenology.getName() == "初候")

        // Test solarTermIndex
        #expect(qiuYinJie.solarTermIndex == 0)
    }
    @Test func testThreePhenology() throws {
        // Test all three phenology periods
        let expectedNames = ["初候", "二候", "三候"]
        for i in 0..<3 {
            let threePhenology = ThreePhenology.fromIndex(i)
            #expect(threePhenology.getName() == expectedNames[i])
            #expect(threePhenology.index == i)
        }

        // Test fromName
        let chuHou = try ThreePhenology.fromName("初候")
        #expect(chuHou.index == 0)

        // Test next
        let erHou = chuHou.next(1)
        #expect(erHou.getName() == "二候")

        // Test wrap around
        let sanHou = ThreePhenology.fromIndex(2)
        let nextChuHou = sanHou.next(1)
        #expect(nextChuHou.getName() == "初候")
    }
    @Test func testPhaseDay() throws {
        // Test PhaseDay with AbstractCultureDay pattern
        let phase = Phase.fromIndex(2024, 1, 0)
        let phaseDay = PhaseDay(phase: phase, dayIndex: 0)
        #expect(phaseDay.phase.getName() == "新月")
        #expect(phaseDay.dayIndex == 0)

        let phaseDay2 = PhaseDay(phase: phase, dayIndex: 3)
        #expect(phaseDay2.dayIndex == 3)
    }
    @Test func testTenDay() throws {
        // Test all ten days
        let expectedNames = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
        for i in 0..<10 {
            let tenDay = TenDay.fromIndex(i)
            #expect(tenDay.getName() == expectedNames[i])
            #expect(tenDay.index == i)
        }

        // Test fromName
        let jia = try TenDay.fromName("甲")
        #expect(jia.index == 0)

        // Test next
        let yi = jia.next(1)
        #expect(yi.getName() == "乙")

        // Test wrap around
        let gui = TenDay.fromIndex(9)
        let nextJia = gui.next(1)
        #expect(nextJia.getName() == "甲")

        // Test heavenStem
        let heavenStem = jia.heavenStem
        #expect(heavenStem.getName() == "甲")
    }
    @Test func testTerrain() throws {
        // Test all twelve terrains
        let expectedNames = ["长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎", "养"]
        for i in 0..<12 {
            let terrain = Terrain.fromIndex(i)
            #expect(terrain.getName() == expectedNames[i])
            #expect(terrain.index == i)
        }

        // Test fromName
        let changSheng = try Terrain.fromName("长生")
        #expect(changSheng.index == 0)

        // Test next
        let muYu = changSheng.next(1)
        #expect(muYu.getName() == "沐浴")

        // Test wrap around
        let yang = Terrain.fromIndex(11)
        let nextChangSheng = yang.next(1)
        #expect(nextChangSheng.getName() == "长生")

        // Test prosperous
        #expect(changSheng.prosperous)
        #expect(!muYu.prosperous)

        // Test declining
        let shuai = Terrain.fromIndex(5)
        #expect(shuai.declining)
        #expect(!changSheng.declining)

        // Test nurturing
        #expect(muYu.nurturing)
        #expect(!changSheng.nurturing)
    }
    @Test func testNaYin() throws {
        // Test first few NaYin
        let expectedNames = ["海中金", "炉中火", "大林木", "路旁土", "剑锋金"]
        let expectedWuXing = ["金", "火", "木", "土", "金"]
        for i in 0..<5 {
            let naYin = NaYin.fromIndex(i)
            #expect(naYin.getName() == expectedNames[i])
            #expect(naYin.index == i)
            #expect(naYin.wuXing == expectedWuXing[i])
        }

        // Test fromName
        let haiZhongJin = try NaYin.fromName("海中金")
        #expect(haiZhongJin.index == 0)

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

        // Test element
        let element = haiZhongJin.element
        #expect(element.getName() == "金")
    }
    @Test func testSixty() throws {
        // Test all three Yuan (三元)
        let expectedNames = ["上元", "中元", "下元"]
        for i in 0..<3 {
            let sixty = Sixty.fromIndex(i)
            #expect(sixty.getName() == expectedNames[i])
            #expect(sixty.index == i)
        }

        // Test fromName
        let shangYuan = try Sixty.fromName("上元")
        #expect(shangYuan.index == 0)

        // Test next
        let zhongYuan = shangYuan.next(1)
        #expect(zhongYuan.getName() == "中元")

        // Test wrap around (3 Sixty)
        let xiaYuan = Sixty.fromIndex(2)
        let nextShangYuan = xiaYuan.next(1)
        #expect(nextShangYuan.getName() == "上元")
    }
    @Test func testTen() throws {
        // Test all six Xun (六旬)
        let expectedNames = ["甲子", "甲戌", "甲申", "甲午", "甲辰", "甲寅"]
        for i in 0..<6 {
            let ten = Ten.fromIndex(i)
            #expect(ten.getName() == expectedNames[i])
            #expect(ten.index == i)
        }

        // Test fromName
        let jiaZi = try Ten.fromName("甲子")
        #expect(jiaZi.index == 0)

        // Test next
        let jiaXu = jiaZi.next(1)
        #expect(jiaXu.getName() == "甲戌")

        // Test wrap around (6 Ten)
        let jiaYin = Ten.fromIndex(5)
        let nextJiaZi = jiaYin.next(1)
        #expect(nextJiaZi.getName() == "甲子")
    }
    @Test func testTwenty() throws {
        // Test all nine Yun (九运)
        let expectedNames = ["一运", "二运", "三运", "四运", "五运", "六运", "七运", "八运", "九运"]
        for i in 0..<9 {
            let twenty = Twenty.fromIndex(i)
            #expect(twenty.getName() == expectedNames[i])
            #expect(twenty.index == i)
        }

        // Test fromName
        let yiYun = try Twenty.fromName("一运")
        #expect(yiYun.index == 0)

        // Test next
        let erYun = yiYun.next(1)
        #expect(erYun.getName() == "二运")

        // Test wrap around (9 Twenty)
        let jiuYun = Twenty.fromIndex(8)
        let nextYiYun = jiuYun.next(1)
        #expect(nextYiYun.getName() == "一运")

        // Test sixty (元)
        let shangYuan = yiYun.sixty
        #expect(shangYuan.getName() == "上元")
        let wuYun = Twenty.fromIndex(4)
        #expect(wuYun.sixty.getName() == "中元")
        let jiuYun2 = Twenty.fromIndex(8)
        #expect(jiuYun2.sixty.getName() == "下元")
    }

    // MARK: - NineStar：description 格式验证（Issue #114）

    @Test func testNineStarDescriptionFormat() throws {
        // Test description format: 星号 + 五行（e.g., "一白水", "二黑土"）
        let star1 = NineStar.fromIndex(0)
        #expect(star1.description == "一白水")

        let star2 = NineStar.fromIndex(1)
        #expect(star2.description == "二黑土")

        let star3 = NineStar.fromIndex(2)
        #expect(star3.description == "三碧木")

        let star5 = NineStar.fromIndex(4)
        #expect(star5.description == "五黄土")

        let star9 = NineStar.fromIndex(8)
        #expect(star9.description == "九紫火")
    }
}
