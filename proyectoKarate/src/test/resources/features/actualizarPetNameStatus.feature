Feature: Update Pet

  Scenario: API INTEGRATION TEST - Update pet of store

    * def updatePayload =
      """
      {
        "id": #(id),
        "name": "#(newName)",
        "status": "#(newStatus)"
      }
      """

    Given url baseUrl + '/pet/'
    And header Content-Type = 'application/json'
    And request updatePayload
    When method put
    * eval
    """
    if (responseStatus == 200 ){
      if (response.name == newName){
        karate.log("Nuevo nombre de pet es: "+response.name)
      }else{
        karate.log("Inconsistencia de nombre")
      }
      if (response.status == newStatus){
        karate.log("Nuevo estado de pet es: "+response.status)
      }else{
        karate.log("Inconsistencia de estado")
      }
      karate.log("Actualizaciones de nombre y estado EXITOSO")
    }else{
      karate.log("Inestabilidad en el endpoint")
    }
    """