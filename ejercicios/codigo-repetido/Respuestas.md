1) Al eliminar código repetido en los test 01 y 02 se podría hablar de una lógica potencialmente relevable a una clase ajena a los test. Esta lógica es el cronometrado de los mensajes. No obstante, debido a que tendríamos una clase con un solo mensaje implementado en su protocolo y que en primer lugar no tengo tanta necesidad de cronometrar para múltiples tests lo pensamos como una forma de sobre modelización. 


2) SmallTalk como todo lenguaje orientado a objetos permite la entificación de ideas y conceptos de la realidad a través de la implementación de clases. A su vez también SmallTalk es particularmente útil en la representación de entes de la reaidad a través de su interfaz gráfica, la cual permite observar la interacción entre objetos de forma más didactica.


3) Al sacar código repetido a través de una abstracción nueva estamos ayudando en dos aspectos principales asociados al texto de Peter Naur:
    - Mejorar la comprensión de nuestro modelo y su aplicabilidad con la realidad
    - Cubrir carencias de nuestro modelo. Toda situación donde repitamos código de manera refleja que el modelo no fue capaz de cubrir las funcionalidades asociadas a una lógica concreta.
