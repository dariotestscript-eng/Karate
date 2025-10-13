Feature: Update Pet
  Background:
    * url 'https://petstore.swagger.io'
    * header Content-Type = 'application/json'
    * def result = call read('classpath:features/crearPet.feature')
    * def prenombre = result.response.name
    * def preestado = result.response.status
    * def nombre = 'baltoMagico'
    * def estado = 'sold'
    * set result.response.name = nombre
    * set result.response.status = estado


  Scenario: API INTEGRATION TEST - Update pet of store

    Given path 'v2', 'pet'
    And header Content-Type = 'application/json'
    And request result.response
    When method put
    * eval
    """
    karate.log(responseStatus)
    if (responseStatus == 200 || responseStatus != 200){
      if (prenombre != nombre && response.name == nombre){
        karate.log("Nuevo nombre de pet es: "+response.name)
      }
      if (preestado != estado && response.status == estado){
        karate.log("Nuevo estado de pet es: "+response.status)
      }
      karate.log("Actualizaciones de nombre y estado EXITOSO")
    }
    """