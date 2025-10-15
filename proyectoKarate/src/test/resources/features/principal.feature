@principal
Feature: Flow complete of store PET

  Background:
    * def baseUrl = 'https://petstore.swagger.io/v2'

  Scenario Outline: CRUD complete of pet
    # Create Pet
    * def crear = call read('classpath:features/crearPet.feature') { id: <id>, name: '<name>', status: '<status>' }

    # Read Pet by ID
    * call read('classpath:features/buscarPetID.feature') { id: <id>, respuesta: crear}

    # Update Pet the name y status
    * def actualizar =  call read('classpath:features/actualizarPetNameStatus.feature') {id: <id>, newName: '<newName>', newStatus: '<newStatus>', respuesta: crear}

    # Read Pet by Status
    * call read('classpath:features/buscarPetActualizadoStatus.feature') {id: <id>, newStatus: '<newStatus>', respuesta: crear}

    Examples:
      | id         | name   | status    | newName | newStatus |
      | 1510202538 | Balto  | available | Thor    | sold      |
      | 1510204576 | Rocky  | pending   | Zeus    | sold      |
      | 1510208765 | Bruno  | stock     | Thor    | sold      |