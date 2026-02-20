import com.tyme.solar.SolarDay;
import com.tyme.solar.SolarTime;
import com.tyme.solar.SolarTerm;
import com.tyme.lunar.LunarDay;
import com.tyme.rabbyung.RabByungDay;
import java.io.*;
import java.time.LocalDate;
import java.util.*;

public class TruthTableGenerator {

    static class SolarLunarEntry {
        String solar;
        String lunarYear;
        String lunarMonth;
        String lunarDay;
        boolean isLeapMonth;

        SolarLunarEntry(String solar, String lunarYear, String lunarMonth, String lunarDay, boolean isLeapMonth) {
            this.solar = solar;
            this.lunarYear = lunarYear;
            this.lunarMonth = lunarMonth;
            this.lunarDay = lunarDay;
            this.isLeapMonth = isLeapMonth;
        }
    }

    static class SixtyCycleEntry {
        String solar;
        String sixtyCycleYear;
        String sixtyCycleMonth;
        String sixtyCycleDay;
        String duty;
        String twelveStar;
        String dayNineStar;
        String twentyEightStar;

        SixtyCycleEntry(String solar, String sixtyCycleYear, String sixtyCycleMonth, String sixtyCycleDay,
                        String duty, String twelveStar, String dayNineStar, String twentyEightStar) {
            this.solar = solar;
            this.sixtyCycleYear = sixtyCycleYear;
            this.sixtyCycleMonth = sixtyCycleMonth;
            this.sixtyCycleDay = sixtyCycleDay;
            this.duty = duty;
            this.twelveStar = twelveStar;
            this.dayNineStar = dayNineStar;
            this.twentyEightStar = twentyEightStar;
        }
    }

    static class EightCharEntry {
        String solarTime;
        String yearPillar;
        String monthPillar;
        String dayPillar;
        String hourPillar;

        EightCharEntry(String solarTime, String yearPillar, String monthPillar, String dayPillar, String hourPillar) {
            this.solarTime = solarTime;
            this.yearPillar = yearPillar;
            this.monthPillar = monthPillar;
            this.dayPillar = dayPillar;
            this.hourPillar = hourPillar;
        }
    }

    static class SolarTermEntry {
        int year;
        int termIndex;
        String termName;
        String solarDate;

        SolarTermEntry(int year, int termIndex, String termName, String solarDate) {
            this.year = year;
            this.termIndex = termIndex;
            this.termName = termName;
            this.solarDate = solarDate;
        }
    }

    static class ConstellationEntry {
        String solar;
        String constellation;

        ConstellationEntry(String solar, String constellation) {
            this.solar = solar;
            this.constellation = constellation;
        }
    }

    static class SixStarEntry {
        String solar;
        String sixStar;

        SixStarEntry(String solar, String sixStar) {
            this.solar = solar;
            this.sixStar = sixStar;
        }
    }

    static class RabByungEntry {
        String solar;
        String rabByungYear;
        String rabByungMonth;
        String rabByungDay;

        RabByungEntry(String solar, String rabByungYear, String rabByungMonth, String rabByungDay) {
            this.solar = solar;
            this.rabByungYear = rabByungYear;
            this.rabByungMonth = rabByungMonth;
            this.rabByungDay = rabByungDay;
        }
    }

    // Generate EightChar entries (every 30 days, all 12 even hours)
    private static List<EightCharEntry> generateEightCharEntries() {
        List<EightCharEntry> entries = new ArrayList<>();
        LocalDate current = LocalDate.of(2000, 1, 1);
        LocalDate end = LocalDate.of(2030, 12, 31);

        while (!current.isAfter(end)) {
            try {
                for (int hour = 0; hour < 24; hour += 2) {
                    SolarTime st = SolarTime.fromYmdHms(current.getYear(), current.getMonthValue(), current.getDayOfMonth(), hour, 0, 0);
                    com.tyme.eightchar.EightChar ec = st.getLunarHour().getEightChar();

                    String solarTimeStr = String.format("%04d-%02d-%02d %02d", current.getYear(), current.getMonthValue(), current.getDayOfMonth(), hour);
                    entries.add(new EightCharEntry(
                        solarTimeStr,
                        ec.getYear().getName(),
                        ec.getMonth().getName(),
                        ec.getDay().getName(),
                        ec.getHour().getName()
                    ));
                }
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(30);
        }

        return entries;
    }

    // Generate SolarTerm entries (all 24 terms for each year)
    private static List<SolarTermEntry> generateSolarTermEntries() {
        List<SolarTermEntry> entries = new ArrayList<>();

        for (int year = 1900; year <= 2100; year++) {
            for (int termIndex = 0; termIndex < 24; termIndex++) {
                try {
                    SolarTerm term = SolarTerm.fromIndex(year, termIndex);
                    SolarDay sd = term.getSolarDay();
                    String solarDateStr = String.format("%04d-%02d-%02d", sd.getYear(), sd.getMonth(), sd.getDay());
                    entries.add(new SolarTermEntry(
                        year,
                        termIndex,
                        term.getName(),
                        solarDateStr
                    ));
                } catch (Exception e) {
                    System.err.println("Error processing SolarTerm year=" + year + " termIndex=" + termIndex + ": " + e.getMessage());
                }
            }
        }

        return entries;
    }

    // Generate RabByung entries (every 30 days from 1950-02-01 to 2050-02-11)
    private static List<RabByungEntry> generateRabByungEntries() {
        List<RabByungEntry> entries = new ArrayList<>();
        LocalDate current = LocalDate.of(1950, 2, 1);
        LocalDate end = LocalDate.of(2050, 2, 11);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                RabByungDay rabByung = solar.getRabByungDay();
                String solarStr = current.toString();
                entries.add(new RabByungEntry(
                    solarStr,
                    rabByung.getRabByungMonth().getRabByungYear().getName(),
                    rabByung.getRabByungMonth().getName(),
                    rabByung.getName()
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(30);
        }

        return entries;
    }

    public static void main(String[] args) throws Exception {
        String outputDir = "/Users/ruining/Developer/tyme4swift/Tests/tymeTests/Fixtures/";
        if (args.length > 0 && args[0].equals("--output")) {
            outputDir = args[1];
        }

        // Create output directory if not exists
        new File(outputDir).mkdirs();

        System.out.println("Generating truth tables...");

        // Generate solar_lunar.json (sample every 7 days)
        System.out.print("Generating solar_lunar.json...");
        List<SolarLunarEntry> solarLunarEntries = new ArrayList<>();
        LocalDate current = LocalDate.of(1900, 1, 31);
        LocalDate end = LocalDate.of(2100, 12, 31);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                LunarDay lunar = solar.getLunarDay();

                String lunarYearName = lunar.getLunarMonth().getLunarYear().getName();
                String lunarMonthName = lunar.getLunarMonth().getName();
                String lunarDayName = lunar.getName();
                boolean isLeap = lunar.getLunarMonth().isLeap();

                solarLunarEntries.add(new SolarLunarEntry(
                    current.toString(),
                    lunarYearName,
                    lunarMonthName,
                    lunarDayName,
                    isLeap
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(7);
        }

        System.out.println(" " + solarLunarEntries.size() + " entries");

        // Generate sixty_cycle.json (sample every 15 days)
        System.out.print("Generating sixty_cycle.json...");
        List<SixtyCycleEntry> sixtyCycleEntries = new ArrayList<>();
        current = LocalDate.of(1900, 1, 31);

        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                com.tyme.sixtycycle.SixtyCycleDay scd = solar.getSixtyCycleDay();
                String yearName = scd.getYear().getName();
                String monthName = scd.getMonth().getName();
                String dayName = scd.getSixtyCycle().getName();
                String dutyName = scd.getDuty().getName();
                String twelveStarName = scd.getTwelveStar().getName();
                String dayNineStarName = scd.getNineStar().getName() + scd.getNineStar().getColor();
                String twentyEightStarName = scd.getTwentyEightStar().getName();

                sixtyCycleEntries.add(new SixtyCycleEntry(
                    current.toString(),
                    yearName,
                    monthName,
                    dayName,
                    dutyName,
                    twelveStarName,
                    dayNineStarName,
                    twentyEightStarName
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(15);
        }

        System.out.println(" " + sixtyCycleEntries.size() + " entries");

        // Generate eight_char.json
        System.out.print("Generating eight_char.json...");
        List<EightCharEntry> eightCharEntries = generateEightCharEntries();
        System.out.println(" " + eightCharEntries.size() + " entries");

        // Generate solar_term.json
        System.out.print("Generating solar_term.json...");
        List<SolarTermEntry> solarTermEntries = generateSolarTermEntries();
        System.out.println(" " + solarTermEntries.size() + " entries");

        // Generate rab_byung.json
        System.out.print("Generating rab_byung.json...");
        List<RabByungEntry> rabByungEntries = generateRabByungEntries();
        System.out.println(" " + rabByungEntries.size() + " entries");

        // Generate constellation.json (sample every 7 days, 1900-2100)
        System.out.print("Generating constellation.json...");
        List<ConstellationEntry> constellationEntries = new ArrayList<>();
        current = LocalDate.of(1900, 1, 31);
        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                constellationEntries.add(new ConstellationEntry(
                    current.toString(),
                    solar.getConstellation().getName()
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(7);
        }
        System.out.println(" " + constellationEntries.size() + " entries");

        // Generate six_star.json (sample every 7 days, 1900-2100)
        System.out.print("Generating six_star.json...");
        List<SixStarEntry> sixStarEntries = new ArrayList<>();
        current = LocalDate.of(1900, 1, 31);
        while (!current.isAfter(end)) {
            try {
                SolarDay solar = SolarDay.fromYmd(current.getYear(), current.getMonthValue(), current.getDayOfMonth());
                sixStarEntries.add(new SixStarEntry(
                    current.toString(),
                    solar.getLunarDay().getSixStar().getName()
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(7);
        }
        System.out.println(" " + sixStarEntries.size() + " entries");

        // Write solar_lunar.json
        writeJson(outputDir + "solar_lunar.json", solarLunarEntries);

        // Write sixty_cycle.json
        writeJson(outputDir + "sixty_cycle.json", sixtyCycleEntries);

        // Write eight_char.json
        writeJson(outputDir + "eight_char.json", eightCharEntries);

        // Write solar_term.json
        writeJson(outputDir + "solar_term.json", solarTermEntries);

        // Write rab_byung.json
        writeJson(outputDir + "rab_byung.json", rabByungEntries);

        // Write constellation.json
        writeJson(outputDir + "constellation.json", constellationEntries);

        // Write six_star.json
        writeJson(outputDir + "six_star.json", sixStarEntries);

        System.out.println("Done!");
    }

    private static void writeJson(String filename, List<?> entries) throws IOException {
        try (FileWriter writer = new FileWriter(filename)) {
            writer.write("[\n");
            for (int i = 0; i < entries.size(); i++) {
                Object entry = entries.get(i);
                if (entry instanceof SolarLunarEntry) {
                    SolarLunarEntry e = (SolarLunarEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"lunarYear\":\"%s\",\"lunarMonth\":\"%s\",\"lunarDay\":\"%s\",\"isLeapMonth\":%s}",
                        e.solar, e.lunarYear, e.lunarMonth, e.lunarDay, e.isLeapMonth
                    ));
                } else if (entry instanceof SixtyCycleEntry) {
                    SixtyCycleEntry e = (SixtyCycleEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"sixtyCycleYear\":\"%s\",\"sixtyCycleMonth\":\"%s\",\"sixtyCycleDay\":\"%s\",\"duty\":\"%s\",\"twelveStar\":\"%s\",\"dayNineStar\":\"%s\",\"twentyEightStar\":\"%s\"}",
                        e.solar, e.sixtyCycleYear, e.sixtyCycleMonth, e.sixtyCycleDay,
                        e.duty, e.twelveStar, e.dayNineStar, e.twentyEightStar
                    ));
                } else if (entry instanceof EightCharEntry) {
                    EightCharEntry e = (EightCharEntry) entry;
                    writer.write(String.format(
                        "  {\"solarTime\":\"%s\",\"yearPillar\":\"%s\",\"monthPillar\":\"%s\",\"dayPillar\":\"%s\",\"hourPillar\":\"%s\"}",
                        e.solarTime, e.yearPillar, e.monthPillar, e.dayPillar, e.hourPillar
                    ));
                } else if (entry instanceof SolarTermEntry) {
                    SolarTermEntry e = (SolarTermEntry) entry;
                    writer.write(String.format(
                        "  {\"year\":%d,\"termIndex\":%d,\"termName\":\"%s\",\"solarDate\":\"%s\"}",
                        e.year, e.termIndex, e.termName, e.solarDate
                    ));
                } else if (entry instanceof RabByungEntry) {
                    RabByungEntry e = (RabByungEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"rabByungYear\":\"%s\",\"rabByungMonth\":\"%s\",\"rabByungDay\":\"%s\"}",
                        e.solar, e.rabByungYear, e.rabByungMonth, e.rabByungDay
                    ));
                } else if (entry instanceof ConstellationEntry) {
                    ConstellationEntry e = (ConstellationEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"constellation\":\"%s\"}",
                        e.solar, e.constellation
                    ));
                } else if (entry instanceof SixStarEntry) {
                    SixStarEntry e = (SixStarEntry) entry;
                    writer.write(String.format(
                        "  {\"solar\":\"%s\",\"sixStar\":\"%s\"}",
                        e.solar, e.sixStar
                    ));
                }

                if (i < entries.size() - 1) {
                    writer.write(",\n");
                } else {
                    writer.write("\n");
                }
            }
            writer.write("]\n");
        }
    }
}
