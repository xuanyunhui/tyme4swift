import com.tyme.solar.SolarDay;
import com.tyme.lunar.LunarDay;
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

        SixtyCycleEntry(String solar, String sixtyCycleYear, String sixtyCycleMonth, String sixtyCycleDay) {
            this.solar = solar;
            this.sixtyCycleYear = sixtyCycleYear;
            this.sixtyCycleMonth = sixtyCycleMonth;
            this.sixtyCycleDay = sixtyCycleDay;
        }
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
                String yearName = solar.getSixtyCycleDay().getYear().getName();
                String monthName = solar.getSixtyCycleDay().getMonth().getName();
                String dayName = solar.getSixtyCycleDay().getSixtyCycle().getName();

                sixtyCycleEntries.add(new SixtyCycleEntry(
                    current.toString(),
                    yearName,
                    monthName,
                    dayName
                ));
            } catch (Exception e) {
                System.err.println("Error processing " + current + ": " + e.getMessage());
            }
            current = current.plusDays(15);
        }

        System.out.println(" " + sixtyCycleEntries.size() + " entries");

        // Write solar_lunar.json
        writeJson(outputDir + "solar_lunar.json", solarLunarEntries);

        // Write sixty_cycle.json
        writeJson(outputDir + "sixty_cycle.json", sixtyCycleEntries);

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
                        "  {\"solar\":\"%s\",\"sixtyCycleYear\":\"%s\",\"sixtyCycleMonth\":\"%s\",\"sixtyCycleDay\":\"%s\"}",
                        e.solar, e.sixtyCycleYear, e.sixtyCycleMonth, e.sixtyCycleDay
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
