import Testing
@testable import tyme

@Suite struct Phase1AlignmentTests {

    // MARK: - Element Tests

    @Test func testElementReinforce() throws {
        // 我生者: next(1)
        #expect(Element.fromIndex(0).reinforce.getName() == "火")   // 木→火
        #expect(Element.fromIndex(1).reinforce.getName() == "土")   // 火→土
        #expect(Element.fromIndex(2).reinforce.getName() == "金")   // 土→金
        #expect(Element.fromIndex(3).reinforce.getName() == "水")   // 金→水
        #expect(Element.fromIndex(4).reinforce.getName() == "木")   // 水→木
    }

    @Test func testElementRestrain() throws {
        // 我克者: next(2)
        #expect(Element.fromIndex(0).restrain.getName() == "土")   // 木→土
        #expect(Element.fromIndex(1).restrain.getName() == "金")   // 火→金
        #expect(Element.fromIndex(2).restrain.getName() == "水")   // 土→水
        #expect(Element.fromIndex(3).restrain.getName() == "木")   // 金→木
        #expect(Element.fromIndex(4).restrain.getName() == "火")   // 水→火
    }

    @Test func testElementReinforced() throws {
        // 生我者: next(-1)
        #expect(Element.fromIndex(0).reinforced.getName() == "水")  // 木←水
        #expect(Element.fromIndex(1).reinforced.getName() == "木")  // 火←木
        #expect(Element.fromIndex(2).reinforced.getName() == "火")  // 土←火
        #expect(Element.fromIndex(3).reinforced.getName() == "土")  // 金←土
        #expect(Element.fromIndex(4).reinforced.getName() == "金")  // 水←金
    }

    @Test func testElementRestrained() throws {
        // 克我者: next(-2)
        #expect(Element.fromIndex(0).restrained.getName() == "金")  // 木←金
        #expect(Element.fromIndex(1).restrained.getName() == "水")  // 火←水
        #expect(Element.fromIndex(2).restrained.getName() == "木")  // 土←木
        #expect(Element.fromIndex(3).restrained.getName() == "火")  // 金←火
        #expect(Element.fromIndex(4).restrained.getName() == "土")  // 水←土
    }

    @Test func testElementDirection() throws {
        // 五行→方位
        #expect(Element.fromIndex(0).direction.getName() == "东")   // 木→东(idx=2)
        #expect(Element.fromIndex(0).direction.index == 2)
        #expect(Element.fromIndex(1).direction.getName() == "南")   // 火→南(idx=8)
        #expect(Element.fromIndex(1).direction.index == 8)
        #expect(Element.fromIndex(2).direction.getName() == "中")   // 土→中(idx=4)
        #expect(Element.fromIndex(2).direction.index == 4)
        #expect(Element.fromIndex(3).direction.getName() == "西")   // 金→西(idx=6)
        #expect(Element.fromIndex(3).direction.index == 6)
        #expect(Element.fromIndex(4).direction.getName() == "北")   // 水→北(idx=0)
        #expect(Element.fromIndex(4).direction.index == 0)
    }

    // MARK: - Direction Tests

    @Test func testDirectionNineNames() throws {
        // Direction.NAMES 应有9个，包含"中"
        #expect(Direction.NAMES.count == 9)
        #expect(Direction.NAMES[4] == "中")
        // 后天八卦序
        let expected = ["北", "西南", "东", "东南", "中", "西北", "西", "东北", "南"]
        #expect(Direction.NAMES == expected)
    }

    @Test func testDirectionLand() throws {
        // Direction→Land 对应关系
        let center = Direction.fromIndex(4) // 中
        #expect(center.getName() == "中")
        #expect(center.land.getName() == "钧天")  // Land[4]="钧天"

        let north = Direction.fromIndex(0)
        #expect(north.land.getName() == "玄天")    // Land[0]="玄天"
    }

    @Test func testDirectionElement() throws {
        // Direction→Element
        #expect(Direction.fromIndex(2).element.getName() == "木")  // 东→木
        #expect(Direction.fromIndex(8).element.getName() == "火")  // 南→火
        #expect(Direction.fromIndex(4).element.getName() == "土")  // 中→土
        #expect(Direction.fromIndex(6).element.getName() == "金")  // 西→金
        #expect(Direction.fromIndex(0).element.getName() == "水")  // 北→水
    }

    // MARK: - HeavenStem Tests

    @Test func testHeavenStemElement() throws {
        // 天干→五行 Element
        #expect(HeavenStem.fromIndex(0).element.getName() == "木")  // 甲→木
        #expect(HeavenStem.fromIndex(1).element.getName() == "木")  // 乙→木
        #expect(HeavenStem.fromIndex(2).element.getName() == "火")  // 丙→火
        #expect(HeavenStem.fromIndex(3).element.getName() == "火")  // 丁→火
        #expect(HeavenStem.fromIndex(4).element.getName() == "土")  // 戊→土
        #expect(HeavenStem.fromIndex(5).element.getName() == "土")  // 己→土
        #expect(HeavenStem.fromIndex(6).element.getName() == "金")  // 庚→金
        #expect(HeavenStem.fromIndex(7).element.getName() == "金")  // 辛→金
        #expect(HeavenStem.fromIndex(8).element.getName() == "水")  // 壬→水
        #expect(HeavenStem.fromIndex(9).element.getName() == "水")  // 癸→水
    }

    @Test func testHeavenStemYinYang() throws {
        // 天干→YinYang enum
        #expect(HeavenStem.fromIndex(0).yinYang == .yang)  // 甲→阳
        #expect(HeavenStem.fromIndex(1).yinYang == .yin)   // 乙→阴
        #expect(HeavenStem.fromIndex(2).yinYang == .yang)  // 丙→阳
        #expect(HeavenStem.fromIndex(3).yinYang == .yin)   // 丁→阴
    }

    @Test func testHeavenStemDirection() throws {
        // 天干→方位（通过 element.direction）
        #expect(HeavenStem.fromIndex(0).direction.getName() == "东")  // 甲→木→东
        #expect(HeavenStem.fromIndex(2).direction.getName() == "南")  // 丙→火→南
        #expect(HeavenStem.fromIndex(4).direction.getName() == "中")  // 戊→土→中
        #expect(HeavenStem.fromIndex(6).direction.getName() == "西")  // 庚→金→西
        #expect(HeavenStem.fromIndex(8).direction.getName() == "北")  // 壬→水→北
    }

    @Test func testHeavenStemWealthDirection() throws {
        // 天干→财位方向
        #expect(HeavenStem.fromIndex(0).wealthDirection.getName() == "东北") // 甲→东北(7)
        #expect(HeavenStem.fromIndex(0).wealthDirection.index == 7)
        #expect(HeavenStem.fromIndex(1).wealthDirection.getName() == "东北") // 乙→东北(7)
        #expect(HeavenStem.fromIndex(1).wealthDirection.index == 7)
    }

    @Test func testHeavenStemGetCombine() throws {
        // 天干合: 甲己合, 乙庚合, 丙辛合, 丁壬合, 戊癸合
        #expect(HeavenStem.fromIndex(0).getCombine().getName() == "己")  // 甲→己
        #expect(HeavenStem.fromIndex(5).getCombine().getName() == "甲")  // 己→甲
        #expect(HeavenStem.fromIndex(1).getCombine().getName() == "庚")  // 乙→庚
        #expect(HeavenStem.fromIndex(6).getCombine().getName() == "乙")  // 庚→乙
        #expect(HeavenStem.fromIndex(2).getCombine().getName() == "辛")  // 丙→辛
        #expect(HeavenStem.fromIndex(7).getCombine().getName() == "丙")  // 辛→丙
        #expect(HeavenStem.fromIndex(3).getCombine().getName() == "壬")  // 丁→壬
        #expect(HeavenStem.fromIndex(8).getCombine().getName() == "丁")  // 壬→丁
        #expect(HeavenStem.fromIndex(4).getCombine().getName() == "癸")  // 戊→癸
        #expect(HeavenStem.fromIndex(9).getCombine().getName() == "戊")  // 癸→戊
    }

    @Test func testHeavenStemCombineElement() throws {
        // 天干合化: 甲己合土, 乙庚合金, 丙辛合水, 丁壬合木, 戊癸合火
        #expect(HeavenStem.fromIndex(0).combine(HeavenStem.fromIndex(5))?.getName() == "土")  // 甲己→土
        #expect(HeavenStem.fromIndex(1).combine(HeavenStem.fromIndex(6))?.getName() == "金")  // 乙庚→金
        #expect(HeavenStem.fromIndex(2).combine(HeavenStem.fromIndex(7))?.getName() == "水")  // 丙辛→水
        #expect(HeavenStem.fromIndex(3).combine(HeavenStem.fromIndex(8))?.getName() == "木")  // 丁壬→木
        #expect(HeavenStem.fromIndex(4).combine(HeavenStem.fromIndex(9))?.getName() == "火")  // 戊癸→火
        // 非合者返回 nil
        #expect(HeavenStem.fromIndex(0).combine(HeavenStem.fromIndex(1)) == nil)  // 甲乙不合
    }

    // MARK: - EarthBranch Tests

    @Test func testEarthBranchElement() throws {
        // 地支→五行 Element
        #expect(EarthBranch.fromIndex(0).element.getName() == "水")  // 子→水
        #expect(EarthBranch.fromIndex(1).element.getName() == "土")  // 丑→土
        #expect(EarthBranch.fromIndex(2).element.getName() == "木")  // 寅→木
        #expect(EarthBranch.fromIndex(3).element.getName() == "木")  // 卯→木
        #expect(EarthBranch.fromIndex(4).element.getName() == "土")  // 辰→土
        #expect(EarthBranch.fromIndex(5).element.getName() == "火")  // 巳→火
        #expect(EarthBranch.fromIndex(6).element.getName() == "火")  // 午→火
        #expect(EarthBranch.fromIndex(7).element.getName() == "土")  // 未→土
        #expect(EarthBranch.fromIndex(8).element.getName() == "金")  // 申→金
        #expect(EarthBranch.fromIndex(9).element.getName() == "金")  // 酉→金
        #expect(EarthBranch.fromIndex(10).element.getName() == "土") // 戌→土
        #expect(EarthBranch.fromIndex(11).element.getName() == "水") // 亥→水
    }

    @Test func testEarthBranchYinYang() throws {
        // 地支→YinYang enum
        #expect(EarthBranch.fromIndex(0).yinYang == .yang)  // 子→阳
        #expect(EarthBranch.fromIndex(1).yinYang == .yin)   // 丑→阴
        #expect(EarthBranch.fromIndex(2).yinYang == .yang)  // 寅→阳
        #expect(EarthBranch.fromIndex(3).yinYang == .yin)   // 卯→阴
    }

    @Test func testEarthBranchDirection() throws {
        // 地支→方位
        #expect(EarthBranch.fromIndex(0).direction.getName() == "北")  // 子→北(0)
        #expect(EarthBranch.fromIndex(0).direction.index == 0)
        #expect(EarthBranch.fromIndex(3).direction.getName() == "东")  // 卯→东(2)
        #expect(EarthBranch.fromIndex(3).direction.index == 2)
        #expect(EarthBranch.fromIndex(6).direction.getName() == "南")  // 午→南(8)
        #expect(EarthBranch.fromIndex(6).direction.index == 8)
        #expect(EarthBranch.fromIndex(9).direction.getName() == "西")  // 酉→西(6)
        #expect(EarthBranch.fromIndex(9).direction.index == 6)
    }

    @Test func testEarthBranchOminous() throws {
        // 地支→煞方
        #expect(EarthBranch.fromIndex(0).ominous.getName() == "南")  // 子→南(8)
        #expect(EarthBranch.fromIndex(0).ominous.index == 8)
        #expect(EarthBranch.fromIndex(1).ominous.getName() == "东")  // 丑→东(2)
        #expect(EarthBranch.fromIndex(1).ominous.index == 2)
        #expect(EarthBranch.fromIndex(3).ominous.getName() == "西")  // 卯→西(6)
        #expect(EarthBranch.fromIndex(3).ominous.index == 6)
        #expect(EarthBranch.fromIndex(6).ominous.getName() == "北")  // 午→北(0)
        #expect(EarthBranch.fromIndex(6).ominous.index == 0)
    }

    @Test func testEarthBranchOpposite() throws {
        // 地支→冲（对冲，间隔6）
        #expect(EarthBranch.fromIndex(0).opposite.getName() == "午")  // 子→午
        #expect(EarthBranch.fromIndex(0).opposite.index == 6)
        #expect(EarthBranch.fromIndex(6).opposite.getName() == "子")  // 午→子
        #expect(EarthBranch.fromIndex(6).opposite.index == 0)
        #expect(EarthBranch.fromIndex(2).opposite.getName() == "申")  // 寅→申
        #expect(EarthBranch.fromIndex(8).opposite.getName() == "寅")  // 申→寅
    }

    @Test func testEarthBranchGetCombine() throws {
        // 地支六合: 子丑, 寅亥, 卯戌, 辰酉, 巳申, 午未
        #expect(EarthBranch.fromIndex(0).getCombine().getName() == "丑")   // 子→丑
        #expect(EarthBranch.fromIndex(1).getCombine().getName() == "子")   // 丑→子
        #expect(EarthBranch.fromIndex(2).getCombine().getName() == "亥")   // 寅→亥
        #expect(EarthBranch.fromIndex(11).getCombine().getName() == "寅")  // 亥→寅
        #expect(EarthBranch.fromIndex(3).getCombine().getName() == "戌")   // 卯→戌
        #expect(EarthBranch.fromIndex(10).getCombine().getName() == "卯")  // 戌→卯
    }

    @Test func testEarthBranchHideHeavenStemMain() throws {
        // 地支→藏干本气
        #expect(EarthBranch.fromIndex(0).hideHeavenStemMain.getName() == "癸")  // 子→癸(9)
        #expect(EarthBranch.fromIndex(1).hideHeavenStemMain.getName() == "己")  // 丑→己(5)
        #expect(EarthBranch.fromIndex(2).hideHeavenStemMain.getName() == "甲")  // 寅→甲(0)
        #expect(EarthBranch.fromIndex(3).hideHeavenStemMain.getName() == "乙")  // 卯→乙(1)
        #expect(EarthBranch.fromIndex(4).hideHeavenStemMain.getName() == "戊")  // 辰→戊(4)
        #expect(EarthBranch.fromIndex(5).hideHeavenStemMain.getName() == "丙")  // 巳→丙(2)
        #expect(EarthBranch.fromIndex(6).hideHeavenStemMain.getName() == "丁")  // 午→丁(3)
    }

    @Test func testHeavenStemJoyDirection() throws {
        // 喜神方位歌：甲己在艮(7), 乙庚乾(5), 丙辛坤(1), 丁壬离(8), 戊癸巽(3)
        #expect(HeavenStem.fromIndex(0).joyDirection.index == 7)  // 甲→艮(东北)
        #expect(HeavenStem.fromIndex(1).joyDirection.index == 5)  // 乙→乾(西北)
        #expect(HeavenStem.fromIndex(2).joyDirection.index == 1)  // 丙→坤(西南)
        #expect(HeavenStem.fromIndex(3).joyDirection.index == 8)  // 丁→离(南)
        #expect(HeavenStem.fromIndex(4).joyDirection.index == 3)  // 戊→巽(东南)
        #expect(HeavenStem.fromIndex(5).joyDirection.index == 7)  // 己→艮(东北)
    }

    @Test func testHeavenStemYangYinDirection() throws {
        // 阳贵神: [1,1,6,5,7,0,8,7,2,3]
        #expect(HeavenStem.fromIndex(0).yangDirection.index == 1)  // 甲→坤(西南)
        #expect(HeavenStem.fromIndex(2).yangDirection.index == 6)  // 丙→兑(西)
        #expect(HeavenStem.fromIndex(6).yangDirection.index == 8)  // 庚→离(南)
        // 阴贵神: [7,0,5,6,1,1,7,8,3,2]
        #expect(HeavenStem.fromIndex(0).yinDirection.index == 7)   // 甲→艮(东北)
        #expect(HeavenStem.fromIndex(2).yinDirection.index == 5)   // 丙→乾(西北)
    }

    @Test func testHeavenStemGetTenStar() throws {
        // 甲(0) 与各天干的十神
        let jia = HeavenStem.fromIndex(0) // 甲
        // 甲与甲：同我者，比肩(index 0)
        let jiajia = jia.getTenStar(HeavenStem.fromIndex(0))
        #expect(jiajia.index == 0)
        // 甲与乙：劫财(index 1)
        #expect(jia.getTenStar(HeavenStem.fromIndex(1)).index == 1)
    }

    @Test func testHeavenStemGetTerrain() throws {
        // 甲(0, 阳木) 的长生十二宫以亥(11)起长生
        // 基数=[1,6,10,9,10,9,7,0,4,3][0]=1，阳加地支索引
        // 亥(11): 1+11=12，Terrain.fromIndex(12) → index 0 (长生)
        let jia = HeavenStem.fromIndex(0)
        let hai = EarthBranch.fromIndex(11) // 亥
        let terrain = jia.getTerrain(hai)
        #expect(terrain.getName() == "长生")
    }

    @Test func testEarthBranchHarm() throws {
        // 六害: 子未害(0,7), 丑午害(1,6), 寅巳害(2,5), 卯辰害(3,4), 申亥害(8,11), 酉戌害(9,10)
        #expect(EarthBranch.fromIndex(0).harm.getName() == "未")   // 子→未
        #expect(EarthBranch.fromIndex(7).harm.getName() == "子")   // 未→子
        #expect(EarthBranch.fromIndex(1).harm.getName() == "午")   // 丑→午
        #expect(EarthBranch.fromIndex(6).harm.getName() == "丑")   // 午→丑
    }

    @Test func testEarthBranchCombineElement() throws {
        // 地支合化: 子丑→土(2), 寅亥→木(0), 卯戌→火(1), 辰酉→金(3), 巳申→水(4), 午未→土(2)
        #expect(EarthBranch.fromIndex(0).combine(EarthBranch.fromIndex(1))?.getName() == "土")  // 子丑→土
        #expect(EarthBranch.fromIndex(2).combine(EarthBranch.fromIndex(11))?.getName() == "木") // 寅亥→木
        #expect(EarthBranch.fromIndex(3).combine(EarthBranch.fromIndex(10))?.getName() == "火") // 卯戌→火
        #expect(EarthBranch.fromIndex(0).combine(EarthBranch.fromIndex(0)) == nil)  // 子子不合
    }

    @Test func testEarthBranchHideHeavenStemMiddleResidual() throws {
        // 丑(1): 中气=癸(9), 余气=辛(7)
        #expect(EarthBranch.fromIndex(1).hideHeavenStemMiddle?.getName() == "癸")
        #expect(EarthBranch.fromIndex(1).hideHeavenStemResidual?.getName() == "辛")
        // 寅(2): 中气=丙(2), 余气=戊(4)
        #expect(EarthBranch.fromIndex(2).hideHeavenStemMiddle?.getName() == "丙")
        #expect(EarthBranch.fromIndex(2).hideHeavenStemResidual?.getName() == "戊")
        // 子(0): 无中气和余气
        #expect(EarthBranch.fromIndex(0).hideHeavenStemMiddle == nil)
        #expect(EarthBranch.fromIndex(0).hideHeavenStemResidual == nil)
    }
}
