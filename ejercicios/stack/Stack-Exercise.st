!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'testingFinder testingStack testingConcordancesCollection testingNonConcordancesCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:39:22'!
test01EmptyStackReturnsNoConcordances
	
	testingFinder find: 'test'.
	
	self assert: (testingFinder hasNumberOfConcordances: 0) .! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:39:28'!
test02CantSearchWithAnEmptyPrefix
	
	self 
		should: [testingFinder find: '']
		raise: Error
		withExceptionDo: [ :anError | self assert: SentenceFinderByPrefix prefixCannotBeEmptyStringErrorMessage equals: anError messageText ].! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:39:37'!
test03PrefixCannotBeSeparatedBySpaces
	
	self
		should: [testingFinder find: 'tes t']
		raise: Error
		withExceptionDo: [ :anError | self assert: SentenceFinderByPrefix prefixCantHaveSpacesErrorMessage equals: anError messageText ].! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:39:56'!
test04FinderFindsConcordanceWithOnlyStackedElement
	
	testingStack push: 'test'.
	
	testingFinder find: 't'.
	
	testingConcordancesCollection add: 'test'.
	
	self assert: (testingFinder foundConcordances: testingConcordancesCollection ).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:53:04'!
test05FinderFindsNoConcordancesWhenPrefixMatchesWithNone

	testingStack push: 'firstPush'.
	testingStack push: 'seconPush'.
	testingStack push: 'thirdPush'.
	testingStack push: 'fourthPush'.
	
	testingFinder find: 'AtestingPrefix'.
	
	self assert: (testingFinder hasNumberOfConcordances: 0).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:40:41'!
test06FinderHasNonRepeatedConcordances
	
	testingStack push: 'thisisatest'.
	testingStack push: 'thisisaTest'.
	testingStack push: 'thisIsATest'.
	testingStack push: 'shouldNotAdd'.
		
	testingFinder find: 'th'.

	testingConcordancesCollection add: 'thisIsATest'.
	testingConcordancesCollection add: 'thisisaTest'.
	testingConcordancesCollection add: 'thisisatest'.
	
	self assert: (testingFinder foundConcordances: testingConcordancesCollection ).
	self assert: (testingFinder hasNumberOfConcordances: 3).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:38:52'!
test07FinderSortsConcordancesAsLIFO
	
	testingStack push: 'thisShouldBeLast'.
	testingStack push: 'thisShouldBeMiddle'.
	testingStack push: 'thisShouldBeFirst'.
		
	testingFinder find: 'this'.

	testingConcordancesCollection add: 'thisShouldBeFirst'.
	testingConcordancesCollection add: 'thisShouldBeMiddle'.
	testingConcordancesCollection add: 'thisShouldBeLast'.
	
	self assert: (testingFinder foundConcordances: testingConcordancesCollection ).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:41:28'!
test08FinderIsCaseSensitive
	
	testingStack push: 'thisisatest'.
	testingStack push: 'ThisIsATest'.
	testingStack push: 'tHisIsaTest'.
	testingStack push: 'THISISATEST'.
		
	testingFinder find: 'th'.
	
	testingConcordancesCollection add: 'thisisatest'.
	testingNonConcordancesCollection add: 'tHisIsaTest'.
	
	self assert: (testingFinder foundConcordances: testingConcordancesCollection ).
	self deny: (testingFinder foundConcordances: testingNonConcordancesCollection ).! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JMPO 5/8/2023 12:39:10'!
setUp

	testingStack := OOStack new initialize.
	testingFinder := SentenceFinderByPrefix new initalizeWith: testingStack .
	testingConcordancesCollection := OrderedCollection new.
	testingNonConcordancesCollection := OrderedCollection new.! !


!classDefinition: #ElementOfStack category: 'Stack-Exercise'!
Object subclass: #ElementOfStack
	instanceVariableNames: 'referencedElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementOfStack methodsFor: 'counting' stamp: 'MC 5/6/2023 14:53:26'!
countDown
	self subclassResponsibility .! !


!ElementOfStack methodsFor: 'accessing' stamp: 'MC 5/6/2023 15:00:21'!
ElementUnder
	
	self subclassResponsibility .! !

!ElementOfStack methodsFor: 'accessing' stamp: 'MC 5/6/2023 15:00:38'!
ValueInElement

	self subclassResponsibility .! !


!classDefinition: #BaseOfStack category: 'Stack-Exercise'!
ElementOfStack subclass: #BaseOfStack
	instanceVariableNames: 'elementAbove'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseOfStack methodsFor: 'counting' stamp: 'JMPO 5/8/2023 12:55:42'!
countDown
	^0.! !


!BaseOfStack methodsFor: 'accessing' stamp: 'MC 5/6/2023 15:00:21'!
ElementUnder
	self shouldNotImplement .! !

!BaseOfStack methodsFor: 'accessing' stamp: 'JMPO 5/9/2023 02:56:34'!
ValueInElement
	self error: OOStack stackEmptyErrorDescription .! !


!classDefinition: #StackableElement category: 'Stack-Exercise'!
ElementOfStack subclass: #StackableElement
	instanceVariableNames: 'elementValue elementUnder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackableElement methodsFor: 'accessing' stamp: 'MC 5/6/2023 15:00:21'!
ElementUnder

	^elementUnder .
	
	
	! !

!StackableElement methodsFor: 'accessing' stamp: 'MC 5/6/2023 15:00:38'!
ValueInElement
	 
	^elementValue .! !


!StackableElement methodsFor: 'counting' stamp: 'MC 5/6/2023 14:52:39'!
countDown
	^ 1 + elementUnder countDown.! !


!StackableElement methodsFor: 'initialization' stamp: 'JMPO 5/5/2023 19:37:14'!
initializeWith: aValue under: elementUnderneat
	 
	elementValue := aValue .
	elementUnder := elementUnderneat .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackableElement class' category: 'Stack-Exercise'!
StackableElement class
	instanceVariableNames: 'elementValue elementUnder'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:56:52'!
isEmpty
	
	^(topElement countDown = 0).! !

!OOStack methodsFor: 'testing' stamp: 'JMPO 5/8/2023 12:53:42'!
size

	^topElement  countDown.! !


!OOStack methodsFor: 'initialization' stamp: 'JMPO 5/8/2023 12:55:12'!
initialize
	
	topElement := BaseOfStack new.
	! !


!OOStack methodsFor: 'operations' stamp: 'MC 5/6/2023 15:10:06'!
pop

	| valueOnTop |	
	
	valueOnTop := topElement ValueInElement .
	
	topElement := topElement ElementUnder .
	
	^valueOnTop.
! !

!OOStack methodsFor: 'operations' stamp: 'JMPO 5/8/2023 12:54:48'!
push: valueToPush

	| newElement |
	newElement := StackableElement new initializeWith: valueToPush under: topElement .
	
	topElement := newElement .
	
! !

!OOStack methodsFor: 'operations' stamp: 'MC 5/6/2023 15:10:30'!
top
	
	^topElement ValueInElement .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackToAnalize concordancesFound'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'MC 5/6/2023 16:29:41'!
compare: elementToCompare withPrefix: aPrefix
	
  	(elementToCompare is: aPrefix  substringAt: 1) ifTrue: [concordancesFound add: elementToCompare ].
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'MC 5/6/2023 16:14:47'!
initalizeWith: aStack
	
	concordancesFound := OrderedCollection new.
	stackToAnalize := aStack.
	! !


!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'JMPO 5/9/2023 03:18:09'!
find: aPrefix
	| auxiliarStack  elementPopped |
	
	(aPrefix isEmpty ) ifTrue: [^self signalPrefixCannotBeEmptyString ]. 
	
	(aPrefix includesSubString: ' ')ifTrue: [^self signalPrefixCantHaveSpaces ]. 
	
	"Estos ifs no hablan de un posible polimorfismo en el método en nuestra opinión, implicaría una sobrecomplejización del problema sacarlos (similar al caso de Fibonacci)."
	
	auxiliarStack := OOStack new.
	
	[stackToAnalize size > 0] whileTrue: [
		
		elementPopped := stackToAnalize pop.
		auxiliarStack push: elementPopped .
		
		self compare: elementPopped withPrefix: aPrefix.
		
		].
	^concordancesFound .
	

! !


!SentenceFinderByPrefix methodsFor: 'exceptions' stamp: 'JMPO 5/7/2023 20:03:07'!
signalPrefixCannotBeEmptyString

	self error: self class prefixCannotBeEmptyStringErrorMessage ! !

!SentenceFinderByPrefix methodsFor: 'exceptions' stamp: 'JMPO 5/7/2023 20:08:30'!
signalPrefixCantHaveSpaces

	self error: self class prefixCantHaveSpacesErrorMessage .! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'JMPO 5/9/2023 03:23:40'!
foundConcordances: aCollectionOfConcordances
	"Si bien se podía testear haciendo esta colaboración en los test (Osea analizando el return de find:), nos pareció más claro enviarle un mensaje al finder
	aunque técnicamente catalogue como código repetido"
	^(concordancesFound = aCollectionOfConcordances) .
	! !

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'JMPO 5/8/2023 00:02:16'!
hasNumberOfConcordances: aNumber
	
	^(concordancesFound size = aNumber ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JMPO 5/7/2023 20:06:46'!
prefixCannotBeEmptyStringErrorMessage
	
	^'Error!! Prefix cannot be an empty string'.! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JMPO 5/7/2023 20:06:56'!
prefixCantHaveSpacesErrorMessage

	 ^'Error!! Prefix cant be separated by spaces.'! !
