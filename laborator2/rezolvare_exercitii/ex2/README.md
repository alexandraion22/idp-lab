# laborator-3

Contine sursele pentru o stiva de servicii de biblioteca ce ajuta la gestiunea cartilor, cu trei servicii custom:

- serviciul ApiGateway mediaza accesul cu lumea exterioara si forwardeaza cererile HTTP catre serviciul de carti
- serviciul Books se ocupa de partea de business logic ce tine de carti si apeleaza serviciul IO pentru date
- serviciul IO gestioneaza datele sistemului si comunica cu baza de date.