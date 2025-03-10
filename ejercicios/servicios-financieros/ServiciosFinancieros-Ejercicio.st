!classDefinition: #E_AssociateAlredyInPortfolio category: 'ServiciosFinancieros-Ejercicio'!
Error subclass: #E_AssociateAlredyInPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'E_AssociateAlredyInPortfolio class' category: 'ServiciosFinancieros-Ejercicio'!
E_AssociateAlredyInPortfolio class
	instanceVariableNames: ''!

!E_AssociateAlredyInPortfolio class methodsFor: 'signal' stamp: 'JMPO 6/4/2023 11:21:33'!
signal
	
	^self signal: 'Error!! Associate is alredy present in portfolio.'! !


!classDefinition: #E_AssociateNotFound category: 'ServiciosFinancieros-Ejercicio'!
Error subclass: #E_AssociateNotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'E_AssociateNotFound class' category: 'ServiciosFinancieros-Ejercicio'!
E_AssociateNotFound class
	instanceVariableNames: ''!

!E_AssociateNotFound class methodsFor: 'signal' stamp: 'JMPO 6/3/2023 20:29:20'!
signal
	
	^self signal: 'Error!! Associate not found in portfolio.'! !


!classDefinition: #E_SelfAditionOfPortfolio category: 'ServiciosFinancieros-Ejercicio'!
Error subclass: #E_SelfAditionOfPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'E_SelfAditionOfPortfolio class' category: 'ServiciosFinancieros-Ejercicio'!
E_SelfAditionOfPortfolio class
	instanceVariableNames: ''!

!E_SelfAditionOfPortfolio class methodsFor: 'as yet unclassified' stamp: 'JMPO 6/5/2023 16:04:36'!
signal
	
	^self signal: 'Error!! Cant add a portfolio into itself.'! !


!classDefinition: #Z_PortfoliosExtraTddTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #Z_PortfoliosExtraTddTest
	instanceVariableNames: 'testingAccount1 testingAccount2 testingPortfolio1 testingPortfolio2 testingPortfolio3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Z_PortfoliosExtraTddTest methodsFor: 'setUp' stamp: 'JMPO 6/5/2023 16:02:33'!
setUp
	
	testingAccount1 := ReceptiveAccount new initialize .
	testingAccount2 := ReceptiveAccount new initialize .
	testingPortfolio1 := Portfolio new initialize .
	testingPortfolio2 := Portfolio new initialize .
	testingPortfolio3 := Portfolio new initialize .! !


!Z_PortfoliosExtraTddTest methodsFor: 'tests' stamp: 'JMPO 6/5/2023 15:47:49'!
test01PortfolioCantAddSameAssociateTwice
	
	testingPortfolio1 addAssociate: testingAccount1 .
	
	self should: [testingPortfolio1 addAssociate: testingAccount1 ] raise: E_AssociateAlredyInPortfolio. ! !

!Z_PortfoliosExtraTddTest methodsFor: 'tests' stamp: 'JMPO 6/5/2023 16:23:21'!
test02PortfolioCantAddAnAssociateAlredyPresentInAnotherPortfolio
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self should: [testingPortfolio3 addAssociate: testingAccount2 ] raise: E_AssociateAlredyInPortfolio . ! !

!Z_PortfoliosExtraTddTest methodsFor: 'tests' stamp: 'JMPO 6/5/2023 19:29:30'!
test03PortfolioCantAddHimselfAsAssociate

	self setUp.
	
	testingPortfolio1 addAssociate: testingAccount1 .
	
	self should: [testingPortfolio1 addAssociate: testingPortfolio1 ]  raise: E_SelfAditionOfPortfolio.! !

!Z_PortfoliosExtraTddTest methodsFor: 'tests' stamp: 'JMPO 6/5/2023 20:21:24'!
test04PortfolioCantAddAnAccountThatIsAlredyPresentInAnAlredyChargedPortfolio
	
	"testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self should: [testingPortfolio2 addAssociate: testingAccount1 ] raise: E_AssociateAlredyInPortfolio .
	
	El tiempo no alcanzo para implementar el 4to caso del extra
	"! !

!Z_PortfoliosExtraTddTest methodsFor: 'tests' stamp: 'JMPO 6/5/2023 19:11:07'!
test05CantAddAPortfolioThatHasAnAccountAlredyChargedInAnotherPortfolio
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount1 .
	
	self should: [testingPortfolio2 addAssociate: testingPortfolio1 ] raise: E_AssociateAlredyInPortfolio .
	
	"Este test evalúa un único nivel de profundidad, el tratar de agregar un portfolio de porfolios fallaría."
	! !


!classDefinition: #Z_PortfoliosTddTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #Z_PortfoliosTddTest
	instanceVariableNames: 'testingAccount1 testingAccount2 testingPortfolio1 testingPortfolio2 testingPortfolio3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 11:52:09'!
test01BalanceOfPortfolioIsBalanceOfAllAccounts
	
	Deposit register: (100*peso) on: testingAccount1 .
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio1 addAssociate: testingAccount2 .
	
	self assert: (testingPortfolio1 balance = (100*peso)).
	
	! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 11:37:08'!
test02PortfolioKnowsIfOneOfTheIntegratedAccountsRealizedAnOperation

	| deposit withdraw|
	
	deposit := Deposit register: (100*peso) on: testingAccount1 . 
	withdraw := Withdraw register: (50*peso) on: testingAccount2 . 
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio1 addAssociate: testingAccount2 .
	
	self assert: (testingPortfolio1 hasRegistered: deposit) .
	self assert: (testingPortfolio1 hasRegistered: withdraw) .! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 14:59:16'!
test03PortfolioCanAccessAllTransactionsOfAGivenAccount

	| deposit testingTransactions |
	
	deposit := Deposit register: (100*peso) on: testingAccount1.
	testingTransactions := OrderedCollection new initialize.
	testingTransactions add: deposit .
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio1 addAssociate: testingAccount2 .
	
	self assert: ((testingPortfolio1 transactionsOf: testingAccount1 ) = testingTransactions).
	self assert: ((testingPortfolio1 transactionsOf: testingAccount2 ) size = 0).
! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 12:03:32'!
test04EmptyPortfolioReturns0AsBalanceWhenEmpty
	
	self assert: (testingPortfolio1 balance = 0).
	
	"No necesariamente TDD, cubre un caso borde"! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 11:37:08'!
test05PortfolioFailsWhenTryingToFindANonExistingAssociate
	
	self should: [testingPortfolio1 transactionsOf: testingAccount1 ] raise: E_AssociateNotFound. ! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 11:48:30'!
test06BalanceOfAPortfolioOfPortfoliosIsBalanceOfAllPortfoliosSummed
	
	Deposit register: (100*peso) on: testingAccount1 .
	Deposit register: (200*peso) on: testingAccount2 .
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self assert: (testingPortfolio3 balance = (300*peso)).! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 11:49:52'!
test07PortfolioKnowsIfOneOfTheIntegratedAccountsInsideOfAPortfolioRealizedAnOperation

	| deposit withdraw|
	
	deposit := Deposit register: (100*peso) on: testingAccount1 . 
	withdraw := Withdraw register: (50*peso) on: testingAccount2 . 
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self assert: (testingPortfolio3 hasRegistered: deposit) .
	self assert: (testingPortfolio3 hasRegistered: withdraw) .! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/4/2023 14:59:09'!
test08PortfolioCanAccessAllTransactionsOfAGivenAccount

	| deposit testingTransactions |
	
	deposit := Deposit register: (100*peso) on: testingAccount1.
	testingTransactions := OrderedCollection new initialize.
	testingTransactions add: deposit .
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self assert: ((testingPortfolio3 transactionsOf: testingAccount1 ) = testingTransactions).
	self assert: ((testingPortfolio3 transactionsOf: testingAccount2 ) size = 0).
! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/5/2023 19:58:12'!
test09PortfolioCanAccessAllTransactionsOfAGivenAccountInsideAPortfolio

	| deposit testingTransactions |
	
	Deposit register: (100*peso) on: testingAccount1.
	deposit := Deposit register: (100*peso) on: testingAccount2.
	testingTransactions := OrderedCollection new initialize.
	testingTransactions add: deposit .
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio1 addAssociate: testingAccount2 .
	testingPortfolio2 addAssociate: testingPortfolio1 .
	
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self assert: ((testingPortfolio3 transactionsOf: testingAccount2 ) = testingTransactions).
	
	"Extiende un caso testeado con TDD"
! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/6/2023 12:48:12'!
test10PortfolioCanAccessAllTransactionsOfAAccountInsideHim
	
	| transaction transactionCollection |
	
	transactionCollection := OrderedCollection new initialize .

	transaction := Deposit register: (100*peso) on: testingAccount1 .
	transactionCollection add: transaction .
	transaction := Deposit register: (200*peso) on: testingAccount2 .
	transactionCollection add: transaction .
	
	testingPortfolio3 addAssociate: testingAccount1 .
	testingPortfolio3 addAssociate: testingAccount2 .
	
	self assert: (testingPortfolio3 transactions = transactionCollection ).
	
	"Estos tests viene a agregar una funcionalidad que, según debatido en Discord, es la que se debería haber implementado en primer lugar"
	"Nosotros interpretamos de la consigna al decir:  Se desea poder conocer todas las transacciones de una cuenta mediante otro mensaje que se buscaba acceder 
	a una cuenta en particular, no todas. Entendemos que eso da lugar a un caso de error, por eso el agregado de la excepción de AssociateNotFound."
	! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/6/2023 12:44:13'!
test11PortfolioOfPortfoliosCanAccessAllTransactionsOfAAccountInsideHim
	
	| transaction transactionCollection |
	
	transactionCollection := OrderedCollection new initialize .

	transaction := Deposit register: (100*peso) on: testingAccount1 .
	transactionCollection add: transaction .
	transaction := Deposit register: (200*peso) on: testingAccount2 .
	transactionCollection add: transaction .
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self assert: (testingPortfolio3 transactions = transactionCollection ).
	! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/6/2023 12:43:31'!
test12PortfolioKnowsIfOneOfTheIntegratedAccountsInsideOfAPortfolioOfPortfoliosRealizedAnOperation

	| deposit withdraw fourthPorfolio|
	
	deposit := Deposit register: (100*peso) on: testingAccount1 . 
	withdraw := Withdraw register: (50*peso) on: testingAccount2 . 
	
	fourthPorfolio := Portfolio new initialize.
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	testingPortfolio3 addAssociate: testingPortfolio1 .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	fourthPorfolio addAssociate: testingPortfolio3 .
	
	self assert: (fourthPorfolio hasRegistered: deposit) .
	self assert: (fourthPorfolio hasRegistered: withdraw) .
	
	"Este test extiende un caso testeado por TDD"! !

!Z_PortfoliosTddTest methodsFor: 'tests' stamp: 'JMPO 6/6/2023 12:43:36'!
test13PortfolioKnowsIfOneOfTheIntegratedAccountsInsideOfAPortfoliosSystemRealizedAnOperation

	| deposit withdraw intermediatePorfolio|
	
	deposit := Deposit register: (100*peso) on: testingAccount1 . 
	withdraw := Withdraw register: (50*peso) on: testingAccount2 . 
	
	intermediatePorfolio := Portfolio new initialize.
	
	testingPortfolio1 addAssociate: testingAccount1 .
	testingPortfolio2 addAssociate: testingAccount2 .
	
	intermediatePorfolio addAssociate: testingPortfolio1 .
	
	testingPortfolio3 addAssociate: intermediatePorfolio .
	testingPortfolio3 addAssociate: testingPortfolio2 .
	
	self assert: (testingPortfolio3 hasRegistered: deposit) .
	self assert: (testingPortfolio3 hasRegistered: withdraw) .
	
	"Este test extiende un caso testeado por TDD"! !


!Z_PortfoliosTddTest methodsFor: 'setUp' stamp: 'JMPO 6/4/2023 11:39:17'!
setUp
	
	testingAccount1 := ReceptiveAccount new initialize .
	testingAccount2 := ReceptiveAccount new initialize .
	testingPortfolio1 := Portfolio new initialize .
	testingPortfolio2 := Portfolio new initialize .
	testingPortfolio3 := Portfolio new initialize .! !


!classDefinition: #Z_ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #Z_ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 16:26:35'!
test02DepositIncreasesBalanceOnOperationValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 16:26:44'!
test03WithdrawDecreasesBalanceOnOperationValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 16:26:09'!
test05ReceptiveAccountKnowsRegisteredOperations 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 16:26:17'!
test06ReceptiveAccountDoNotKnowNotRegisteredOperations

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!Z_ReceptiveAccountTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 16:26:24'!
test07AccountKnowsItsOperations 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #Z_TransferencesTddTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #Z_TransferencesTddTest
	instanceVariableNames: 'transferingAccountTest receiverAccountTest transferenceRealizedTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Z_TransferencesTddTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 14:15:38'!
test01TransferenceBetweenTwoUsersImpactsBothAccounts

	Deposit register: (100*peso) on: transferingAccountTest .
	
	transferingAccountTest transferTo: receiverAccountTest anAmountOf: (100*peso).
		
	self assert: (transferingAccountTest balance = (0*peso)).
	self assert: (receiverAccountTest balance = (100*peso)).
	! !

!Z_TransferencesTddTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 14:17:01'!
test02TransferenceKnowsTheValueOfInterAccountOperation

	Deposit register: (100*peso) on: transferingAccountTest .
	
	transferenceRealizedTest := transferingAccountTest transferTo: receiverAccountTest anAmountOf: (100*peso)	.
	
	self assert: (transferenceRealizedTest value = (100*peso)).! !

!Z_TransferencesTddTest methodsFor: 'tests' stamp: 'JMPO 6/3/2023 14:17:33'!
test03BothPartsOfATransferenceKnowEachOther
	
	Deposit register: (100*peso) on: transferingAccountTest .
	
	transferenceRealizedTest := transferingAccountTest transferTo: receiverAccountTest  anAmountOf: (100*peso). 
	
	self assert: (transferenceRealizedTest moneyExit = ((transferenceRealizedTest moneyEntrance) exitReference)).
	self assert: (transferenceRealizedTest moneyEntrance = ((transferenceRealizedTest moneyExit ) entranceReference)).
	! !


!Z_TransferencesTddTest methodsFor: 'setUp' stamp: 'JMPO 6/3/2023 14:15:08'!
setUp
	
	transferingAccountTest := ReceptiveAccount new initialize .
	
	receiverAccountTest := ReceptiveAccount new initialize .! !


!classDefinition: #AccountOperation category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountOperation
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountOperation methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:45:36'!
impactOnBalance
	
	self subclassResponsibility .! !

!AccountOperation methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:45:15'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountOperation class' category: 'ServiciosFinancieros-Ejercicio'!
AccountOperation class
	instanceVariableNames: ''!

!AccountOperation class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountOperation subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:44:23'!
impactOnBalance
	
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountOperation subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:45:51'!
impactOnBalance
	
	^value negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #InterAccountOperation category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #InterAccountOperation
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!InterAccountOperation methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:46:11'!
impactOnBalance
	
	self subclassResponsibility .! !

!InterAccountOperation methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:28:17'!
referenceToCounterpart: aReference
	
	self subclassResponsibility .! !


!InterAccountOperation methodsFor: 'initialize' stamp: 'JMPO 6/3/2023 13:26:19'!
initializeWithValue: anAmounOfPesos
	
	value := anAmounOfPesos ! !


!classDefinition: #EntranceOfMoney category: 'ServiciosFinancieros-Ejercicio'!
InterAccountOperation subclass: #EntranceOfMoney
	instanceVariableNames: 'exitReference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!EntranceOfMoney methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:06:21'!
exitReference
	
	^exitReference .! !


!EntranceOfMoney methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:46:23'!
impactOnBalance
	
	^value.! !

!EntranceOfMoney methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:28:07'!
referenceToCounterpart: aReferenceTomoneyExit

	exitReference := aReferenceTomoneyExit .! !


!classDefinition: #ExitOfMoney category: 'ServiciosFinancieros-Ejercicio'!
InterAccountOperation subclass: #ExitOfMoney
	instanceVariableNames: 'entranceReference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ExitOfMoney methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:06:33'!
entranceReference
	
	^entranceReference .! !


!ExitOfMoney methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:46:37'!
impactOnBalance
	
	^value negated.! !

!ExitOfMoney methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:28:41'!
referenceToCounterpart: aReferenceToMoneyEntrance
	
	entranceReference := aReferenceToMoneyEntrance .! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'associates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'JMPO 6/3/2023 14:28:48'!
initialize
	
	associates := OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 16:21:37'!
hasRegistered: anOperation 
	
	| found |
	found := false.
	
	associates do: [:anAssociate | (anAssociate hasRegistered: anOperation) ifTrue: [found := true]].
	
	^found.! !

!Portfolio methodsFor: 'accessing' stamp: 'JMPO 6/6/2023 12:42:00'!
transactions

	| transactionsOfAssociatesInPortfolio |
	transactionsOfAssociatesInPortfolio := OrderedCollection new initialize .
	
	associates do: [:anAssociate | transactionsOfAssociatesInPortfolio addAllLast: anAssociate transactions].
	
	^transactionsOfAssociatesInPortfolio .! !

!Portfolio methodsFor: 'accessing' stamp: 'JMPO 6/5/2023 20:08:14'!
transactionsOf: anAccount
	
	| resultOfSearch |
	
	resultOfSearch := self cycleTroughAssociatesForTransactionsCopyOf: anAccount .
	
	(resultOfSearch = -1) ifTrue: [^E_AssociateNotFound signal.].
	
	^resultOfSearch .
	
	
	! !


!Portfolio methodsFor: 'private' stamp: 'JMPO 6/5/2023 20:12:49'!
AssociateAlredyPresent: anAssociateToCheck
	
	| found |
	found := false.
	
	associates ifEmpty: [^found].
	associates do: [:anAssociate | (anAssociate AssociateAlredyPresent: anAssociateToCheck ) ifTrue: [^(found := true)] ].
	
	^found.! !

!Portfolio methodsFor: 'private' stamp: 'JMPO 6/5/2023 15:30:26'!
copyTransactionsDataifAccountRepresents: anAccount
	
	^self cycleTroughAssociatesForTransactionsCopyOf: anAccount.! !

!Portfolio methodsFor: 'private' stamp: 'JMPO 6/5/2023 15:30:17'!
cycleTroughAssociatesForTransactionsCopyOf: anAccount
	
	| copy |
	associates do: [:anAssociate | copy := anAssociate copyTransactionsDataifAccountRepresents: anAccount. 
		(copy = -1) ifFalse: [^copy]
	].
	
	^-1.! !


!Portfolio methodsFor: 'main protocol' stamp: 'JMPO 6/5/2023 20:04:37'!
addAssociate: anAssociate
	
	"anAssociate es un portfolio ---> reviso cada elemento
	anAssociate es un ReceptiveAccount ---> reviso solo ese elemento"
	
	(anAssociate = self) ifTrue: [^E_SelfAditionOfPortfolio signal].
	
	(anAssociate PresentIn: self) ifFalse: [^associates add: anAssociate ].
	
	^E_AssociateAlredyInPortfolio signal.! !

!Portfolio methodsFor: 'main protocol' stamp: 'JMPO 6/5/2023 15:12:52'!
balance
	
	| totalBalance |
	
	totalBalance := 0.
	
	associates ifEmpty: [^totalBalance ].
	associates do: [:anAssociate | totalBalance := totalBalance + anAssociate balance ].
	
	^totalBalance .
! !


!Portfolio methodsFor: 'DD - search for adding' stamp: 'JMPO 6/5/2023 20:12:48'!
PresentIn: aFatherAssociate
	
	associates do: [:anAssociateInside | (aFatherAssociate AssociateAlredyPresent: anAssociateInside) ifTrue: [^true.] ].
	
	^false.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JMPO 6/5/2023 20:12:48'!
AssociateAlredyPresent: anAssociate
	
	^(self = anAssociate ).! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JMPO 6/3/2023 13:55:50'!
balance

	| cuenta |
	
	cuenta := 0.
	
	transactions ifEmpty: [^cuenta].
	
	transactions do: [:aTransaction | cuenta:= cuenta + (aTransaction impactOnBalance) ].	
	
	^cuenta.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JMPO 6/4/2023 14:10:54'!
copyTransactionsDataifAccountRepresents: anAccount
	
	(anAccount = self) ifTrue: [^self transactions ].
	
	^-1.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'JMPO 6/4/2023 15:57:29'!
transferTo: anAccount anAmountOf: anAmountOfPesos
	
	^TransferenceBetweenAccounts newTransferenceFrom: self to: anAccount forAnAmoutOf: anAmountOfPesos .! !


!ReceptiveAccount methodsFor: 'DD - search for adding' stamp: 'JMPO 6/5/2023 20:12:48'!
PresentIn: aFatherAssociate
	
	^(aFatherAssociate AssociateAlredyPresent: self ).! !


!classDefinition: #TransferenceBetweenAccounts category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferenceBetweenAccounts
	instanceVariableNames: 'exit entrance value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceBetweenAccounts methodsFor: 'initialization' stamp: 'JMPO 6/3/2023 13:34:09'!
initializeWithSender: aSenderAccount to: aReceiverAccount forPesos: anAmountOfPesos .
		
	value := anAmountOfPesos .
	
	entrance := (EntranceOfMoney new initializeWithValue: anAmountOfPesos).
	exit := (ExitOfMoney new initializeWithValue: anAmountOfPesos ).
	
	entrance referenceToCounterpart: exit.
	exit referenceToCounterpart: entrance.
	
	aReceiverAccount register: entrance.
	aSenderAccount register: exit.
! !


!TransferenceBetweenAccounts methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:05:52'!
moneyEntrance
	
	^entrance .! !

!TransferenceBetweenAccounts methodsFor: 'accessing' stamp: 'JMPO 6/3/2023 13:05:43'!
moneyExit
	
	^exit.! !

!TransferenceBetweenAccounts methodsFor: 'accessing' stamp: 'JMPO 6/2/2023 19:34:51'!
value
	
	^value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceBetweenAccounts class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceBetweenAccounts class
	instanceVariableNames: ''!

!TransferenceBetweenAccounts class methodsFor: 'as yet unclassified' stamp: 'JMPO 6/2/2023 19:32:49'!
newTransferenceFrom: aSenderAccount to: aReceiverAccount forAnAmoutOf: anAmountOfPesos .
	
	^self new initializeWithSender: aSenderAccount to: aReceiverAccount forPesos: anAmountOfPesos .! !
