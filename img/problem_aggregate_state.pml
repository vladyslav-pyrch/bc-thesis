@startuml problem_aggregate_state
title Stavový model agregátu problému

[*] --> S0 : vytvorenie problému

state "Bez SAT kódovania\nsplniteľnosť nie je známa" as S0
state "Čaká na riešenie\nsplniteľnosť nie je známa" as S1
state "Rieši sa\nsplniteľnosť nie je známa" as S2
state "Dokončený problém\ninštancia je splniteľná\nriešenie je dostupné" as S3
state "Dokončený problém\ninštancia je nesplniteľná\nriešenie neexistuje" as S4
state "Spracovanie zlyhalo\nsplniteľnosť nie je známa" as S5
state "Vypršal časový limit\nsplniteľnosť nie je známa" as S6

S0 --> S1 : požiadavka na riešenie
S1 --> S2 : príprava SAT kódovania\na začiatok spracovania

S2 --> S3 : solver našiel model
S2 --> S4 : solver dokázal nesplniteľnosť
S2 --> S5 : technická chyba spracovania
S2 --> S6 : prekročenie časového limitu

S3 --> S1 : opätovné spustenie riešenia
S4 --> S1 : opätovné spustenie riešenia
S5 --> S1 : opätovné spustenie riešenia
S6 --> S1 : opätovné spustenie riešenia

@enduml
