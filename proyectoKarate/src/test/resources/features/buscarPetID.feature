Feature: Search Pet by ID
  Background:

    * header Content-Type = 'application/json'

  Scenario: API INTEGRATION TEST - Search pet to store
    Given url baseUrl + '/pet/' + id
    When method get
    * eval
    """
    if(responseStatus == 200){
      karate.log("Respuesta correcta")
      if(response.id == respuesta.id){
        karate.log("ID consistentes")
      }else{
        karate.log("ID inconsistentes")
      }
    }else{
      karate.log("Servidor tardo demasiado en responder")
    }
    """
