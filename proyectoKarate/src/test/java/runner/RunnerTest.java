package runner;

import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.ReportBuilder;
import net.masterthought.cucumber.Configuration;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.TestInstance;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class RunnerTest {

    @BeforeAll
    public static void setup() {
        // Define la carpetas para reporte Karate Lab y Cucumber
        System.setProperty("karate.output.dir", "reportsKarate");
        System.setProperty("karate.output.dir", "reportsCucumber");
        System.out.println("Configurando directorio de para reportes");
    }

    @Karate.Test
    Karate testAllFeatures() {
        System.out.println("🎯 Iniciando ejecución de pruebas Karate...");
        return Karate.run(
                        "classpath:features/crearPet.feature",
                        "classpath:features/buscarPetID.feature",
                        "classpath:features/actualizarPetNameStatus.feature",
                        "classpath:features/buscarPetActualizadoStatus.feature"
                )
                .outputCucumberJson(true)    // Generación JSON
                .outputHtmlReport(true)      // Reporte Karate HTML
                .relativeTo(getClass());     // JUnit 5 fundamental
    }

    @AfterAll
    public static void afterAll() {

        System.out.println("Inician Generación de REPORTES.................");

        String userDir = System.getProperty("user.dir").replace("\\", "/");
        System.out.println("\n=========================================================== REPORTES DE PRUEBA ===========================================================");

        String karateOutputDir = userDir + "/reportsKarate/karate-reports";
        String cucumberOutputDir = userDir + "/reportsCucumber/cucumber-html-reports";
        // Obtiene la dirección absoluta del reporte de karate
        File karateDir = new File(karateOutputDir);
        System.out.println("Directorio de Karate: " + karateDir.getAbsolutePath());
        System.out.println("Existe el directorio?: " + karateDir.exists());

        if (karateDir.exists()) {
            File[] files = karateDir.listFiles();
            if (files != null && files.length > 0) {
                System.out.println("Archivos encontrados en karate-reports:");
                for (File file : files) {
                    System.out.println("   - " + file.getName() + " (" + file.length() + " bytes)");
                }
            } else {
                System.out.println("El directorio existe pero está vacío");
                return;
            }
        } else {
            System.out.println(" El directorio karate-reports NO existe");
            return;
        }

        try {
            // Generar reporte Cucumber HTML
            File reportOutputDir = new File(cucumberOutputDir);

            // Busca todos los archivos .json recursivamente karate-reports
            Collection<File> jsonFiles = FileUtils.listFiles(
                    new File(karateOutputDir),
                    new String[]{"json"},
                    true
            );

            System.out.println("Archivos JSON encontrados: " + jsonFiles.size());

            if (jsonFiles.isEmpty()) {
                System.out.println("No se encontraron archivos JSON para generar reportes");
                return;
            }

            List<String> jsonPaths = new ArrayList<>();
            for (File file : jsonFiles) {
                jsonPaths.add(file.getAbsolutePath());
                System.out.println("Procesando: " + file.getName());
            }

            //Donde guardar el reporte y el titulo
            Configuration config = new Configuration(reportOutputDir, "Karate Test Report");

            //Constructor de reporte y construye el reporte
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
            reportBuilder.generateReports();

            System.out.println();
            System.out.println("Karate Labs: file:///" + userDir + "/reportsKarate/karate-reports/karate-summary.html");
            System.out.println("Cucumber HTML: file:///" + cucumberOutputDir + "/cucumber-html-reports/overview-features.html");
            System.out.println();
            System.out.println();

        } catch (Exception e) {
            System.err.println(" Error al generar reporte Cucumber: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("===========================================================================================================================================");
    }
}