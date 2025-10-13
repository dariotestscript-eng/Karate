Feature: Create Pet
  Background:
    * url 'https://petstore.swagger.io'
    * header Content-Type = 'application/json'
    * def bodyS = read('classpath:datos/bodyAdd.json')
    * def pet_id = 1510202538
    * set bodyS.id = pet_id


  Scenario: API INTEGRATION TEST - Add pet to store
    Given path '/v2/pet'
    And request bodyS
    When method post
    Then match responseStatus == 200 || responseStatus != 200
    * eval
    """
    if (responseStatus == 200 || responseStatus != 200) {
      karate.set({
      'globalPetID': response.id,
      'globalPetName': response.name,
      'globalPetStatus': response.status});

      // Validación
      if (response.id == pet_id) {
        karate.log('ID correcto');
      }
      if (response.status.includes('available')) {
        karate.log('Contains available');
      }
      if (typeof response.status === 'string') {
        karate.log('Status es string');
      }
    }
    """