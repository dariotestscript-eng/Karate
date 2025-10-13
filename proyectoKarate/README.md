# 🐾 Proyecto API Testing – PetStore con Karate Framework + Gradle


## 1️⃣ Prerrequisitos


A continuación se detallan los requerimientos técnicos y versiones necesarias para ejecutar correctamente el proyecto en el entorno local:

|      Tecnología       |                     Versión recomendada                        | 
|-----------------------|----------------------------------------------------------------|
| **Sistema operativo** | Windows 10/11 (x64)                                            | 
| **IDE**               | Intellij IDEA (Community Edition 2024.3.5)                     | 
| **Java JDK**          | 17 o superior                                                  |
| **Gradle**            | Versión 7.6.1                                                  | 
|----------------------------------------------------------------------------------------|
|**Frameworks**         | Karate Framework: 1.4.1                                        |
|**Librerías**          | JUnit: 5.9.2                                                   |
|----------------------------------------------------------------------------------------|

📂 **Sitio de referencia API:** [https://petstore.swagger.io/]


---

## 2️⃣ Comandos de instalación


Ejecutar los siguientes comandos desde la raíz del proyecto para descargar y configurar todas las dependencias necesarias.

🚨 <span style="color:red">**Nota importante:**</span>  
> Si con anterioridad se descargo el repositorio no volver ha hacerlo.

> La unidad debe ser donde se descargó el repositorio

> **Ejemplos:**
> - Unidad **C:** `dir /s /ad C:\*proyectoKarate*`  
> - Unidad **D:** `dir /s /b D:\*proyectoKarate*`

El resultado del anterior comando utilizarlo con cd para cambiar a la carpeta proyectoKarate.


### 🔹 Clonar el repositorio
Previamente presiona Win + R, escribe cmd y da Enter → abre Command Prompt (CMD)
```bash
git clone https://github.com/dariotestscript-eng/ejerciciosReto.git
cd proyectoKarate
```

---


## 3️⃣ Instrucciones para ejecutar los tests


🔸 **Paso 1. Verificar configuración del entorno**  

Asegúrate de que las variables de entorno `JAVA_HOME` y `GRADLE_HOME` estén correctamente configuradas y que Gradle reconozca la versión 7.6.1 y JDK 17 por ejemplo: 7.0.16


🔸 **Paso 2. Descargar dependencias del proyecto y Ejecutar las pruebas automatizadas**
```bash
gradlew clean test --tests "RunnerTest"
```
Otra alternativa, puede ser:

```bash
gradlew clean test
```

🔸 **Paso 3. Generar y visualizar los reportes de ejecución**  

El proyecto utiliza reporte nativo de **Cucumber** y **Karate Lab**

- 📁 **Reporte Cucumber:** `reportsCucumber/cucumber-html-reports/cucumber-html-reports/overview-features.html`


Para abrir el reporte en el navegador:
```bash
start reportsCucumber/cucumber-html-reports/cucumber-html-reports/overview-features.html
```


- 📁 **Reporte Karate Lab:** `reportsKarate/karate-reports/karate-summary.html`


Para abrir el reporte en el navegador:
```bash
start reportsKarate/karate-reports/karate-summary.html
```

---


## 4️⃣ Información adicional

### Objetivo el Ejercicio

Automatizar pruebas de la API de PetStore utilizando Karate Framework, parametrizando los datos desde un archivo JSON, con el fin de validar operaciones CRUD de mascotas y visualizar los resultados directamente en consola.

### 📘 Flujo de pruebas automatizadas

- Añadir una mascota a la tienda
- Consultar la mascota ingresada previamente (Búsqueda por ID)
- Actualizar nombre y estatus de la mascota a “sold”
- Consultar la mascota modificada por estatus (Búsqueda por estatus)

### 📂 Datos parametrizados por JSON

Los datos utilizados en el formulario de compra se obtienen de un archivo JSON ubicado en:


```
src/test/resources/datos/bodyAdd.json
```


#### Ejemplo de estructura JSON (cualquiera):

```json
{
  "nombre": "Dario",
  "apellido": "QA",
  "codigoPostal": "593"
}
```


---

### Estructura de Proyecto

```
proyectoKarate/
├── build.gradle
├── README.md
├── conclusiones.txt
├── reportsKarate/
│   └── karate-reports/
│       └── karate-summary.html
├── reportsCucumber/
│   └── cucumber-html-reports/
│       └── cucumber-html-reports/
│           └── overview-features.html
└── src
    ├── main
    │   └── java
    │
    └── test
        ├── java
        │   └── com/proyectoKarate
        │       ├── runners
        │       │   └── RunnerTest.java
        │
        └── resources
            ├── features
            │   ├── crearPet.feature
            │   ├── buscarPetID.feature
            │   ├── actualizarPetNameStatus.feature
            │   └── buscarPetActualizadoStatus.feature
            │
            ├── datos
            │   └── bodyAdd.json

```
---


### 🧠 Observaciones

- Proyecto desarrollado en IntelliJ IDEA, con Gradle 7.6.1 y JDK 17.  
- Datos de entrada leídos desde archivos JSON.  
- Generación de reportes en Cucumber.  
- Flujo API validado exitosamente.


---


### 👤 Autor
**Nombre:** *Darío Javier Sotalín Pillajo*  
**Rol:** Analista QA 
**Repositorio GitHub:** [https://github.com/dariotestscript-eng/ejerciciosReto.git] 

