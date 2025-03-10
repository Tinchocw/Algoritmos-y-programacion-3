!classDefinition: #StackTest category: 'Stack-Preludio'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!StackTest methodsFor: 'as yet unclassified' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !


!classDefinition: #Stack category: 'Stack-Preludio'!
Object subclass: #Stack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!Stack methodsFor: 'Operations' stamp: 'JMPO 5/5/2023 15:24:35'!
pop
	| elementPopped |
	(elements isEmpty) ifTrue: [^'Error!! Stack is empty.'].
	
	elementPopped := elements at: (elements size) .
	elements removeAt: (elements size).
	
	^elementPopped .
	! !

!Stack methodsFor: 'Operations' stamp: 'JMPO 5/5/2023 15:09:20'!
stackItem: itemToStack
	
	elements add: itemToStack .! !

!Stack methodsFor: 'Operations' stamp: 'JMPO 5/5/2023 14:34:46'!
stackTop
	
	^elements at: (elements size).! !


!Stack methodsFor: 'Initialization' stamp: 'JMPO 5/5/2023 15:08:30'!
InitializeStack

	elements := OrderedCollection new.! !

!Stack methodsFor: 'Initialization' stamp: 'JMPO 5/5/2023 15:13:12'!
InitializeStackWith: elementToStack
	
	elements := OrderedCollection new .
	elements add: elementToStack .
	
! !


!Stack methodsFor: 'Testing' stamp: 'JMPO 5/5/2023 15:28:38'!
isEmpty

	^elements isEmpty. ! !
