@startuml raijin_system_context
title Komponenty systému a ich rozhrania

skinparam componentStyle rectangle

component "Používateľské\nrozhranie" as UI
component "Reverzný proxy" as Proxy
component "Aplikačné rozhranie\npre kombinatorické úlohy" as Api
component "Riešiaci pracovník" as Worker
database "Úložisko\nproblémov" as Store
component "SAT solver" as Solver <<external>>

interface "Webové požiadavky" as IWeb
interface "Operácie nad problémami" as Ops
interface "Prístup k problémom" as StoreAccess
interface "Rozhranie solvera" as ISolver

UI --> IWeb : používa
IWeb - Proxy : poskytuje
Proxy --> Ops : smeruje volania
Ops - Api : poskytuje

Api --> StoreAccess : číta a zapisuje
Worker --> StoreAccess : preberá čakajúce úlohy
StoreAccess - Store : poskytuje stav

Worker --> ISolver : volá
ISolver - Solver : vyhodnocuje SAT kódovanie

@enduml
