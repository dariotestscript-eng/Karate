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
        // SOLO un directorio de salida
        System.setProperty("karate.output.dir", "reportsKarate");
        System.out.println("Configurando directorio para reportes");
    }

    // CAMBIO: Usar tags en lugar de rutas específicas
    @Karate.Test
    Karate testSelectedFeatures() {
        System.out.println("🎯 Iniciando ejecución de pruebas Karate específicas...");
        return Karate.run()
                .path("classpath:features")
                .tags("@principal")  // ← SOLO ejecuta features con estos tags
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .relativeTo(getClass());
    }

    @AfterAll
    public static void afterAll() {
        generateReports();
    }

    public static void generateReports() {
        System.out.println("Iniciando Generación de REPORTES.................");

        String userDir = System.getProperty("user.dir").replace("\\", "/");
        System.out.println("\n=========================================================== REPORTES DE PRUEBA ===========================================================");

        String karateOutputDir = userDir + "/reportsKarate/karate-reports";
        String cucumberOutputDir = userDir + "/reportsCucumber/cucumber-html-reports";

        File karateDir = new File(karateOutputDir);
        System.out.println("Directorio de Karate: " + karateDir.getAbsolutePath());
        System.out.println("Existe el directorio?: " + karateDir.exists());

        if (!karateDir.exists()) {
            System.out.println(" El directorio karate-reports NO existe");
            return;
        }

        try {
            File reportOutputDir = new File(cucumberOutputDir);
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

            Configuration config = new Configuration(reportOutputDir, "Karate Test Report");
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
            reportBuilder.generateReports();

            System.out.println();
            System.out.println("Karate Labs: file:///" + userDir + "/reportsKarate/karate-reports/features.principal.html");
            System.out.println("Cucumber HTML: file:///" + cucumberOutputDir + "/cucumber-html-reports/overview-features.html");
            System.out.println();

        } catch (Exception e) {
            System.err.println(" Error al generar reporte Cucumber: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("===========================================================================================================================================");
    }
}