1) Aporte de los mensajes de DD

La cantidad de mensajes polimórficos dentro de un único DD es equitativa a la cantidad de subclases sobre las que se quiera aplicar polimorfismo. Por ejemplo, siguiendo la lógica del paper leído para
la semana pasada, por cada figura geométrica los objetos gráficos tenían que tener implementado un mensaje polimórfico específico para ser capaces de graficar dicha figura. 
La información que aporta un mensaje de DD es básicamente la subclase del colaborador externo con el que trabajaba el método. Previamente esa información se debía preguntarse con ifs.


2) Lógica de instanciado

La lógica de instanciado debería estar implementada en los métodos de clase, ya que justamente previo al instanciamiento no hay objeto/instancia de clase, por lo que es conflictuante que la lógica de creación este en los métodos que sabe responder un objeto ya instanciado.
Si se necesita instanciar un mismo objeto en diferentes contextos o de diferentes formas se pueden programar varios protocolos de instanciación, parecido a como en clase instanciabamos al auto con diferentes frenos aprovechando diferentes mensajes.

3) Criterio para categorizar métodos

El criterio usado para categorizar métodos es el de agrupar métodos que compartan un mismo enfoque/lógica y colocarlos en una misma categoría con un nombre que describa esto mismo. En el caso de que los métodos de una clase pertenezcan al protocolo interno de esta, una buena práctica es categorizarlos como privados.

4) Subclass Responsability

La razón de ser de la implementación del mensaje "self sublclassResponsability" es la de facilitar el reconocer casos donde se esté llamando a un método de la superclase en vez de una de las subclases correspondientes. Por ejemplo, si llamasemos a el operador "+" enviando un mensaje a un objeto de tipo Numero (En vez de Entero o Fracción) se nos devolvería el error "subclass should have overriden", siendo más facil reconocer el problema en la implementación.

5) Rupturas de encapsulamiento

Las rupturas de encapsulamiento pueden llegar a incurrir en dos problemas principales:

- Modificaciones de estado del objeto: Al conocer u operar con colaboradores internos de un objeto desde otro puede llegar a darse el caso en el que modifique alguno de estos desde un método externo.

- Sobreacoplamiento: Cuantos más métodos dentro del protocolo de un objeto rompan encapsulamiento de otro, más acoplamiento va a haber entre ambos, lo que lleva a que modificar una parte de la lógica de uno interfiera la lógica del otro, obligandome a modificar ambos comportamientos cuando deberían ser independientes entre si.