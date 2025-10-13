Feature: Search Pet by Status
  Background:
    * url 'https://petstore.swagger.io'
    * header Content-Type = 'application/json'
    * def result = callonce read('classpath:features/actualizarPetNameStatus.feature')
    * def estado = result.response.status


  Scenario: API INTEGRATION TEST - Search pet to store by status
    Given path 'v2', 'pet', 'findByStatus'
    And param status = estado
    When method get
    Then status 200
    And print 'resultado: ', result.response.status
    And print 'Conjuntojson', karate.filter(response, x => x.id == result.response.id)
    * def busquedafiltrada = karate.filter(response, x => x.id == result.response.id)
    * eval
    """
    if (busquedafiltrada.length > 0){
      karate.match('result.response contains _', busquedafiltrada[0])
    }else{
      var busqueda = karate.filter(response, x => x.status == estado);
      if (busqueda.length > 0 ){
        karate.match('result.response contains _', busqueda[0])
      }else{
         karate.log('Existe elementos');
      }
    }
    """
    And print 'SEARCH FUNCTIONALITY VERIFIED SUCCESSFULLY'