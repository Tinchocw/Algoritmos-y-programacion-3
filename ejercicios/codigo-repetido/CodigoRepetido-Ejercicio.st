!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/23/2023 12:17:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.

	self assertThatAction: [customerBook addCustomerNamed: 'John Lennon'] doesNotTakeMoreThan: (50 * millisecond). 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:25:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThatAction: [customerBook removeCustomerNamed: paulMcCartney.]  doesNotTakeMoreThan: (100 * millisecond) .  
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:25:56'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self onEvent: [customerBook addCustomerNamed: ''.] failWithError: Error andPerformAssertion: [:anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty ] .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:26:06'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self onEvent: [customerBook removeCustomerNamed: 'Paul McCartney'.] failWithError: NotFound  andPerformAssertion: [
		:anError | self assertThat: customerBook hasSomeoneNamed: johnLennon andTotalAmountOfMembersIs: 1] .

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:26:13'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook HasNumberOfActiveMembers: 0  suspendedMembers: 1  andTotalMembers: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:26:20'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook HasNumberOfActiveMembers: 0  suspendedMembers: 0  andTotalMembers: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:26:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self onEvent: [customerBook suspendCustomerNamed: 'Ringo Starr'.] failWithError: CantSuspend andPerformAssertion: [
		:anError | self assertThat: customerBook hasSomeoneNamed: johnLennon andTotalAmountOfMembersIs: 1] .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JMPO 4/24/2023 19:26:39'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
		
	self onEvent: [customerBook suspendCustomerNamed: johnLennon] failWithError: CantSuspend  andPerformAssertion: [
		:anError | self assertThat: customerBook hasSomeoneNamed: johnLennon andTotalAmountOfMembersIs: 1] .
	! !


!CustomerBookTest methodsFor: 'private' stamp: 'JMPO 4/23/2023 12:39:24'!
assertThat: bookToRead HasNumberOfActiveMembers: activeAmount suspendedMembers: suspendedAmount andTotalMembers: totalAmount
	self assert: activeAmount equals: bookToRead numberOfActiveCustomers. 
	self assert: suspendedAmount equals: bookToRead numberOfSuspendedCustomers.
	self assert: totalAmount equals: bookToRead numberOfCustomers.! !

!CustomerBookTest methodsFor: 'private' stamp: 'JMPO 4/23/2023 15:37:23'!
assertThat: bookToRead hasSomeoneNamed: nameOfTheCustomer andTotalAmountOfMembersIs: totalAmount	
	self assert: (bookToRead numberOfCustomers = totalAmount) .
	self assert: (bookToRead includesCustomerNamed: nameOfTheCustomer ) .! !

!CustomerBookTest methodsFor: 'private' stamp: 'JMPO 4/24/2023 17:03:06'!
assertThatAction: actionToBeTimed doesNotTakeMoreThan: timeToCompare
	| executionTIme |
	
	executionTIme := self timeInPerformingAction: actionToBeTimed .
	
	self assert: (executionTIme < timeToCompare ) .! !

!CustomerBookTest methodsFor: 'private' stamp: 'JMPO 4/24/2023 18:08:54'!
onEvent: eventToTrigger failWithError: errorClass andPerformAssertion: assertionToPerform
	[ eventToTrigger value . 
	self fail ]
		on: errorClass 
		do: [ :anError | 
			assertionToPerform value: anError ].
	! !

!CustomerBookTest methodsFor: 'private' stamp: 'JMPO 4/24/2023 17:01:58'!
timeInPerformingAction: actionToBeTimed
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	actionToBeTimed value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning  - millisecondsBeforeRunning ).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'JMPO 4/24/2023 18:04:54'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JMPO 4/24/2023 17:34:52'!
numberOfCustomers
	
	^(self numberOfActiveCustomers + self numberOfSuspendedCustomers ).! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JMPO 4/24/2023 17:32:45'!
removeCustomerNamed: aName 

	^active remove: aName ifAbsent: [
		^suspended remove: aName ifAbsent: [
			^NotFound signal
			.] 
		] .

	

	


! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'JMPO 4/24/2023 19:25:20'!
suspendCustomerNamed: aName 

	(active remove: aName ifAbsent: [^CantSuspend signal]).
	suspended add: aName.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
