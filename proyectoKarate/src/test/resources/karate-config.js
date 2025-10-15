
function fn() {
    var config = {
        baseUrl: 'https://petstore.swagger.io/v2',
        createdPets: []   // 👈 se agrega la lista global para guardar las mascotas creadas
    };

    // Configuración para ejecución selectiva por entorno
    if (karate.env === 'suite') {
        karate.configure('tags', ['@principal']);
    }

    // Configuración de tiempos de espera
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);

    return config;
}
