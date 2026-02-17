import Foundation

public final class EarthBranch: LoopTyme {
    public static let NAMES = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
    
    // Zodiac mapping (生肖)
    private static let ZODIAC_NAMES = ["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"]
    
    // YinYang mapping for EarthBranch (阴阳)
    private static let YIN_YANG = ["阳","阴","阳","阴","阳","阴","阳","阴","阳","阴","阳","阴"]
    
    // WuXing (五行) mapping for EarthBranch
    private static let WU_XING = ["水","土","木","木","土","火","火","土","金","金","土","水"]
    
    // NaYin (纳音) - 60 sounds combined with stems
    private static let NA_YIN_BRANCH = [
        "海中金", "海中金", "炉中火", "炉中火", "大林木", "大林木",
        "路傍土", "路傍土", "剑锋金", "剑锋金", "山下火", "山下火",
        "城头土", "城头土", "白腊金", "白腊金", "杨柳木", "杨柳木",
        "泉中水", "泉中水", "屋上瓦", "屋上瓦", "霹雳火", "霹雳火",
        "松柏木", "松柏木", "长流水", "长流水", "沙中金", "沙中金",
        "山头火", "山头火", "平地木", "平地木", "壁上土", "壁上土",
        "金箔金", "金箔金", "桑柘木", "桑柘木", "大溪水", "大溪水",
        "大驿土", "大驿土", "钗钏金", "钗钏金", "沙中土", "沙中土",
        "天河水", "天河水", "大林木", "大林木", "覆灯火", "覆灯火",
        "天上水", "天上水", "石榴木", "石榴木"
    ]

    public convenience init(index: Int) {
        self.init(names: EarthBranch.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: EarthBranch.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> EarthBranch {
        EarthBranch(index: index)
    }

    public static func fromName(_ name: String) throws -> EarthBranch {
        try EarthBranch(name: name)
    }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = EarthBranch.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> EarthBranch {
        EarthBranch.fromIndex(nextIndex(n))
    }
    
    // Properties
    public func getZodiac() -> String {
        EarthBranch.ZODIAC_NAMES[index]
    }
    
    public func getYinYang() -> String {
        EarthBranch.YIN_YANG[index]
    }
    
    public func getWuXing() -> String {
        EarthBranch.WU_XING[index]
    }
    
    public func getNaYin(_ stemIndex: Int = 0) -> String {
        let naYinIndex = (stemIndex * 12 + index) % 60
        return EarthBranch.NA_YIN_BRANCH[naYinIndex]
    }
    
    public func getFlourish() -> String {
        let flourishStages = ["长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎", "养"]
        return flourishStages[index]
    }
    
    public func getDecline() -> String {
        let declineStages = ["养", "长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎"]
        return declineStages[index]
    }
}
