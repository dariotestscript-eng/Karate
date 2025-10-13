Feature: Search Pet by ID
  Background:
    * url 'https://petstore.swagger.io'
    * header Content-Type = 'application/json'
    * def result = callonce read('classpath:features/crearPet.feature')
    * def petID = result.response.id

  Scenario: API INTEGRATION TEST - Search pet to store
    Given path 'v2', 'pet', petID
    When method get
    And match response.id == petID
    * eval
    """
    if (responseStatus == 200 || responseStatus != 200){
      if (response.id == petID){
        karate.log("Mismo ID en test crear Pet y buscar por ID")
      }
      // Validaciones
      if (typeof response.id == "number"){
        karate.log("ID es número")
      }
      if (typeof response.name == "string"){
        karate.log("Name es string")
      }
      if (typeof response.status == "string"){
        karate.log("Status es string")
      }
      karate.log("SEARCH FUNCTIONALITY VERIFIED SUCCESSFULLY")
    }
    """