Feature: Creat Pet API

  Background:

    * header Content-Type = 'application/json'
    * def bodyS = read('classpath:datos/bodyAdd.json')
    * set bodyS.id = id
    * set bodyS.name = name
    * set bodyS.status = status


  Scenario: Create a new pet
    Given url baseUrl + '/pet'
    And request bodyS
    When method post
    * eval
    """
    if (responseStatus == 200) {

      // Validación
      if (response.id == id) {
        karate.log('ID correcto');
      }else{
        karate.log("ID incorrecto")
      }
      if (typeof response.status === 'string') {
        karate.log('Status es String');
      }else{
        karate.log("Status no es String")
      }
      if (typeof response.id === 'number') {
        karate.log('ID es númerico');
      }else{
        karate.log("ID incorrecto")
      }
    }else{
      karate.log('API es inestable')
    }
    """