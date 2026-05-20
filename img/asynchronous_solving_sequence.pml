@startuml asynchronous_solving_sequence
title Sekvencia asynchrónneho riešenia problému

participant "Aplikačná\nčasť" as Api
database "Úložisko" as Store
participant "Riešiaci\npracovník" as Worker
participant "Doménový\nmodel" as Domain
participant "SAT riešiteľ" as Solver

Api -> Store: požiadavka na riešenie\nulož stav čaká na riešenie
Store --> Api: problém označený na riešenie

... požiadavka používateľa je ukončená ...

loop periodické spracovanie
  Worker -> Store: nájdi najstarší čakajúci problém\na vyhraď ho pre spracovanie
  Store --> Worker: problém alebo prázdny výsledok
end

alt existuje čakajúci problém
  Worker -> Domain: priprav SAT kódovanie\na označ začiatok riešenia
  Worker -> Store: ulož SAT kódovanie\na stav rieši sa
  Worker -> Solver: vyrieš SAT kódovanie
  Solver --> Worker: splniteľná/nesplniteľná,\nmodel, chyba alebo časový limit

  alt SAT
    Worker -> Domain: zapíš splniteľnosť\na interpretuj model
  else UNSAT
    Worker -> Domain: zapíš nesplniteľnosť
  else chyba
    Worker -> Domain: označ technické zlyhanie
  else časový limit
    Worker -> Domain: označ časové ukončenie
  end

  Worker -> Store: ulož finálny stav,\nsplniteľnosť a riešenie
else nie je čo riešiť
  Worker -> Worker: skonči aktuálny cyklus
end

@enduml
