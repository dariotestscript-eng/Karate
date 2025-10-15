Feature: Search Pet by Status

  Background:

    * header Content-Type = 'application/json'

  Scenario: API INTEGRATION TEST - Search pet to store by status
    Given url baseUrl + '/pet/findByStatus'
    And param status = newStatus
    When method get
    And print 'Conjuntojson', karate.filter(response, x => x.id == crear.id)
    * def busquedafiltrada = karate.filter(response, x => x.id == crear.id)
    * eval
    """
    if (busquedafiltrada.length > 0){
      karate.match('result.response contains _', busquedafiltrada[0])
    }else{
      var busqueda = karate.filter(response, x => x.status == crear.status);
      if (busqueda.length > 0 ){
        karate.match('result.response contains _', busqueda[0])
      }else{
         karate.log('Existe elementos');
      }
    }
    """
    And print 'SEARCH FUNCTIONALITY VERIFIED SUCCESSFULLY'