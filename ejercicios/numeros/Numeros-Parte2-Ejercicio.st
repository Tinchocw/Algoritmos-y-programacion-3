!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:12:57'!
* aMultiplier

	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:12:59'!
+ anAdder

	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:13:02'!
- aSubtrahend

	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:13:04'!
/ aDivisor

	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:13:37'!
dividiUnEntero: enteroDividendo
	
	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:13:51'!
dividiUnaFraccion: fraccionDIvidendo
	
	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:14:29'!
multiplicaUnEntero: enteroMultiplicador

	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:14:42'!
multiplicaUnaFraccion: fraccionMultiplicador

	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:15:55'!
restateAUnEntero: enteroMinuendo

	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:16:06'!
restateAUnaFraccion: fraccionMinuendo

	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:15:24'!
sumateAUnEntero: enteroSumando

	self subclassResponsibility .! !

!Numero methodsFor: 'privado' stamp: 'JMPO 4/30/2023 16:15:42'!
sumateAUnaFraccion: fraccionSumando
	
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 5/2/2023 12:48:14'!
dividiUnEntero: enteroDividendo

	"Los nombres dividi, multiplica, sumate, restate tienen a los verbos conjugados de esa forma para hacer referencia a que el objeto desde el que se están
	llamando se encuentra no del lado derecho de la operación sino del lado izquierdo. Nos pareció un buen criterio."

	^Fraccion with: enteroDividendo over: self .! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:13:51'!
dividiUnaFraccion: fraccionDividendo

	^Fraccion with: fraccionDividendo numerator over: self * fraccionDividendo denominator .
		
	! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 5/2/2023 12:37:50'!
multiplicaUnEntero: enteroMultiplicador
	
	^self class with: value * enteroMultiplicador integerValue .! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 5/2/2023 12:37:55'!
multiplicaUnaFraccion: fraccionMultiplicador

	^fraccionMultiplicador class with: self * fraccionMultiplicador numerator over: fraccionMultiplicador denominator . ! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:39:01'!
restateAUnEntero: enteroMinuendo
	
	^self class with: enteroMinuendo integerValue - value .! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:16:07'!
restateAUnaFraccion: fraccionMinuendo
	
	^(fraccionMinuendo numerator - (self * fraccionMinuendo denominator)) / fraccionMinuendo denominator .! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 5/2/2023 12:38:05'!
sumateAUnEntero: enteroSumando

	^self class with: value + enteroSumando integerValue .! !

!Entero methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:15:42'!
sumateAUnaFraccion: fraccionSumando

	^(self * fraccionSumando denominator + fraccionSumando numerator) / fraccionSumando denominator .! !


!Entero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:14:29'!
* aMultiplier 
	
	^aMultiplier multiplicaUnEntero: self .
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMPO 5/2/2023 12:37:28'!
+ anAdder 
	
	^anAdder sumateAUnEntero: self .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:15:55'!
- aSubtrahend 

	^aSubtrahend restateAUnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:13:37'!
/ aDivisor 
	
	^aDivisor dividiUnEntero: self .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:33:01'!
fibonacci

	self subclassResponsibility .! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:51:46'!
isNegative
	
	self subclassResponsibility .! !

!Entero methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:51:58'!
isOne
	
	self subclassResponsibility .! !

!Entero methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:52:06'!
isZero
	
	self subclassResponsibility .! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'JMPO 5/2/2023 12:43:53'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	"
	Entero subclassesDo: [
		:unaSubclaseDeEntero | (unaSubclaseDeEntero numeroEstaEnElIntervalo: aValue )
		ifTrue: [^unaSubclaseDeEntero new initializeWith: aValue ]
		]."
			
	"Devolver excepcion"
	
	"Implemetamos el switch dinamico en un principio con Do:, no obstante nos terminamos inclinando hacia usar detect: ya que de no encontrar una subclase cuyo método
	puedeRepresentarA: devuelva true el detect: mismo hace return de la excepción errorNotFound."
	
	
	^(Entero subclasses detect:[
		:unaSubclaseDeEntero | unaSubclaseDeEntero puedeRepresentarA: aValue ] ) new initializeWith: aValue.! !


!Entero class methodsFor: 'privado' stamp: 'JMPO 5/2/2023 12:45:46'!
puedeRepresentarA: numeroAAnalizar
	
	"El nombre puedeRepresentarA: refiere a que dicha subclase de entero es capaz de representar el small integer recibido como colaborador externo
	Nos fue dificil encontrar un nombre descriptivo para la ĺógica que buscabamos pero nos terminamos decidiendo por este al leer como quedaba en el switch dinámico."
	
	self subclassResponsibility .! !


!classDefinition: #EnteroCero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:35:55'!
fibonacci
	
	^self class with: 1.! !


!EnteroCero methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:53:03'!
isNegative

	^false! !

!EnteroCero methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:53:07'!
isOne

	^false! !

!EnteroCero methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:52:24'!
isZero

	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCero class' category: 'Numeros-Parte2-Ejercicio'!
EnteroCero class
	instanceVariableNames: ''!

!EnteroCero class methodsFor: 'privado' stamp: 'MC 5/1/2023 11:59:14'!
puedeRepresentarA: numeroAAnalizar ":"

	^numeroAAnalizar = 0.! !


!classDefinition: #EnteroMayorAUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:34:14'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^(self - one) fibonacci + (self - two) fibonacci! !


!EnteroMayorAUno methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:54:35'!
isNegative
	
	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:54:50'!
isOne
	 
	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:54:20'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numeros-Parte2-Ejercicio'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'privado' stamp: 'MC 5/1/2023 11:59:14'!
puedeRepresentarA: numeroAAnalizar
	
	^numeroAAnalizar > 1.! !


!classDefinition: #EnteroNegativo category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:35:45'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription! !


!EnteroNegativo methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:55:27'!
isNegative
	
	^true! !

!EnteroNegativo methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:55:35'!
isOne
	
	^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:55:16'!
isZero
	
	^false ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numeros-Parte2-Ejercicio'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'privado' stamp: 'MC 5/1/2023 11:59:14'!
puedeRepresentarA: numeroAAnalizar
	
	^ numeroAAnalizar < 0.! !


!classDefinition: #EnteroUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:36:55'!
fibonacci
	
	^self class with: 1.! !


!EnteroUno methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:56:11'!
isNegative
	
	^false! !

!EnteroUno methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:55:52'!
isOne
	 
	^true! !

!EnteroUno methodsFor: 'testing' stamp: 'JMPO 4/30/2023 16:56:02'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroUno class' category: 'Numeros-Parte2-Ejercicio'!
EnteroUno class
	instanceVariableNames: ''!

!EnteroUno class methodsFor: 'privado' stamp: 'MC 5/1/2023 11:59:14'!
puedeRepresentarA: numeroAAnalizar

	^numeroAAnalizar = 1.! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMPO 5/2/2023 12:38:47'!
* aMultiplier 
	
	^aMultiplier multiplicaUnaFraccion: self .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMPO 5/2/2023 12:38:52'!
+ anAdder 

	^anAdder sumateAUnaFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:16:07'!
- aSubtrahend 
	
	^aSubtrahend restateAUnaFraccion: self .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMPO 4/30/2023 16:13:51'!
/ aDivisor 
	
	^aDivisor dividiUnaFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:13:37'!
dividiUnEntero: enteroDividendo
	
	^(enteroDividendo * denominator ) / ( numerator ) .! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 5/2/2023 12:39:06'!
dividiUnaFraccion: fraccionDividendo
	
	^self class with: (denominator * fraccionDividendo numerator ) over: (numerator * fraccionDividendo denominator ) .! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:14:29'!
multiplicaUnEntero: enteroMultiplicador

	^(self class with: enteroMultiplicador * self numerator over: self denominator ) .! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:14:42'!
multiplicaUnaFraccion: fraccionMultiplicador
	
	^(numerator * fraccionMultiplicador numerator) / (denominator * fraccionMultiplicador denominator) .! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:15:55'!
restateAUnEntero: enteroMinuendo
	
	^self class with: ((enteroMinuendo * denominator) - numerator) over: denominator .! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:16:07'!
restateAUnaFraccion: fraccionMinuendo

	| newNumerator newDenominator |
	
	newNumerator := (fraccionMinuendo numerator * denominator) - (numerator * fraccionMinuendo denominator ).
	newDenominator := denominator * fraccionMinuendo denominator. 
	
	^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:15:24'!
sumateAUnEntero: enteroSumando

	^((enteroSumando * self denominator + self numerator) / self denominator) .! !

!Fraccion methodsFor: 'DD-operaciones' stamp: 'JMPO 4/30/2023 16:15:42'!
sumateAUnaFraccion: fraccionSumando

	| newNumerator newDenominator |
	
	newNumerator := (numerator * fraccionSumando denominator) + (denominator * fraccionSumando numerator).
	newDenominator := denominator * fraccionSumando denominator.
	
	^(newNumerator / newDenominator) .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
