@startuml system_interfaces_use_cases
title Používateľské prípady použitia systému

left to right direction

actor "Používateľ" as User

rectangle "Systém na riešenie kombinatorických úloh" {
  usecase "Zadať problém" as SubmitProblem
  usecase "Spravovať evidované problémy" as ManageProblems
  usecase "Spustiť riešenie" as RequestSolving
  usecase "Sledovať priebeh riešenia" as TrackSolving
  usecase "Preskúmať SAT kódovanie" as InspectEncoding
  usecase "Zobraziť výsledok" as ViewResult
}

User --> SubmitProblem
User --> ManageProblems
User --> RequestSolving
User --> TrackSolving
User --> InspectEncoding
User --> ViewResult

InspectEncoding ..> TrackSolving : voliteľné pri kontrole riešenia
ViewResult ..> TrackSolving : po dokončení riešenia

@enduml
