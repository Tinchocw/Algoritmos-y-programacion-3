!classDefinition: #AtacarTest category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
TestCase subclass: #AtacarTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
hacerQue: combatiente1 quedeMalDebidoA: combatiente2

	[combatiente1 puntosDeVida <= 0] whileFalse: [
		combatiente2 interactuarCon: combatiente1]! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 20:27:27'!
nuevoCombatienteHumanoide

	"^ Combatiente humanoide"
	^Humanoide new initialize.! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:22'!
test01CuandoUnCombatienteNoTieneEnemigosNoAtacaANadie
	| combatiente alguien |
	combatiente := self nuevoCombatienteHumanoide.
	alguien := self nuevoCombatienteHumanoide.
	
	combatiente interactuar.
	
	self assert: (alguien noEstaHerido).
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:22'!
test02CuandoUnCombatienteTieneEnemigosAtacaAUno
	| combatiente enemigo1 enemigo2 enemigo1Herido enemigo2Herido |
	combatiente := self nuevoCombatienteHumanoide.
	enemigo1 := self nuevoCombatienteHumanoide.
	enemigo2 := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigo1. enemigo2.}.
	
	combatiente interactuar.
	
	enemigo1Herido := enemigo1 estaHerido and: [enemigo2 noEstaHerido].
	enemigo2Herido := enemigo2 estaHerido and: [enemigo1 noEstaHerido].
	self assert: (enemigo1Herido or: [enemigo2Herido]).
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test03UnCombatientePuedeTenerComoEstrategiaAtacarAlMasHerido
	| combatiente enemigo1 enemigo2 enemigo2HeridoDosVeces |
	combatiente := self nuevoCombatienteHumanoide.
	enemigo1 := self nuevoCombatienteHumanoide.
	enemigo2 := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigo1. enemigo2.}.
	combatiente interactuarCon: enemigo2.
	
	combatiente focalizarEnElMasHerido.
	combatiente interactuar.
	
	enemigo2HeridoDosVeces := enemigo2 tienePuntosDeVida: 16 * pv.
	self assert: enemigo2HeridoDosVeces.
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test04UnCombatientePuedeTenerComoEstrategiaAtacarAlMasSano
	| combatiente enemigo1 enemigo2 elEnemigo1EstaHerido |
	combatiente := self nuevoCombatienteHumanoide.
	enemigo1 := self nuevoCombatienteHumanoide.
	enemigo2 := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigo1. enemigo2.}.
	combatiente interactuarCon: enemigo2.
	
	combatiente focalizarEnElMasSano.
	combatiente interactuar.
	
	elEnemigo1EstaHerido := enemigo1 tienePuntosDeVida: 18*pv.
	self assert: elEnemigo1EstaHerido.
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test05ElEnemigoFocalizadoMasSanoCambiaDinamicamente
	| combatiente enemigo1 enemigo2 |
	combatiente := self nuevoCombatienteHumanoide.
	enemigo1 := self nuevoCombatienteHumanoide.
	enemigo2 := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigo1. enemigo2.}.
	combatiente interactuarCon: enemigo2.

	combatiente equiparConUnaEspada.	
	combatiente focalizarEnElMasSano.
	combatiente interactuar.
	combatiente interactuar.
	
	self assert: (enemigo1 tienePuntosDeVida: 12*pv).
	self assert: (enemigo2 tienePuntosDeVida: 10*pv).
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test06ElEnemigoFocalizadoMasHeridoCambiaDinamicamente
	| combatiente enemigo1 enemigo2 |
	combatiente := self nuevoCombatienteHumanoide.
	enemigo1 := self nuevoCombatienteHumanoide.
	enemigo2 := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigo1. enemigo2.}.
	combatiente interactuarCon: enemigo2.

	combatiente equiparConUnaEspada.	
	combatiente focalizarEnElMasHerido.
	combatiente interactuar.
	combatiente interactuarCon: enemigo1.
	combatiente interactuarCon: enemigo1.
	combatiente interactuar.
	
	self assert: (enemigo1 tienePuntosDeVida: -4*pv).
	self assert: (enemigo2 tienePuntosDeVida: 10*pv).
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test07CuandoUnEnemigoEstaVencidoNoEsAtacadoMas
	| combatiente enemigoVencido enemigo2 |
	combatiente := self nuevoCombatienteHumanoide.
	enemigoVencido := self nuevoCombatienteHumanoide.
	enemigo2 := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigoVencido. enemigo2.}.
	combatiente equiparConUnaEspada.	
	combatiente interactuarCon: enemigoVencido.
	combatiente interactuarCon: enemigoVencido.
	combatiente interactuarCon: enemigoVencido.

	combatiente focalizarEnElMasHerido.
	combatiente interactuar.
	
	self assert: (enemigo2 tienePuntosDeVida: 12*pv).
	
	! !

!AtacarTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:22'!
test08CuandoUnCombatienteEstaVencidoNoAtaca
	| combatiente enemigo |
	combatiente := self nuevoCombatienteHumanoide.
	enemigo := self nuevoCombatienteHumanoide.
	combatiente enemigos: {enemigo}.
	self hacerQue: combatiente quedeMalDebidoA: enemigo.
	
	combatiente interactuar.
	
	self assert: (enemigo tienePuntosDeVida: 20*pv).
	
	! !


!classDefinition: #CombatesFantasticosTest category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
TestCase subclass: #CombatesFantasticosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!CombatesFantasticosTest methodsFor: 'tests' stamp: 'JMB 3/5/2023 21:52:13'!
test01UnDragonLeGanaA8CombatientesEn3Rondas
	| bandoCombatientes bandoDragon orquestador resultado |
	bandoDragon := {self nuevoCombatienteDragon}.
	bandoCombatientes := self ochoCombatientes.
	orquestador := OrquestadorDeCombates 	establecerCombateEntreBando1: bandoDragon contraBando2: bandoCombatientes.
	resultado := orquestador desarrollarDuranteRondas: 3.
	self assert: (resultado tieneDeGanadorAlBando1).! !

!CombatesFantasticosTest methodsFor: 'tests' stamp: 'JMB 3/5/2023 21:52:13'!
test02UnDragonLeGanaA8CombatientesArmados
	| bandoCombatientes bandoDragon orquestador resultado |
	bandoDragon := {self nuevoCombatienteDragon}.
	bandoCombatientes := self combatientesArmados: 8.
	orquestador := OrquestadorDeCombates 	establecerCombateEntreBando1: bandoDragon contraBando2: bandoCombatientes.
	resultado := orquestador desarrollarDuranteRondas: 10.
	self assert: (resultado tieneDeGanadorAlBando1).! !

!CombatesFantasticosTest methodsFor: 'tests' stamp: 'JMB 3/5/2023 21:52:13'!
test03UnDragonPierdeContra9CombatientesArmados
	| bandoCombatientes bandoDragon orquestador resultado |
	bandoDragon := {self nuevoCombatienteDragon}.
	bandoCombatientes := self combatientesArmados: 9.
	orquestador := OrquestadorDeCombates 	establecerCombateEntreBando1: bandoDragon contraBando2: bandoCombatientes.
	resultado := orquestador desarrollarDuranteRondas: 10.
	self assert: (resultado tieneDeGanadorAlBando2).! !

!CombatesFantasticosTest methodsFor: 'tests' stamp: 'JMB 3/5/2023 21:52:13'!
test04UnDragonContra4CuradoresNoTermina
	| bandoCuradores bandoDragon orquestador resultado |
	bandoDragon := {self nuevoCombatienteDragon}.
	bandoCuradores := self cuatroCuradores.
	orquestador := OrquestadorDeCombates 	establecerCombateEntreBando1: bandoDragon contraBando2: bandoCuradores.
	resultado := orquestador desarrollarDuranteRondas: 1000.
	self assert: resultado finalizoSinGanadores.! !


!CombatesFantasticosTest methodsFor: 'test-objects' stamp: 'JMB 3/5/2023 21:53:00'!
combatientesArmados: cantidad
	^(1 to: cantidad) collect: [ :numero |
		| combatiente |
		combatiente := self nuevoCombatienteHumanoide.
		combatiente equiparConUnaArmaduraDeCuero.
		combatiente equiparConUnaLanza.
		combatiente.
	].! !

!CombatesFantasticosTest methodsFor: 'test-objects' stamp: 'JMB 3/5/2023 21:52:34'!
cuatroCuradores
	^(1 to: 4) collect: [ :numero | self nuevoCombatienteCurador ].! !

!CombatesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:27:41'!
nuevoCombatienteCurador
	^Curador new initialize .! !

!CombatesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:27:45'!
nuevoCombatienteDragon
	^ Dragon  new initialize .! !

!CombatesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:27:49'!
nuevoCombatienteHumanoide
	^Humanoide new initialize ! !

!CombatesFantasticosTest methodsFor: 'test-objects' stamp: 'JMB 3/5/2023 21:53:00'!
ochoCombatientes
	^(1 to: 8) collect: [ :numero | self nuevoCombatienteHumanoide ].! !


!classDefinition: #CombatientesFantasticosTest category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
TestCase subclass: #CombatientesFantasticosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!CombatientesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:28:04'!
nuevoCombatienteCurador
	"^Combatiente curador."
	^ Curador new initialize.! !

!CombatientesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:28:10'!
nuevoCombatienteDragon
	^ Dragon new initialize.! !

!CombatientesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:28:16'!
nuevoCombatienteHumanoide

	^ Humanoide  new initialize.! !

!CombatientesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:28:23'!
nuevoCombatienteIlusionista
	^ Ilusionista  new initialize.! !

!CombatientesFantasticosTest methodsFor: 'test-objects' stamp: 'MC 5/16/2023 20:28:29'!
nuevoCombatienteOgro
	^Ogro new initialize.! !


!CombatientesFantasticosTest methodsFor: 'tests-01-puntos-de-vida-iniciales' stamp: 'JMB 3/4/2023 19:54:33'!
test01UnDragonComienzaCon200PuntosDeVida

	self assert: (self nuevoCombatienteDragon tienePuntosDeVida: 200 * pv).! !

!CombatientesFantasticosTest methodsFor: 'tests-01-puntos-de-vida-iniciales' stamp: 'MC 5/16/2023 18:43:06'!
test02UnIlusionistaComienzaCon20PuntosDeVida

	self assert: ( self nuevoCombatienteIlusionista tienePuntosDeVida: 20 * pv).! !

!CombatientesFantasticosTest methodsFor: 'tests-01-puntos-de-vida-iniciales' stamp: 'MC 5/16/2023 18:43:23'!
test03UnCuradorComienzaCon20PuntosDeVida

	self assert: (self nuevoCombatienteCurador tienePuntosDeVida: 20 * pv).! !

!CombatientesFantasticosTest methodsFor: 'tests-01-puntos-de-vida-iniciales' stamp: 'MC 5/16/2023 18:43:42'!
test04UnOgroComienzaCon60PuntosDeVida

	self assert: (self nuevoCombatienteOgro tienePuntosDeVida: 60 * pv).! !


!CombatientesFantasticosTest methodsFor: 'tests-02-dragon' stamp: 'MC 5/16/2023 21:21:22'!
test05UnDragonHace8DeDaño

	| dragon victima enemigos |
	dragon := self nuevoCombatienteDragon.
	victima := self nuevoCombatienteHumanoide.
	enemigos := {victima}.
	dragon enemigos: enemigos.
	
	dragon interactuar.
	
	self assertEnemigos: enemigos noEstanHeridos: 0  estanCon12PuntosDeVida: 1 ! !

!CombatientesFantasticosTest methodsFor: 'tests-02-dragon' stamp: 'MC 5/16/2023 21:21:22'!
test06UnDragonAtacaAMasDeUnEnemigo

	| dragon victima1 victima2 enemigos |
	dragon := self nuevoCombatienteDragon.
	victima1 := self nuevoCombatienteHumanoide.
	victima2 := self nuevoCombatienteHumanoide.
	enemigos := {victima1. victima2}.
	dragon enemigos: enemigos.
	
	dragon interactuar.
	self assertEnemigos: enemigos noEstanHeridos: 0  estanCon12PuntosDeVida: 2.
! !

!CombatientesFantasticosTest methodsFor: 'tests-02-dragon' stamp: 'MC 5/16/2023 21:21:21'!
test07UnDragonAtacaHastaUnMaximoDe8Enemigos

	| dragon enemigos |
	dragon := self nuevoCombatienteDragon.
	enemigos := 	(1 to: 9) collect: [ : unNumero | self nuevoCombatienteHumanoide ]. 
	dragon enemigos: enemigos.
	
	dragon interactuar.

	self assertEnemigos: enemigos  noEstanHeridos: 1  estanCon12PuntosDeVida: 8. ! !


!CombatientesFantasticosTest methodsFor: 'tests-03-curador' stamp: 'MC 5/16/2023 21:44:31'!
test08UnCuradorCura2DeDañoASusAliados
	| aliado enemigo aliados |
	aliado := self nuevoCombatienteHumanoide.	
	enemigo := self nuevoCombatienteHumanoide.
	enemigo enemigos: {aliado}.
	enemigo interactuar.
	enemigo interactuar.
	
	aliados := {aliado}.
	
	self assertCuradorSana: aliados dejandolosConLavidaEsperada: 18 * pv ! !

!CombatientesFantasticosTest methodsFor: 'tests-03-curador' stamp: 'MC 5/16/2023 18:52:22'!
test09UnCuradorNoCuraMasDeLosPuntosDeVidaIniciales
	| aliados |
	aliados := {self nuevoCombatienteDragon}.
	
	self assertCuradorSana: aliados dejandolosConLavidaEsperada: 200 * pv ! !

!CombatientesFantasticosTest methodsFor: 'tests-03-curador' stamp: 'MC 5/16/2023 21:47:42'!
test10UnCuradorCuraATodosSusAliados
	| aliados |
	aliados := (1 to: 10) collect: [ : unNumero | 
		| aliado enemigo |
		enemigo := self nuevoCombatienteHumanoide.
		aliado := self nuevoCombatienteHumanoide.
		enemigo enemigos: {aliado}.
		enemigo interactuar.
	].

	self assertCuradorSana: aliados dejandolosConLavidaEsperada: 20 * pv. ! !


!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-03-curador' stamp: 'MC 5/16/2023 21:21:22'!
test11UnCuradorNoDañaAUnEnemigo
	| curador enemigo |
	curador := self nuevoCombatienteCurador.
	enemigo := self nuevoCombatienteHumanoide.
	curador enemigos: {enemigo}.

	curador interactuar.
	
	self assert: enemigo noEstaHerido.! !


!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-04-ilusionista' stamp: 'MC 5/16/2023 21:21:22'!
test12UnIlusionistaContraUnSoloEnemigoNoHaceNada

	|  ilusionista enemigo |
	ilusionista := self nuevoCombatienteIlusionista .
	enemigo := self nuevoCombatienteHumanoide.
	ilusionista enemigos: {enemigo}.
	
	ilusionista interactuar.
	
	self assert: enemigo noEstaHerido.! !

!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-04-ilusionista' stamp: 'MC 5/16/2023 21:21:53'!
test13UnIlusionistaAlAtacarEngañaASusVictimasParaQueAtaquenAOtroEnemigo

	|  ilusionista enemigoEngañado enemigoASerAtacadoPorElEngañado |
	ilusionista := self nuevoCombatienteIlusionista .
	enemigoEngañado := self nuevoCombatienteHumanoide.
	enemigoASerAtacadoPorElEngañado := self nuevoCombatienteHumanoide.
	ilusionista enemigos: {enemigoEngañado. enemigoASerAtacadoPorElEngañado}.
	
	ilusionista interactuarCon: enemigoEngañado.
	
	self assert: enemigoEngañado noEstaHerido. 
	self assert: enemigoASerAtacadoPorElEngañado estaHerido.! !


!CombatientesFantasticosTest methodsFor: 'privado' stamp: 'MC 5/16/2023 21:21:22'!
assertCuradorSana: unosAliados dejandolosConLavidaEsperada: cantidadDePuntosDeVida

	|curador|
	 
	curador := self nuevoCombatienteCurador.
	curador aliados: unosAliados .
	
	curador interactuar.

	self assert: (unosAliados allSatisfy: [ : unAliado | unAliado tienePuntosDeVida: cantidadDePuntosDeVida ]).! !

!CombatientesFantasticosTest methodsFor: 'privado' stamp: 'MC 5/16/2023 18:44:20'!
assertEnemigos: unosEnemigos noEstanHeridos: unaCantidadDeEnegmigosNoHeridos estanCon12PuntosDeVida: unaCantidadDeEnemigosConPocosPuntosDeVida

	self assert: unaCantidadDeEnemigosConPocosPuntosDeVida equals: (unosEnemigos count: [: unEnemigo | unEnemigo tienePuntosDeVida: 12 * pv]).
	
	self assert: unaCantidadDeEnegmigosNoHeridos equals: (unosEnemigos count: [: unEnemigo | unEnemigo estaHerido not]).

 ! !


!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-05-ogro' stamp: 'MC 5/16/2023 21:21:22'!
test14UnOgroNoDañaAUnEnemigoCuandoAtacaLaPrimeraVez
	| ogro enemigo |
	ogro := self nuevoCombatienteOgro.
	enemigo := self nuevoCombatienteHumanoide.
	ogro enemigos: {enemigo}.

	ogro interactuar.
	
	self assert: enemigo noEstaHerido.! !

!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-05-ogro' stamp: 'MC 5/16/2023 21:21:22'!
test15UnOgroDañaAUnEnemigoCuandoAtacaLuegoDePrepararse
	| ogro enemigo |
	ogro := self nuevoCombatienteOgro.
	enemigo := self nuevoCombatienteHumanoide.
	ogro enemigos: {enemigo}.
	ogro interactuar.
	
	ogro interactuar.
	
	self assert: enemigo estaHerido.! !

!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-05-ogro' stamp: 'MC 5/16/2023 21:21:22'!
test16UnOgroHace20DeDañoCuandoAtacaLuegoDePrepararse
	| ogro enemigo |
	ogro := self nuevoCombatienteOgro.
	enemigo := self nuevoCombatienteHumanoide.
	enemigo equiparConUnaArmaduraDeCuero.
	ogro enemigos: {enemigo}.
	ogro interactuar.
	
	ogro interactuar.
	
	self assert: (enemigo tienePuntosDeVida: 2 * pv).! !

!CombatientesFantasticosTest methodsFor: '[No hace falta quitar codigo repetido] tests-05-ogro' stamp: 'MC 5/16/2023 21:21:22'!
test17UnOgroLuegoDeAtacarTieneQueVolverAPrepararse
	| ogro enemigo |
	ogro := self nuevoCombatienteOgro.
	enemigo := self nuevoCombatienteHumanoide.
	enemigo equiparConUnaArmaduraDeCuero.
	ogro enemigos: {enemigo}.
	ogro interactuar.
	ogro interactuar.
	
	ogro interactuar.
	
	self assert: enemigo estaFueraDeCombate not.! !


!classDefinition: #CombatientesTest category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
TestCase subclass: #CombatientesTest
	instanceVariableNames: 'atacante atacado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test01LosPuñosHacen2DeDaño
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 18*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test02MultiplesAtaquesVanBajandoMasVida
	atacante interactuarCon: atacado.
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 16*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test03UnHachaHace10DeDaño
	atacante equiparConUnHacha.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 10*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test04UnEspadaHace8DeDaño
	atacante equiparConUnaEspada.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 12*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test05UnMartilloHace8DeDaño
	atacante equiparConUnMartillo.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 12*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test06UnaDagaHace4DeDaño
	atacante equiparConUnaDaga.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 16*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test07UnaLanzaHace8DeDaño
	atacante equiparConUnaLanza.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 12*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test08UnPaloHace6DeDaño
	atacante equiparConUnPalo.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 14*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test09LaArmaduraDeMetalAbsorve6DeDaño 
	atacante equiparConUnHacha.
	atacado equiparConUnaArmaduraDeMetal.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 16*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test10LaArmaduraDeAnillosAbsorve4DeDaño 
	atacante equiparConUnHacha.
	atacado equiparConUnaArmaduraDeAnillos.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 14*pv).! !

!CombatientesTest methodsFor: 'tests' stamp: 'MC 5/16/2023 21:21:53'!
test11LaArmaduraDeCueroAbsorve2DeDaño 
	atacante equiparConUnHacha.
	atacado equiparConUnaArmaduraDeCuero.
	
	atacante interactuarCon: atacado.
	
	self assert: (atacado tienePuntosDeVida: 12*pv).! !


!CombatientesTest methodsFor: 'setUp/tearDown' stamp: 'MC 5/16/2023 20:28:46'!
setUp
	atacante := Humanoide new initialize. 
	atacado := Humanoide new initialize.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatientesTest class' category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
CombatientesTest class
	instanceVariableNames: ''!

!CombatientesTest class methodsFor: 'class initialization' stamp: 'JMB 10/16/2022 11:11:15'!
initialize

	"Este método está para crear unidades. No se debe tocar"

	| puntosDeVida |
	super initialize.
	puntosDeVida := BaseUnit named: 'puntosDeVida' sign: 'pv'.

	Smalltalk at: #pv put: puntosDeVida.
	Smalltalk at: #puntosDeVida put: puntosDeVida.! !


!classDefinition: #EstrategiasTest category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
TestCase subclass: #EstrategiasTest
	instanceVariableNames: 'arthas mankrik olgra'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!EstrategiasTest methodsFor: 'combatientes' stamp: 'SF 10/11/2022 22:03:48'!
combatienteHumanoArthas
	^arthas! !

!EstrategiasTest methodsFor: 'combatientes' stamp: 'SF 10/11/2022 22:04:48'!
combatienteOrcoMankrik
	^mankrik! !

!EstrategiasTest methodsFor: 'combatientes' stamp: 'SF 10/11/2022 22:04:54'!
combatienteOrcoOlgra
	^olgra! !


!EstrategiasTest methodsFor: 'tests' stamp: 'JMB 10/18/2022 21:34:26'!
test01FocalizarEnElMasHeridoEsMejorQueEnElMasSano
	
	self assert: self puntosDeVidaDelGanadorFocalizandoEnElMasHerido > self puntosDeVidaDelGanadorFocalizandoEnElMasSano.! !


!EstrategiasTest methodsFor: 'combates' stamp: 'JMB 3/4/2023 12:58:02'!
orquestadorParaArthasUsandoUnHachaYConFocoEnElMasHeridoVsOrcos
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self combatienteHumanoArthas equiparConUnHacha.
	^OrquestadorDeCombates
		establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
! !

!EstrategiasTest methodsFor: 'combates' stamp: 'JMB 3/4/2023 12:58:02'!
orquestadorParaArthasUsandoUnHachaYConFocoEnElMasSanoVsOrcos
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self combatienteHumanoArthas equiparConUnHacha.
	^OrquestadorDeCombates
			establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
! !

!EstrategiasTest methodsFor: 'combates' stamp: 'SF 10/10/2022 18:32:49'!
puntosDeVidaDelGanadorFocalizandoEnElMasHerido
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaArthasUsandoUnHachaYConFocoEnElMasHeridoVsOrcos.
	orquestadorDeCombates desarrollarDuranteRondas: 100.
	^ self combatienteHumanoArthas puntosDeVida! !

!EstrategiasTest methodsFor: 'combates' stamp: 'SF 10/10/2022 18:32:49'!
puntosDeVidaDelGanadorFocalizandoEnElMasSano
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaArthasUsandoUnHachaYConFocoEnElMasSanoVsOrcos.
	orquestadorDeCombates desarrollarDuranteRondas: 100.
	^ self combatienteHumanoArthas puntosDeVida! !


!EstrategiasTest methodsFor: 'private' stamp: 'MC 5/16/2023 20:30:54'!
prepararCombatientes
	arthas :=  Humanoide new initialize.
	olgra := Humanoide new initialize.
	mankrik :=  Humanoide new initialize.! !


!classDefinition: #OrquestadorDeCombatesTest category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
TestCase subclass: #OrquestadorDeCombatesTest
	instanceVariableNames: 'arthas olgra mankrik'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'SF 10/10/2022 19:37:28'!
orquestadorParaCombateArthasConFocoEnElMasSanoVsOrcos	
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	^self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'MC 5/16/2023 21:21:53'!
orquestadorParaCombateArthasInmuneYFocoEnElMasHeridoVsOrcos	
	
	self prepararCombatientes.
	self combatienteHumanoArthas interactuarCon: self combatienteOrcoOlgra.
	self combatienteHumanoArthas equiparConUnaArmaduraDeMetal. 
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	^self establecerCombateEntreBando1:  {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'SF 10/9/2022 12:55:39'!
orquestadorParaCombateArthasVsOlgra	
	
	self prepararCombatientes. 
	^OrquestadorDeCombates establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'SF 10/11/2022 21:54:06'!
orquestadorParaCombateArthasVsOrcos
	self prepararCombatientes.
	^self establecerCombateEntreBando1: { self combatienteHumanoArthas } contraBando2: {self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'JMB 3/4/2023 12:57:31'!
orquestadorParaCombateManoAManoConBando2Inmune	
	
	self prepararCombatientes.
	self combatienteOrcoOlgra equiparConUnaEspada.
	^self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'SF 10/10/2022 19:46:34'!
orquestadorParaCombateOrcosVsArthas
	self prepararCombatientes.
	^self establecerCombateEntreBando1: {self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: { self combatienteHumanoArthas }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'SF 10/11/2022 21:53:53'!
orquestadorParaCombateOrcosVsArthasConFocoEnElMasSano	
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	^self establecerCombateEntreBando1: { self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: {self combatienteHumanoArthas }. 
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'MC 5/16/2023 21:21:53'!
orquestadorParaCombateOrcosVsArthasInmuneYFocoEnElMasHerido	
	
	self prepararCombatientes.
	self combatienteHumanoArthas interactuarCon: self combatienteOrcoOlgra.
	self combatienteHumanoArthas equiparConUnaArmaduraDeMetal. 
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	^self establecerCombateEntreBando1: { self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: {self combatienteHumanoArthas }.
! !

!OrquestadorDeCombatesTest methodsFor: 'combates' stamp: 'MC 5/16/2023 20:31:57'!
prepararCombatientes

	arthas :=  Humanoide new initialize. 
	olgra :=  Humanoide new initialize. 
	mankrik :=  Humanoide new initialize. ! !


!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'JMB 10/18/2022 21:35:14'!
test01AlDesarrollarUnCombateSinRondasLosCombatientesNoSeAtacan
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 0.
	
	self assert: self combatienteHumanoArthas noEstaHerido.
	self assert: self combatienteOrcoOlgra noEstaHerido.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'JMB 10/18/2022 21:35:32'!
test02AlDesarrollarUnCombateManoAManoDeUnaRondaLosBandosSeAtacanUnaVez
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 1.
	
	self assert: (self combatienteHumanoArthas tienePuntosDeVida: 18*pv) description: 'Arthas debe recibir un puñetazo (2 de daño)'.
	self assert: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe recibir un puñetazo (2 de daño)'.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'JMB 10/18/2022 21:35:47'!
test03AlDesarrollarUnCombateManoAManoConMasDeUnaRondaLosBandosSeAtacanCadaVez
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	self assert: (self combatienteHumanoArthas tienePuntosDeVida: 16*pv) description: 'Arthas debe recibir dos puñetazos (4 de daño)'.
	self assert: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe recibir dos puñetazos (4 de daño)'.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'SF 10/9/2022 12:33:46'!
test04AlDesarrollarUnCombateManoAManoSinGanadoresElResultadoEsIndeterminado
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 0.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 0.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'SF 10/9/2022 12:33:45'!
test05AlDesarrollarUnCombateManoAManoGanaElBando1CuandoDejaFueraDeCombateASuRival
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'SF 10/9/2022 12:33:45'!
test06AlDesarrollarUnCombateCuandoHayUnGanadorFinalizaEnLaRondaQueElPerdedorQuedoFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 11.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - mano a mano' stamp: 'SF 10/9/2022 12:33:46'!
test07AlDesarrollarUnCombateManoAManoGanaElBando2CuandoDejaFueraDeCombateASuRival
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateManoAManoConBando2Inmune.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 100.
	
	self assertElResultadoIndicaQueGanoElBando2: resultado alcanzadaLaRonda: 3.! !


!OrquestadorDeCombatesTest methodsFor: 'tests - muches vs muches' stamp: 'JMB 10/18/2022 21:36:08'!
test08AlDesarrollarUnCombateLosDelBando1PuedenAtacarACualquieraDelBando2
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasConFocoEnElMasSanoVsOrcos.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	self assert: self combatienteOrcoOlgra estaHerido. 
	self assert: self combatienteOrcoMankrik estaHerido. ! !

!OrquestadorDeCombatesTest methodsFor: 'tests - muches vs muches' stamp: 'SF 10/11/2022 21:53:23'!
test09AlDesarrollarUnCombateAtacanTodesLosDelBando1EnCadaRonda
	"
		En cada ronda cada combatiente daña al que esta solo por 2 de daño cada uno
	"
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthas.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 5.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 5.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - muches vs muches' stamp: 'JMB 10/18/2022 21:36:18'!
test10AlDesarrollarUnCombateLosDelBando2PuedenAtacarACualquieraDelBando1
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthasConFocoEnElMasSano.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	self assert: self combatienteOrcoOlgra estaHerido. 
	self assert: self combatienteOrcoMankrik estaHerido. ! !

!OrquestadorDeCombatesTest methodsFor: 'tests - muches vs muches' stamp: 'SF 10/11/2022 21:55:18'!
test11AlDesarrollarUnCombateAtacanTodesLosDelBando2EnCadaRonda
	"
		En cada ronda cada combatiente daña en 2 al del otro bando. 4 de daño en total por turno.
	"
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOrcos.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 5.
	
	self assertElResultadoIndicaQueGanoElBando2: resultado alcanzadaLaRonda: 5.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - muches vs muches' stamp: 'SF 10/9/2022 12:33:46'!
test12AlDesarrollarUnCombateLosDelBando1NoGananSiTodosLosDelBando2NoEstanFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasInmuneYFocoEnElMasHeridoVsOrcos.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest methodsFor: 'tests - muches vs muches' stamp: 'SF 10/9/2022 12:33:46'!
test13AlDesarrollarUnCombateLosDelBando2NoGananSiTodosLosDelBando1NoEstanFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthasInmuneYFocoEnElMasHerido.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 10.! !


!OrquestadorDeCombatesTest methodsFor: 'para completar' stamp: 'JMB 10/18/2022 21:36:30'!
assertElResultadoIndicaQueGanoElBando1: resultadoDeUnCombate alcanzadaLaRonda: unNumeroDeRondaEsperado

	self assert: (resultadoDeUnCombate tieneDeGanadorAlBando1Realizando: unNumeroDeRondaEsperado)! !

!OrquestadorDeCombatesTest methodsFor: 'para completar' stamp: 'JMB 10/18/2022 21:36:36'!
assertElResultadoIndicaQueGanoElBando2: resultadoDeUnCombate alcanzadaLaRonda: unNumeroDeRondaEsperado

	self assert: (resultadoDeUnCombate tieneDeGanadorAlBando2Realizando: unNumeroDeRondaEsperado)! !

!OrquestadorDeCombatesTest methodsFor: 'para completar' stamp: 'JMB 10/18/2022 21:36:41'!
assertElResultadoIndicaQueNoHayGanador: resultadoDeUnCombate  alcanzadaLaRonda: unNumeroDeRondaEsperado

	self assert:  (resultadoDeUnCombate finalizoSinGanadoresRealizando: unNumeroDeRondaEsperado)! !

!OrquestadorDeCombatesTest methodsFor: 'para completar' stamp: 'SF 10/10/2022 18:42:57'!
establecerCombateEntreBando1: unBando1 contraBando2: unBando2

	^OrquestadorDeCombates establecerCombateEntreBando1: unBando1 contraBando2: unBando2.! !


!OrquestadorDeCombatesTest methodsFor: 'combatientes' stamp: 'SF 10/10/2022 19:26:44'!
combatienteHumanoArthas

	^arthas.! !

!OrquestadorDeCombatesTest methodsFor: 'combatientes' stamp: 'SF 10/10/2022 19:26:34'!
combatienteOrcoMankrik

	^mankrik.! !

!OrquestadorDeCombatesTest methodsFor: 'combatientes' stamp: 'SF 10/10/2022 19:26:39'!
combatienteOrcoOlgra

	^olgra.! !


!classDefinition: #Combatiente category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Object subclass: #Combatiente
	instanceVariableNames: 'puntosDeVida enemigos estrategia dañoAAbsorber aliados'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!Combatiente methodsFor: 'private' stamp: 'MC 5/16/2023 20:17:54'!
dañoAInfligir
	self subclassResponsibility. ! !

!Combatiente methodsFor: 'private' stamp: 'SF 7/13/2022 22:24:44'!
puntosDeVida
	^puntosDeVida! !

!Combatiente methodsFor: 'private' stamp: 'MC 5/16/2023 19:55:40'!
puntosDeVidaIniciales
	self subclassResponsibility.! !


!Combatiente methodsFor: 'estrategia' stamp: 'SF 10/15/2022 18:28:31'!
estrategiaACualquiera

	^ [:candidatos | candidatos anyOne]! !

!Combatiente methodsFor: 'estrategia' stamp: 'SF 8/21/2022 10:33:13'!
focalizarEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:enemigo | enemigo puntosDeVida]].! !

!Combatiente methodsFor: 'estrategia' stamp: 'SF 8/21/2022 10:39:02'!
focalizarEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:enemigo | enemigo puntosDeVida]].! !


!Combatiente methodsFor: 'combate' stamp: 'JMB 5/14/2023 13:11:30'!
aliados: luchadores 
	aliados := luchadores.! !

!Combatiente methodsFor: 'combate' stamp: 'SF 8/20/2022 11:56:44'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!Combatiente methodsFor: 'combate' stamp: 'SF 10/10/2022 11:06:47'!
estaFueraDeCombate
	^puntosDeVida <= (0*pv).! !

!Combatiente methodsFor: 'combate' stamp: 'JMB 3/4/2023 20:27:11'!
estaHerido
	^puntosDeVida < self puntosDeVidaIniciales! !

!Combatiente methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:21'!
interactuar
	self subclassResponsibility. 
	! !

!Combatiente methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuarCon: unCombatiente
	self subclassResponsibility. ! !

!Combatiente methodsFor: 'combate' stamp: 'SF 10/9/2022 19:18:00'!
noEstaHerido
	^self estaHerido not.! !

!Combatiente methodsFor: 'combate' stamp: 'JMB 5/14/2023 13:11:41'!
recibirCuracion: unEntero
	
	puntosDeVida := puntosDeVida + unEntero.
	puntosDeVida := puntosDeVida min: self puntosDeVidaIniciales.! !

!Combatiente methodsFor: 'combate' stamp: 'JMB 3/4/2023 13:32:21'!
recibirDaño: unaCantidadDeDaño  
	| dañoADescontar |
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber) max: 0*pv.
	puntosDeVida := puntosDeVida - dañoADescontar.! !

!Combatiente methodsFor: 'combate' stamp: 'SF 10/9/2022 12:56:52'!
tienePuntosDeVida: unaCantidadDePuntosDeVida
	^puntosDeVida = unaCantidadDePuntosDeVida.! !



!Combatiente methodsFor: 'printing' stamp: 'JMB 3/4/2023 13:42:41'!
printOn: aStream
	aStream 
		nextPutAll: 'un'; 
		space;
		nextPutAll: self class name;
		nextPutAll: ' ('.
	
	puntosDeVida printOn: aStream.
	aStream nextPut: $/.
	self puntosDeVidaIniciales printOn: aStream.
	aStream nextPut: $).! !


!classDefinition: #Curador category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Combatiente subclass: #Curador
	instanceVariableNames: 'dañoAInfligir'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!Curador methodsFor: 'inicializacion' stamp: 'MC 5/16/2023 21:22:22'!
initialize
	puntosDeVida := self puntosDeVidaIniciales.
	enemigos := OrderedCollection new.
	aliados := #().
	dañoAInfligir := self dañoAInflingir.
	dañoAAbsorber := 0.! !


!Curador methodsFor: 'privado' stamp: 'MC 5/16/2023 21:08:42'!
dañoAInflingir
 	^ dañoAInfligir 
	! !

!Curador methodsFor: 'privado' stamp: 'MC 5/16/2023 19:53:12'!
puntosDeVidaIniciales
	^ 20 * pv! !


!Curador methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:21'!
interactuar

	aliados do:[:compañero | compañero recibirCuracion: 2*pv. ].
	^self.
	! !

!Curador methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuarCon: unCombatiente

	self estaFueraDeCombate ifTrue: [^self].
	unCombatiente recibirDaño: self dañoAInfligir.! !


!classDefinition: #Dragon category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Combatiente subclass: #Dragon
	instanceVariableNames: 'dañoAInfligir'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!Dragon methodsFor: 'privado' stamp: 'MC 5/16/2023 19:56:44'!
dañoAInfligir
	^ 8*pv! !

!Dragon methodsFor: 'privado' stamp: 'MC 5/16/2023 19:53:48'!
puntosDeVidaIniciales
	^ 200 * pv
	! !


!Dragon methodsFor: 'initialization' stamp: 'MC 5/16/2023 21:18:03'!
initialize
	puntosDeVida := self puntosDeVidaIniciales.
	enemigos := OrderedCollection new.
	dañoAAbsorber := 0.	
	aliados := #().
	dañoAInfligir := self dañoAInfligir .! !


!Dragon methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuar
	| indice enemigoAAtacar enemigosSeleccionado enemigosActivos | 
	
	self estaFueraDeCombate ifTrue: [^self].

	enemigosActivos := enemigos select: [:enemigo | enemigo estaFueraDeCombate not].
	enemigosActivos isEmpty ifTrue: [^self].
	
	
	enemigosSeleccionado := enemigosActivos firstAvailable: 8.
	indice := 1.
	[ indice <= enemigosSeleccionado size ] whileTrue: [
		
		enemigoAAtacar := enemigosSeleccionado at: indice. 
		self interactuarCon: enemigoAAtacar.
		indice := indice + 1.
	].
	^self.! !

!Dragon methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuarCon: unCombatiente
	self estaFueraDeCombate ifTrue: [^self].
	unCombatiente recibirDaño: self dañoAInfligir.! !


!classDefinition: #Humanoide category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Combatiente subclass: #Humanoide
	instanceVariableNames: 'dañoAInfligirPorArma'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!Humanoide methodsFor: 'privado' stamp: 'MC 5/16/2023 19:57:05'!
dañoAInfligir
	 ^ dañoAInfligirPorArma

	! !

!Humanoide methodsFor: 'privado' stamp: 'MC 5/16/2023 19:54:21'!
puntosDeVidaIniciales
	^ 20 * pv! !


!Humanoide methodsFor: 'initialization' stamp: 'MC 5/16/2023 21:18:30'!
initialize
	puntosDeVida := self puntosDeVidaIniciales.
	enemigos := OrderedCollection new.
	estrategia := self estrategiaACualquiera.
	dañoAInfligirPorArma := 2*pv.
	dañoAAbsorber := 0.	
	aliados := #().! !


!Humanoide methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuar

	| contrincanteSeleccionado enemigosActivos |
	
	self estaFueraDeCombate ifTrue: [^self].
	enemigosActivos := enemigos select: [:enemigo | enemigo estaFueraDeCombate not].
	
	enemigosActivos isEmpty ifTrue: [^self].
	contrincanteSeleccionado := estrategia value: enemigosActivos .
	self interactuarCon: contrincanteSeleccionado.
	^self.! !

!Humanoide methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuarCon: unCombatiente
	self estaFueraDeCombate ifTrue: [^self].
	unCombatiente recibirDaño: self dañoAInfligir.! !


!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:21:04'!
equiparConUnHacha
	dañoAInfligirPorArma := 10 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:21:11'!
equiparConUnMartillo
	dañoAInfligirPorArma := 8 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:21:24'!
equiparConUnPalo
	dañoAInfligirPorArma _ 6 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:21:31'!
equiparConUnaArmaduraDeAnillos
	dañoAAbsorber _ 4 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:21:49'!
equiparConUnaArmaduraDeCuero
	dañoAAbsorber _ 2 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:23:34'!
equiparConUnaArmaduraDeMetal
	dañoAAbsorber := 6 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:23:20'!
equiparConUnaDaga
	dañoAInfligirPorArma _ 4 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:23:23'!
equiparConUnaEspada
	dañoAInfligirPorArma := 8 * pv.! !

!Humanoide methodsFor: 'equipo' stamp: 'MC 5/16/2023 20:23:29'!
equiparConUnaLanza
	dañoAInfligirPorArma := 8 * pv.! !


!classDefinition: #Ilusionista category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Combatiente subclass: #Ilusionista
	instanceVariableNames: 'dañoAInfligir'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!Ilusionista methodsFor: 'privado' stamp: 'MC 5/16/2023 20:39:04'!
dañoAInfligir
	 ^ 0.! !

!Ilusionista methodsFor: 'privado' stamp: 'MC 5/16/2023 19:54:59'!
puntosDeVidaIniciales
	^ 20 * pv! !


!Ilusionista methodsFor: 'initialization' stamp: 'MC 5/16/2023 21:19:29'!
initialize
	puntosDeVida := self puntosDeVidaIniciales.
	enemigos := OrderedCollection new.
	dañoAAbsorber := 0.	
	dañoAInfligir := 0.
	estrategia := self estrategiaACualquiera.
	aliados := #().! !


!Ilusionista methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuar

	| contrincanteSeleccionado enemigosActivos |
	
	self estaFueraDeCombate ifTrue: [^self].
	
	enemigosActivos := enemigos select: [:enemigo | enemigo estaFueraDeCombate not].
	enemigosActivos isEmpty ifTrue: [^self].
	
	
	contrincanteSeleccionado := estrategia value: enemigosActivos.
	self interactuarCon: contrincanteSeleccionado.
	
	^self.! !

!Ilusionista methodsFor: 'combate' stamp: 'MC 5/16/2023 21:32:36'!
interactuarCon: unCombatiente
	| victima aliadosDeUnCombatienteASerAtacado |
	self estaFueraDeCombate ifTrue: [^self].
	
	aliadosDeUnCombatienteASerAtacado := OrderedCollection new.
	
	enemigos do:[:unEnemigo | 
		unEnemigo = unCombatiente ifFalse: [
			aliadosDeUnCombatienteASerAtacado add: unEnemigo
		].  
	].
	aliadosDeUnCombatienteASerAtacado isEmpty ifTrue: [^ self].
	victima :=  aliadosDeUnCombatienteASerAtacado anyOne.
	unCombatiente interactuarCon: victima.
	^ self
	! !


!classDefinition: #Ogro category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Combatiente subclass: #Ogro
	instanceVariableNames: 'dañoAInfligir ogroYaAtaco'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!Ogro methodsFor: 'privado' stamp: 'MC 5/16/2023 19:57:52'!
dañoAInfligir
	^ 20*pv
	! !

!Ogro methodsFor: 'privado' stamp: 'MC 5/16/2023 19:55:28'!
puntosDeVidaIniciales
	^ 60 * pv
	! !


!Ogro methodsFor: 'initialization' stamp: 'MC 5/16/2023 21:20:02'!
initialize
	puntosDeVida := self puntosDeVidaIniciales.
	enemigos := OrderedCollection new.
	dañoAAbsorber := 0.	
	estrategia := self estrategiaACualquiera.
	aliados := #().
	ogroYaAtaco := false.
	dañoAInfligir := self dañoAInfligir .! !


!Ogro methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuar

	| enemigosActivos |
	self estaFueraDeCombate ifTrue: [^self].

	enemigosActivos := enemigos select: [:enemigo | enemigo estaFueraDeCombate not].
	enemigosActivos isEmpty ifTrue: [^self].
	
	ogroYaAtaco ifTrue: [ 
		
		| contrincanteSeleccionado |

		contrincanteSeleccionado := estrategia value: enemigosActivos .
		self interactuarCon: contrincanteSeleccionado.
		ogroYaAtaco := false.
		^self.
		].
	ogroYaAtaco := true.
	^self.! !

!Ogro methodsFor: 'combate' stamp: 'MC 5/16/2023 21:21:53'!
interactuarCon: unCombatiente
	self estaFueraDeCombate ifTrue: [^self].
	unCombatiente recibirDaño: self dañoAInfligir.! !


!classDefinition: #OrquestadorDeCombates category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Object subclass: #OrquestadorDeCombates
	instanceVariableNames: 'bando1 bando2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!OrquestadorDeCombates methodsFor: 'initializing' stamp: 'SF 10/9/2022 12:50:01'!
initializeEstablecerCombateEntreBando1: unConjuntoDeCombatientes contraBando2: otroConjuntoDeCombatientes
	bando1 := unConjuntoDeCombatientes.
	bando2 := otroConjuntoDeCombatientes.! !


!OrquestadorDeCombates methodsFor: 'public' stamp: 'MC 5/16/2023 21:21:21'!
desarrollarDuranteRondas: maximoDeRondas
	| rondaActual |
	rondaActual := 1.
	[rondaActual <= maximoDeRondas and: [self noHayGanador]] whileTrue: [
		bando1 do: [ :combatiente | combatiente interactuar].
		bando2 do: [ :combatiente | combatiente interactuar].
		rondaActual := rondaActual + 1.
	].
	rondaActual := rondaActual - 1.
	self esBando1Ganador ifTrue: [^ResultadoDeCombate conGanadorBando1EnRonda: rondaActual].
	self esBando2Ganador ifTrue: [^ResultadoDeCombate conGanadorBando2EnRonda: rondaActual].
	^ResultadoDeCombate indeterminadoEnRonda: rondaActual.! !


!OrquestadorDeCombates methodsFor: 'private' stamp: 'SF 10/10/2022 11:02:11'!
esBando1Ganador
	^(self hayAlMenosUnCombatienteEnCombateEn: bando1) and: [self todosEstanFueraDeCombateEn: bando2].
	! !

!OrquestadorDeCombates methodsFor: 'private' stamp: 'SF 10/10/2022 11:19:32'!
esBando2Ganador
	^(self hayAlMenosUnCombatienteEnCombateEn: bando2) and: [self todosEstanFueraDeCombateEn: bando1].! !

!OrquestadorDeCombates methodsFor: 'private' stamp: 'SF 10/10/2022 11:03:52'!
hayAlMenosUnCombatienteEnCombateEn: unConjuntoDeCombatientes
	^unConjuntoDeCombatientes anySatisfy: [:combatiente | combatiente estaFueraDeCombate not].! !

!OrquestadorDeCombates methodsFor: 'private' stamp: 'SF 10/10/2022 11:18:59'!
noHayGanador
	^self esBando1Ganador not and: [self esBando2Ganador not].! !

!OrquestadorDeCombates methodsFor: 'private' stamp: 'SF 10/10/2022 11:07:32'!
todosEstanFueraDeCombateEn: unConjuntoDeCombatientes
	^unConjuntoDeCombatientes allSatisfy: [:combatiente | combatiente estaFueraDeCombate].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeCombates class' category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
OrquestadorDeCombates class
	instanceVariableNames: ''!

!OrquestadorDeCombates class methodsFor: 'instance creation' stamp: 'SF 2/24/2023 21:20:26'!
establecerCombateEntreBando1: bando1 contraBando2: bando2
	self relacionar: bando1 con: bando2.
	^self new initializeEstablecerCombateEntreBando1: bando1 contraBando2: bando2 ! !


!OrquestadorDeCombates class methodsFor: 'as yet unclassified' stamp: 'SF 10/9/2022 19:29:24'!
enemistar: unBandoDeCombatientes con: otroBandoDeCombatientes
	unBandoDeCombatientes do: [ :combatiente | combatiente enemigos: otroBandoDeCombatientes ].
	otroBandoDeCombatientes do: [ :combatiente | combatiente enemigos: unBandoDeCombatientes ].! !

!OrquestadorDeCombates class methodsFor: 'as yet unclassified' stamp: 'SF 2/24/2023 21:20:26'!
relacionar: unBandoDeCombatientes con: otroBandoDeCombatientes
	unBandoDeCombatientes do: [ :combatiente | 
		combatiente enemigos: otroBandoDeCombatientes.
		combatiente aliados: unBandoDeCombatientes.].
	otroBandoDeCombatientes do: [ :combatiente | 
		combatiente enemigos: unBandoDeCombatientes.
		combatiente aliados: otroBandoDeCombatientes].! !


!classDefinition: #ResultadoDeCombate category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
Object subclass: #ResultadoDeCombate
	instanceVariableNames: 'numeroDeRonda ganador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!

!ResultadoDeCombate methodsFor: 'public' stamp: 'JMB 3/4/2023 13:03:59'!
finalizoSinGanadores

	^ ganador = self elGanadorEsIndeterminado! !

!ResultadoDeCombate methodsFor: 'public' stamp: 'JMB 3/4/2023 13:03:59'!
finalizoSinGanadoresRealizando: unaCantidadDeRondas
	^self finalizoSinGanadores and: [numeroDeRonda = unaCantidadDeRondas].! !

!ResultadoDeCombate methodsFor: 'public' stamp: 'SF 2/21/2023 13:51:09'!
tieneDeGanadorAlBando1
	^self elBando1Ganó = ganador.! !

!ResultadoDeCombate methodsFor: 'public' stamp: 'SF 2/21/2023 13:51:45'!
tieneDeGanadorAlBando1Realizando: unaCantidadDeRondas
	^self tieneDeGanadorAlBando1 and: [numeroDeRonda = unaCantidadDeRondas].! !

!ResultadoDeCombate methodsFor: 'public' stamp: 'SF 2/21/2023 14:49:32'!
tieneDeGanadorAlBando2
	^self elBando2Ganó = ganador.! !

!ResultadoDeCombate methodsFor: 'public' stamp: 'SF 2/21/2023 14:50:12'!
tieneDeGanadorAlBando2Realizando: unaCantidadDeRondas
	^self tieneDeGanadorAlBando2 and: [numeroDeRonda = unaCantidadDeRondas].! !


!ResultadoDeCombate methodsFor: 'initialization' stamp: 'SF 10/10/2022 11:10:22'!
initializeConGanadorBando1EnRonda: unNumeroDeRonda 
	ganador := self elBando1Ganó.
	numeroDeRonda := unNumeroDeRonda.! !

!ResultadoDeCombate methodsFor: 'initialization' stamp: 'SF 10/10/2022 19:02:08'!
initializeConGanadorBando2EnRonda: unNumeroDeRonda 
	ganador := self elBando2Ganó.
	numeroDeRonda := unNumeroDeRonda.! !

!ResultadoDeCombate methodsFor: 'initialization' stamp: 'SF 10/10/2022 11:15:24'!
initializeIndeterminadoEnRonda: unaCantidadDeRondas
	ganador := self elGanadorEsIndeterminado.
	numeroDeRonda := unaCantidadDeRondas.! !


!ResultadoDeCombate methodsFor: 'private' stamp: 'SF 10/10/2022 11:10:22'!
elBando1Ganó

	^ 'bando1'! !

!ResultadoDeCombate methodsFor: 'private' stamp: 'SF 10/10/2022 18:50:09'!
elBando2Ganó

	^ 'bando2'! !

!ResultadoDeCombate methodsFor: 'private' stamp: 'SF 10/10/2022 11:13:38'!
elGanadorEsIndeterminado
	^'indeterminado'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ResultadoDeCombate class' category: 'AlgoIII-2023-1C-1Parcial-CombatientesFantasticos-P3'!
ResultadoDeCombate class
	instanceVariableNames: ''!

!ResultadoDeCombate class methodsFor: 'instance creation' stamp: 'SF 10/10/2022 11:08:18'!
conGanadorBando1EnRonda: unNumeroDeRonda
	^self new initializeConGanadorBando1EnRonda: unNumeroDeRonda! !

!ResultadoDeCombate class methodsFor: 'instance creation' stamp: 'SF 10/10/2022 18:57:31'!
conGanadorBando2EnRonda: aSmallInteger 
	^self new initializeConGanadorBando2EnRonda: aSmallInteger ! !

!ResultadoDeCombate class methodsFor: 'instance creation' stamp: 'SF 10/10/2022 11:12:29'!
indeterminadoEnRonda: unaCantidadDeRondas
	^self new initializeIndeterminadoEnRonda: unaCantidadDeRondas! !

CombatientesTest initialize!