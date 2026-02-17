import Testing
@testable import tyme

/// Phase 2 alignment tests: verifies that Sixty, Twenty, Ten, Sound, and SixtyCycle
/// conform to the Java tyme4j reference implementation semantics.
@Suite struct Phase2AlignmentTests {

    // MARK: - Sixty (三元)

    @Test func testSixtyNames() {
        let expectedNames = ["上元", "中元", "下元"]
        for i in 0..<3 {
            let sixty = Sixty.fromIndex(i)
            #expect(sixty.getName() == expectedNames[i])
            #expect(sixty.index == i)
        }
    }

    @Test func testSixtyFromName() throws {
        let shangYuan = try Sixty.fromName("上元")
        #expect(shangYuan.index == 0)

        let zhongYuan = try Sixty.fromName("中元")
        #expect(zhongYuan.index == 1)

        let xiaYuan = try Sixty.fromName("下元")
        #expect(xiaYuan.index == 2)
    }

    @Test func testSixtyNext() {
        let shangYuan = Sixty.fromIndex(0)
        #expect(shangYuan.next(1).getName() == "中元")
        #expect(shangYuan.next(2).getName() == "下元")
        // Wrap around
        #expect(shangYuan.next(3).getName() == "上元")
        #expect(Sixty.fromIndex(2).next(1).getName() == "上元")
    }

    @Test func testSixtyCount() {
        // Sixty has exactly 3 entries
        #expect(Sixty.NAMES.count == 3)
    }

    // MARK: - Twenty (九运)

    @Test func testTwentyNames() {
        let expectedNames = ["一运", "二运", "三运", "四运", "五运", "六运", "七运", "八运", "九运"]
        for i in 0..<9 {
            let twenty = Twenty.fromIndex(i)
            #expect(twenty.getName() == expectedNames[i])
            #expect(twenty.index == i)
        }
    }

    @Test func testTwentyFromName() throws {
        let yiYun = try Twenty.fromName("一运")
        #expect(yiYun.index == 0)

        let jiuYun = try Twenty.fromName("九运")
        #expect(jiuYun.index == 8)
    }

    @Test func testTwentyNext() {
        let yiYun = Twenty.fromIndex(0)
        #expect(yiYun.next(1).getName() == "二运")
        // Wrap around
        #expect(Twenty.fromIndex(8).next(1).getName() == "一运")
    }

    @Test func testTwentySixty() {
        // 一运(0), 二运(1), 三运(2) → 上元(0)
        #expect(Twenty.fromIndex(0).sixty.getName() == "上元")
        #expect(Twenty.fromIndex(1).sixty.getName() == "上元")
        #expect(Twenty.fromIndex(2).sixty.getName() == "上元")
        // 四运(3), 五运(4), 六运(5) → 中元(1)
        #expect(Twenty.fromIndex(3).sixty.getName() == "中元")
        #expect(Twenty.fromIndex(4).sixty.getName() == "中元")
        #expect(Twenty.fromIndex(5).sixty.getName() == "中元")
        // 七运(6), 八运(7), 九运(8) → 下元(2)
        #expect(Twenty.fromIndex(6).sixty.getName() == "下元")
        #expect(Twenty.fromIndex(7).sixty.getName() == "下元")
        #expect(Twenty.fromIndex(8).sixty.getName() == "下元")
    }

    @Test func testTwentyCount() {
        // Twenty has exactly 9 entries
        #expect(Twenty.NAMES.count == 9)
    }

    // MARK: - Ten (六旬)

    @Test func testTenNames() {
        let expectedNames = ["甲子", "甲戌", "甲申", "甲午", "甲辰", "甲寅"]
        for i in 0..<6 {
            let ten = Ten.fromIndex(i)
            #expect(ten.getName() == expectedNames[i])
            #expect(ten.index == i)
        }
    }

    @Test func testTenFromName() throws {
        let jiaZi = try Ten.fromName("甲子")
        #expect(jiaZi.index == 0)

        let jiaXu = try Ten.fromName("甲戌")
        #expect(jiaXu.index == 1)

        let jiaYin = try Ten.fromName("甲寅")
        #expect(jiaYin.index == 5)
    }

    @Test func testTenNext() {
        let jiaZi = Ten.fromIndex(0)
        #expect(jiaZi.next(1).getName() == "甲戌")
        // Wrap around
        #expect(Ten.fromIndex(5).next(1).getName() == "甲子")
    }

    @Test func testTenCount() {
        // Ten has exactly 6 entries
        #expect(Ten.NAMES.count == 6)
    }

    // MARK: - Sound (纳音, 30 names)

    @Test func testSoundNames() {
        let expectedFirstFive = ["海中金", "炉中火", "大林木", "路旁土", "剑锋金"]
        for i in 0..<5 {
            let sound = Sound.fromIndex(i)
            #expect(sound.getName() == expectedFirstFive[i])
            #expect(sound.index == i)
        }
    }

    @Test func testSoundAllNames() {
        let allNames = ["海中金", "炉中火", "大林木", "路旁土", "剑锋金",
                        "山头火", "涧下水", "城头土", "白蜡金", "杨柳木",
                        "泉中水", "屋上土", "霹雳火", "松柏木", "长流水",
                        "沙中金", "山下火", "平地木", "壁上土", "金箔金",
                        "覆灯火", "天河水", "大驿土", "钗钏金", "桑柘木",
                        "大溪水", "沙中土", "天上火", "石榴木", "大海水"]
        #expect(Sound.NAMES == allNames)
        #expect(Sound.NAMES.count == 30)
    }

    @Test func testSoundFromName() throws {
        let haiZhongJin = try Sound.fromName("海中金")
        #expect(haiZhongJin.index == 0)

        let daHaiShui = try Sound.fromName("大海水")
        #expect(daHaiShui.index == 29)
    }

    @Test func testSoundNext() {
        let haiZhongJin = Sound.fromIndex(0)
        #expect(haiZhongJin.next(1).getName() == "炉中火")
        // Wrap around
        #expect(Sound.fromIndex(29).next(1).getName() == "海中金")
    }

    @Test func testSoundElement() {
        // 海中金 → 金
        #expect(Sound.fromIndex(0).element.getName() == "金")
        // 炉中火 → 火
        #expect(Sound.fromIndex(1).element.getName() == "火")
        // 大林木 → 木
        #expect(Sound.fromIndex(2).element.getName() == "木")
        // 路旁土 → 土
        #expect(Sound.fromIndex(3).element.getName() == "土")
    }

    @Test func testSoundWuXing() {
        #expect(Sound.fromIndex(0).wuXing == "金")
        #expect(Sound.fromIndex(1).wuXing == "火")
        #expect(Sound.fromIndex(29).wuXing == "水")
    }

    // MARK: - SixtyCycle new methods

    @Test func testSixtyCycleSound() {
        // 甲子(0) and 乙丑(1) share the same NaYin: 海中金(0)
        let jiaZi = SixtyCycle.fromIndex(0)
        let yiChou = SixtyCycle.fromIndex(1)
        #expect(jiaZi.sound.getName() == "海中金")
        #expect(yiChou.sound.getName() == "海中金")

        // 丙寅(2) and 丁卯(3) share: 炉中火(1)
        #expect(SixtyCycle.fromIndex(2).sound.getName() == "炉中火")
        #expect(SixtyCycle.fromIndex(3).sound.getName() == "炉中火")

        // 癸亥(59) → 大海水(29)
        #expect(SixtyCycle.fromIndex(59).sound.getName() == "大海水")
    }

    @Test func testSixtyCyclePengZu() {
        // 甲子 → PengZu should have heaven stem and earth branch taboos
        let jiaZi = SixtyCycle.fromIndex(0)
        let pengZu = jiaZi.pengZu
        #expect(pengZu.pengZuHeavenStem.getName().contains("甲"))
        #expect(pengZu.pengZuEarthBranch.getName().contains("子"))
    }

    @Test func testSixtyCycleTen() {
        // 甲子(0): heavenStem=甲(0), earthBranch=子(0)
        // ten index = (0 - 0) / 2 = 0 → 甲子旬
        let jiaZi = SixtyCycle.fromIndex(0)
        #expect(jiaZi.ten.getName() == "甲子")

        // 甲戌(10): heavenStem=甲(0), earthBranch=戌(10)
        // ten index = (0 - 10) / 2 = -5 → mod 6 = 1 → 甲戌旬
        let jiaXu = SixtyCycle.fromIndex(10)
        #expect(jiaXu.ten.getName() == "甲戌")

        // 乙亥(11): heavenStem=乙(1), earthBranch=亥(11)
        // ten index = (1 - 11) / 2 = -5 → mod 6 = 1 → 甲戌旬
        let yiHai = SixtyCycle.fromIndex(11)
        #expect(yiHai.ten.getName() == "甲戌")
    }

    @Test func testSixtyCycleExtraEarthBranches() {
        // 甲子旬 (甲子, index 0): heavenStem=甲(0), earthBranch=子(0)
        // first = EarthBranch.fromIndex(10 + 0 - 0) = 戌(10)
        // second = 戌.next(1) = 亥(11)
        let jiaZi = SixtyCycle.fromIndex(0)
        let extras = jiaZi.extraEarthBranches
        #expect(extras.count == 2)
        #expect(extras[0].getName() == "戌")
        #expect(extras[1].getName() == "亥")
    }

    @Test func testSixtyCycleSoundMatchesNaYin() {
        // Sound index for SixtyCycle = index / 2
        // This should match NaYin which uses fromSixtyCycle(index / 2)
        for i in 0..<60 {
            let sc = SixtyCycle.fromIndex(i)
            let sound = sc.sound
            let naYin = NaYin.fromSixtyCycle(i)
            #expect(sound.getName() == naYin.getName(),
                    "SixtyCycle index \(i): sound '\(sound.getName())' should match NaYin '\(naYin.getName())'")
        }
    }

    @Test func testSixtyCyclePengZuMatchesExistingFactory() {
        // SixtyCycle.pengZu should produce same result as PengZu.fromSixtyCycle
        let sc = SixtyCycle.fromIndex(0) // 甲子
        let pengZuViaProperty = sc.pengZu
        let pengZuViaFactory = PengZu.fromSixtyCycle(sc)
        #expect(pengZuViaProperty.getName() == pengZuViaFactory.getName())
    }
}
