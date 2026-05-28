@startuml problem_storage_model
title Model perzistentného záznamu problému

skinparam classAttributeIconSize 0
hide circle

class "Záznam problému" as ProblemRecord <<relačná tabuľka>> {
  identifikátor : identifikátor
  názov : krátky text
  opis : text
  typ problému : krátky text
  zvolený solver : voliteľný krátky text
  vstupná inštancia : štruktúrované dáta
  interpretované riešenie : voliteľné štruktúrované dáta
  stav spracovania : krátky text
  výsledok splniteľnosti : krátky text
  surové priradenie premenných : zoznam celých čísel
  SAT kódovanie : voliteľný text
  čas vytvorenia : časový údaj
  čas poslednej zmeny : časový údaj
  začiatok riešenia : voliteľný časový údaj
  ukončenie riešenia : voliteľný časový údaj
  trvanie riešenia : voliteľné trvanie
}

class "Vstupná inštancia" as InstanceData <<štruktúrované dáta>>
class "Doménové riešenie" as SolutionData <<štruktúrované dáta>>
class "SAT kódovanie" as SatEncodingData <<textové kódovanie>>
class "Výstup solvera" as SolverAssignment <<zoznam hodnôt>>

ProblemRecord *-- "1" InstanceData : obsahuje
ProblemRecord *-- "0..1" SolutionData : obsahuje
ProblemRecord *-- "0..1" SatEncodingData : obsahuje
ProblemRecord *-- "0..1" SolverAssignment : uchováva

note right of ProblemRecord
Jeden záznam obsahuje metadáta, vstup,
stav riešenia, výsledok a časové údaje.
Návrh nezávisí od konkrétneho databázového systému.
end note

@enduml
