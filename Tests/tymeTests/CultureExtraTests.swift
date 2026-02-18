import Testing
@testable import tyme

@Suite struct CultureExtraTests {
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
            #expect(dog.index == i)
        }

        // Test fromName
        let chuFu = try Dog.fromName("初伏")
        #expect(chuFu.index == 0)

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
        #expect(dogDay.dog.getName() == "初伏")
        #expect(dogDay.dayIndex == 0)
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
            #expect(nine.index == i)
        }

        // Test fromName
        let yiJiu = try Nine.fromName("一九")
        #expect(yiJiu.index == 0)

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
        #expect(nineDay.nine.getName() == "一九")
        #expect(nineDay.dayIndex == 0)
        #expect(nineDay.getName() == "一九第1天")

        let nineDay2 = NineColdDay.fromNine(nine, 8)
        #expect(nineDay2.getName() == "一九第9天")
    }
    @Test func testPlumRain() throws {
        // Test both plum rain periods
        let ruMei = PlumRain.fromIndex(0)
        #expect(ruMei.getName() == "入梅")
        #expect(ruMei.entering)
        #expect(!ruMei.exiting)

        let chuMei = PlumRain.fromIndex(1)
        #expect(chuMei.getName() == "出梅")
        #expect(!chuMei.entering)
        #expect(chuMei.exiting)

        // Test next
        let next = ruMei.next(1)
        #expect(next.getName() == "出梅")
    }
    @Test func testPlumRainDay() throws {
        let plumRain = PlumRain.fromIndex(0)
        let plumRainDay = PlumRainDay.fromPlumRain(plumRain, 0)
        #expect(plumRainDay.plumRain.getName() == "入梅")
        #expect(plumRainDay.dayIndex == 0)
        #expect(plumRainDay.getName() == "入梅第1天")
    }
    @Test func testTaboo() throws {
        // Test auspicious taboo
        let auspicious = Taboo.auspicious("祭祀")
        #expect(auspicious.getName() == "祭祀")
        #expect(auspicious.auspicious)
        #expect(!auspicious.inauspicious)

        // Test inauspicious taboo
        let inauspicious = Taboo.inauspicious("动土")
        #expect(inauspicious.getName() == "动土")
        #expect(!inauspicious.auspicious)
        #expect(inauspicious.inauspicious)
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
        #expect(0 == (try MinorRen.fromName("大安").index))
        #expect(3 == (try MinorRen.fromName("赤口").index))
    }
    @Test func testMinorRenLuck() throws {
        // Even index = 吉, Odd index = 凶
        #expect("吉" == MinorRen.fromIndex(0).luck.getName()) // 大安
        #expect("凶" == MinorRen.fromIndex(1).luck.getName()) // 留连
        #expect("吉" == MinorRen.fromIndex(2).luck.getName()) // 速喜
        #expect("凶" == MinorRen.fromIndex(3).luck.getName()) // 赤口
        #expect("吉" == MinorRen.fromIndex(4).luck.getName()) // 小吉
        #expect("凶" == MinorRen.fromIndex(5).luck.getName()) // 空亡
    }
    @Test func testMinorRenElement() throws {
        // Mapping: [0,4,1,3,0,2] → Element.NAMES["木","火","土","金","水"] index
        // [0,4,1,3,0,2] → [木,水,火,金,木,土]
        #expect("木" == MinorRen.fromIndex(0).element.getName()) // 大安
        #expect("水" == MinorRen.fromIndex(1).element.getName()) // 留连
        #expect("火" == MinorRen.fromIndex(2).element.getName()) // 速喜
        #expect("金" == MinorRen.fromIndex(3).element.getName()) // 赤口
        #expect("木" == MinorRen.fromIndex(4).element.getName()) // 小吉
        #expect("土" == MinorRen.fromIndex(5).element.getName()) // 空亡
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
    @Test func testPhenologyDay() {
        let p = Phenology.fromIndex(0)
        let day = PhenologyDay(phenology: p, dayIndex: 2)
        #expect(day.phenology.getName() == "蚯蚓结")
        #expect(day.dayIndex == 2)
        #expect(day.getName() == "蚯蚓结")
        #expect(day.description == "蚯蚓结第3天")
    }
    @Test func testRabByungElement() throws {
        let e = try RabByungElement(index: 3) // 金→铁
        #expect(e.getName() == "铁")
        #expect(e.index == 3)
        #expect(e.reinforce.getName() == "水")  // 铁生水
        #expect(e.restrain.getName() == "木")   // 铁克木
        #expect(e.reinforced.getName() == "土") // 土生铁
        #expect(e.restrained.getName() == "火") // 火克铁

        let e2 = try RabByungElement.fromName("铁")
        #expect(e2.index == 3)
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
