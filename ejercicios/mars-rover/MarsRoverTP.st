!classDefinition: #ComandoInvalido category: 'MarsRoverTP'!
Error subclass: #ComandoInvalido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ComandoInvalido class' category: 'MarsRoverTP'!
ComandoInvalido class
	instanceVariableNames: ''!

!ComandoInvalido class methodsFor: 'signal' stamp: 'JMPO 5/26/2023 17:49:14'!
signal
	
	self signal: 'Error!! Comando inválido'.! !


!classDefinition: #MarsRoverTest category: 'MarsRoverTP'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!MarsRoverTest methodsFor: 'test' stamp: 'JMPO 5/27/2023 16:36:30'!
test01ElMarsRecibeUnaOrdenNoValidaYFalla
	
	self should: [marsRoverTest ejecutarPaqueteDeComandos: 'z'] raise: ComandoInvalido.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'JMPO 5/27/2023 16:36:38'!
test02AlMarsSeLeOrdenaAvanzarYAvanza
	
	marsRoverTest ejecutarPaqueteDeComandos: 'f'.
	
	self assert: ((marsRoverTest posicionActual) = (0@1)).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JMPO 5/27/2023 16:36:43'!
test03AlMarsSeLeOrdenaRetrocederYRetrocede
	
	marsRoverTest ejecutarPaqueteDeComandos: 'b'.
	
	self assert: ((marsRoverTest posicionActual) = (0@-1)).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JMPO 5/27/2023 16:36:46'!
test04AlMarsSeLeOrdenaRotarHaciaLaDerechaYRota
	
	marsRoverTest ejecutarPaqueteDeComandos: 'r'.
	
	self assert: (marsRoverTest apuntaAlEste).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JMPO 5/27/2023 16:36:49'!
test05AlMarsSeLeOrdenaRotarHaciaLaIzquierdaYRota
	
	marsRoverTest ejecutarPaqueteDeComandos: 'l'.
	
	self assert: (marsRoverTest apuntaAlOeste).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JMPO 5/27/2023 16:42:05'!
test06MarsRecibeUnPaqueteDeOrdenesYLasEjecuta
	
	marsRoverTest ejecutarPaqueteDeComandos: 'flllf'.
	
	"0,1 ---> Izquierda x3 (Mira hacia Este) ---> 1,1"
	
	self assert: (marsRoverTest apuntaAlEste ).
	self assert: (marsRoverTest posicionActual = (1@1)).! !


!MarsRoverTest methodsFor: 'test-NoTDD' stamp: 'JMPO 5/29/2023 15:27:52'!
test07MarsRecibeUnPaqueteDeOrdenesVariadas
	
	marsRoverTest ejecutarPaqueteDeComandos: 'frrrfffb'.
	
	"0,1 ---> Derecha x3 (Mira hacia Oeste) ---> -2,1"
	
	self assert: (marsRoverTest apuntaAlOeste ).
	self assert: (marsRoverTest posicionActual = (-2@1)).! !

!MarsRoverTest methodsFor: 'test-NoTDD' stamp: 'JMPO 5/29/2023 15:31:43'!
test08MarsRecibeUnPaqueteDeOrdenesYEjecutoHastaLlegarUnaInvalida
	
	"0,1 ---> Derecha x3 (Mira hacia Oeste) ---> -3,1 ---> falla y no sigue"
	
	self should: [marsRoverTest ejecutarPaqueteDeComandos: 'frrrfffzbbb'.] raise: ComandoInvalido.
	self assert: (marsRoverTest apuntaAlOeste ).
	self assert: (marsRoverTest posicionActual = (-3@1)).! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'JMPO 5/26/2023 18:27:03'!
setUp
	
	marsRoverTest := MarsRover new initialize.! !


!classDefinition: #MarsRover category: 'MarsRoverTP'!
Object subclass: #MarsRover
	instanceVariableNames: 'sistemaDeGps'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!MarsRover methodsFor: 'comandos' stamp: 'JMPO 5/27/2023 16:28:30'!
ejecutarPaqueteDeComandos: unPaqueteDeComandos

	unPaqueteDeComandos do: [:unComando | self ejecutarComando: unComando ].! !


!MarsRover methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:09:13'!
apuntaAlEste
	
	^sistemaDeGps apuntaAlEste .! !

!MarsRover methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:09:21'!
apuntaAlOeste
	
	^sistemaDeGps apuntaAlOeste .! !


!MarsRover methodsFor: 'private' stamp: 'JMPO 5/27/2023 18:13:29'!
ejecutarComando: unaOrden

	(unaOrden = $f) ifTrue: [
			^sistemaDeGps fijarCoordenadasParaAvanzar .
			].
		
	(unaOrden = $b) ifTrue: [
			^sistemaDeGps fijarCoordenadasParaRetroceder .
			].
		
	(unaOrden = $r) ifTrue: [
			^sistemaDeGps := sistemaDeGps girarOrientacionHaciaLaDerecha .
			].
	
	(unaOrden = $l) ifTrue: [
			^sistemaDeGps := sistemaDeGps girarOrientacionHaciaLaIzquierda .
			].
	
	^ComandoInvalido signal.! !


!MarsRover methodsFor: 'accessing' stamp: 'JMPO 5/27/2023 17:52:11'!
posicionActual
	
	^sistemaDeGps coordenadasActuales.! !


!MarsRover methodsFor: 'initialization' stamp: 'JMPO 5/27/2023 18:17:20'!
initialize

	sistemaDeGps := SistemaDeGps protocoloDeInicio.! !


!classDefinition: #SistemaDeGps category: 'MarsRoverTP'!
Object subclass: #SistemaDeGps
	instanceVariableNames: 'coordenadaGeograficaActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!SistemaDeGps methodsFor: 'orientacion' stamp: 'JMPO 5/27/2023 17:33:24'!
girarOrientacionHaciaLaDerecha

	self subclassResponsibility! !

!SistemaDeGps methodsFor: 'orientacion' stamp: 'JMPO 5/27/2023 17:33:30'!
girarOrientacionHaciaLaIzquierda

	self subclassResponsibility! !


!SistemaDeGps methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:16'!
apuntaAlEste

	self subclassResponsibility! !

!SistemaDeGps methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:19'!
apuntaAlOeste

	self subclassResponsibility! !


!SistemaDeGps methodsFor: 'accessing' stamp: 'JMPO 5/29/2023 15:22:08'!
coordenadasActuales
	
	^coordenadaGeograficaActual.! !


!SistemaDeGps methodsFor: 'initialization' stamp: 'JMPO 5/29/2023 15:22:08'!
initializeWithCoordenadas: unaCoordenadaInicial
	
	coordenadaGeograficaActual := unaCoordenadaInicial .! !


!SistemaDeGps methodsFor: 'coordenadas' stamp: 'JMPO 5/27/2023 17:33:08'!
fijarCoordenadasParaAvanzar
	
	self subclassResponsibility .! !

!SistemaDeGps methodsFor: 'coordenadas' stamp: 'JMPO 5/27/2023 17:33:17'!
fijarCoordenadasParaRetroceder

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SistemaDeGps class' category: 'MarsRoverTP'!
SistemaDeGps class
	instanceVariableNames: ''!

!SistemaDeGps class methodsFor: 'as yet unclassified' stamp: 'JMPO 5/27/2023 17:56:18'!
protocoloDeInicio

	^GpsOrientacionNorte new initializeWithCoordenadas: (0@0).! !


!classDefinition: #GpsOrientacionEste category: 'MarsRoverTP'!
SistemaDeGps subclass: #GpsOrientacionEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!GpsOrientacionEste methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:26'!
apuntaAlEste
	
	^true.! !

!GpsOrientacionEste methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:31'!
apuntaAlOeste
	
	^false.! !


!GpsOrientacionEste methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaAvanzar
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x +1)@(coordenadaGeograficaActual y)).! !

!GpsOrientacionEste methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaRetroceder
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x -1)@(coordenadaGeograficaActual y)).! !


!GpsOrientacionEste methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaDerecha
	
	^GpsOrientacionSur new initializeWithCoordenadas: coordenadaGeograficaActual .! !

!GpsOrientacionEste methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaIzquierda
	
	^GpsOrientacionNorte new initializeWithCoordenadas: coordenadaGeograficaActual .! !


!classDefinition: #GpsOrientacionNorte category: 'MarsRoverTP'!
SistemaDeGps subclass: #GpsOrientacionNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!GpsOrientacionNorte methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:36'!
apuntaAlEste
	
	^false.! !

!GpsOrientacionNorte methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:40'!
apuntaAlOeste
	
	^false.! !


!GpsOrientacionNorte methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaAvanzar
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x)@(coordenadaGeograficaActual y +1)).! !

!GpsOrientacionNorte methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaRetroceder
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x)@(coordenadaGeograficaActual y -1)).! !


!GpsOrientacionNorte methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaDerecha
	
	^GpsOrientacionEste new initializeWithCoordenadas: coordenadaGeograficaActual .! !

!GpsOrientacionNorte methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaIzquierda
	
	^GpsOrientacionOeste new initializeWithCoordenadas: coordenadaGeograficaActual .! !


!classDefinition: #GpsOrientacionOeste category: 'MarsRoverTP'!
SistemaDeGps subclass: #GpsOrientacionOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!GpsOrientacionOeste methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:46'!
apuntaAlEste
	
	^false.! !

!GpsOrientacionOeste methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:50'!
apuntaAlOeste
	
	^true.! !


!GpsOrientacionOeste methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaAvanzar
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x -1)@(coordenadaGeograficaActual y))! !

!GpsOrientacionOeste methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaRetroceder
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x +1)@(coordenadaGeograficaActual y)).
	! !


!GpsOrientacionOeste methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaDerecha
	
	^GpsOrientacionNorte new initializeWithCoordenadas: coordenadaGeograficaActual .! !

!GpsOrientacionOeste methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaIzquierda
	
	^GpsOrientacionSur new initializeWithCoordenadas: coordenadaGeograficaActual .! !


!classDefinition: #GpsOrientacionSur category: 'MarsRoverTP'!
SistemaDeGps subclass: #GpsOrientacionSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTP'!

!GpsOrientacionSur methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:08:55'!
apuntaAlEste
	
	^false.! !

!GpsOrientacionSur methodsFor: 'testing' stamp: 'JMPO 5/27/2023 18:09:00'!
apuntaAlOeste
	
	^false.! !


!GpsOrientacionSur methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaAvanzar
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x)@(coordenadaGeograficaActual y -1)).! !

!GpsOrientacionSur methodsFor: 'coordenadas' stamp: 'JMPO 5/29/2023 15:22:08'!
fijarCoordenadasParaRetroceder
	
	coordenadaGeograficaActual := ((coordenadaGeograficaActual x)@(coordenadaGeograficaActual y +1)).! !


!GpsOrientacionSur methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaDerecha
	
	^GpsOrientacionOeste new initializeWithCoordenadas: coordenadaGeograficaActual .! !

!GpsOrientacionSur methodsFor: 'orientacion' stamp: 'JMPO 5/29/2023 15:22:08'!
girarOrientacionHaciaLaIzquierda
	
	^GpsOrientacionEste new initializeWithCoordenadas: coordenadaGeograficaActual .! !
