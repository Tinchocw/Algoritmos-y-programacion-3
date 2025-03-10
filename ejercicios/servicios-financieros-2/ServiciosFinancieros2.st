!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balanceOfPortfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balanceOfPortfolio equals: portfolio balanceOfPortfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balanceOfPortfolio + simplePortfolio balanceOfPortfolio) equals: composedPortofolio balanceOfPortfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balanceOfPortfolio
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balanceOfPortfolio
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balanceOfPortfolio
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportsTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:41:38'!
test01AnAccountWithNoTransactionsReturnsAnEmptyReport
	
	| testingAccount emptySummary report |
	testingAccount := ReceptiveAccount new .
	
	emptySummary := OrderedCollection new.
	emptySummary add: 'Balance = 0 pesos'.
	
	report := AccountSummary ofAccount: testingAccount .
	
	self assert: (report generate = emptySummary).! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:41:46'!
test02AnAccountWithDepositReturnsAReport
	
	| testingAccount summary report |
	testingAccount := ReceptiveAccount new .
	Deposit register: 100 * peso on: testingAccount.
	
	summary := OrderedCollection  with:'Depósito por 100 pesos' 
				  					  with: 'Balance = 100 pesos'.

	report := AccountSummary ofAccount: testingAccount .	

	
	self assert: (report generate = summary).! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:41:52'!
test03AnAccountWithWithdrawReturnsAReport
	
	| testingAccount summary report |
	testingAccount := ReceptiveAccount new .
	Deposit register: 100 * peso on: testingAccount.
	Withdraw register: 50 * peso on: testingAccount.
	
	
	summary := OrderedCollection with: 'Depósito por 100 pesos' 
							      with:'Extracción por 50 pesos' 
				  			      with: 'Balance = 50 pesos'.

	report := AccountSummary ofAccount: testingAccount .
	
	self assert: (report generate = summary).! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:41:59'!
test04TransactionsBetweenAccountsAreSeenOnReports
	
	| testingAccount1 testingAccount2 summaryAccount1 summaryAccount2 report1 report2 |
	
	self setUp .
	
	testingAccount1 := ReceptiveAccount new .
	Deposit register: 100 * peso on: testingAccount1.
	
	testingAccount2 := ReceptiveAccount new .
	
	Transfer amount: 20 * peso from: testingAccount1  to: testingAccount2.
	
	
	summaryAccount1 := OrderedCollection 
							      with: 'Depósito por 100 pesos'
							      with: 'Salida por transferencia de 20 pesos'
				  			      with: 'Balance = 80 pesos'.
							
	summaryAccount2  := OrderedCollection 
							      with: 'Entrada por transferencia de 20 pesos'
				  			      with: 'Balance = 20 pesos'.

	report1 := AccountSummary ofAccount: testingAccount1 .
	report2 := AccountSummary ofAccount: testingAccount2 .
	
	self assert: ( report1 generate = summaryAccount1 ).
	self assert: (report2 generate = summaryAccount2 ).! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:42:04'!
test05PortfolioWithNoTransactionsReturnsAnEmptyReport
	
	| testingPortfolio testingAccount  summary report |
	
	testingAccount := ReceptiveAccount new.
	testingPortfolio := Portfolio with:  testingAccount .
	
	summary := OrderedCollection with: 'Balance = 0 pesos'.
	
	report := AccountSummary ofAccount: testingPortfolio .
	
	self assert: (report  generate ) equals: summary.! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:42:11'!
test06PortfolioWithDepositsReturnsAReport
	
	| testingPortfolio testingAccount  summary  report |
	
	testingAccount := ReceptiveAccount new .
	Deposit register: 100 * peso on: testingAccount.
	Withdraw register: 50 * peso on: testingAccount.
 
	testingPortfolio := Portfolio with:  testingAccount .
	
	summary := OrderedCollection with: 'Depósito por 100 pesos' 
							      with: 'Extracción por 50 pesos' 
							      with: 'Balance = 50 pesos' .
	
	report := AccountSummary ofAccount: testingPortfolio .
	
	self assert: (report  generate ) equals: summary.! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:42:19'!
test07PortfoliosReportIfTheyWereTheLegOfATransference
	
	| testingPortfolio1 testingPortfolio2 testingAccount1 testingAccount2 summary1
	summary2  report1 report2|
	
	testingAccount1 := ReceptiveAccount new.
	Deposit register: 100 * peso on: testingAccount1.
	
	testingAccount2 := ReceptiveAccount new.
	
	Transfer amount: 50 * peso from: testingAccount1  to: testingAccount2. 
 
	testingPortfolio1 := Portfolio with:  testingAccount1.
	testingPortfolio2 := Portfolio with:  testingAccount2.
	
	summary1 := OrderedCollection with: 'Depósito por 100 pesos' 
							        with: 'Salida por transferencia de 50 pesos'
							        with: 'Balance = 50 pesos' .
							
	summary2 := OrderedCollection with:  'Entrada por transferencia de 50 pesos'
							        with: 'Balance = 50 pesos' .
							
	report1 := AccountSummary ofAccount: testingPortfolio1 .
	report2 := AccountSummary ofAccount: testingPortfolio2 .
	
	self assert: (report1  generate ) equals: summary1.
	self assert: (report2  generate ) equals: summary2.! !

!ReportsTest methodsFor: 'AccountSummary tests' stamp: 'JMPO 6/13/2023 14:42:39'!
test08PortfolioOfPortfoliosCanHaveBothPartsOfTransferences
	
	| testingPortfolio1 testingPortfolio2 testingPortfolio3 testingAccount1 testingAccount2 summary report |
	
	testingAccount1 := ReceptiveAccount new.
	Deposit register: 100 * peso on: testingAccount1.
	
	testingAccount2 := ReceptiveAccount new.
	
	Transfer amount: 50 * peso from: testingAccount1  to: testingAccount2. 
 
	testingPortfolio1 := Portfolio with:  testingAccount1.
	testingPortfolio2 := Portfolio with:  testingAccount2.
	testingPortfolio3 := Portfolio with:  testingPortfolio1  with: testingPortfolio2.
	
	summary := OrderedCollection  with: 'Depósito por 100 pesos' 
							        	  with: 'Salida por transferencia de 50 pesos'
								   with:  'Entrada por transferencia de 50 pesos'
							           with: 'Balance = 100 pesos' .

	report := AccountSummary ofAccount: testingPortfolio3 .
	
	self assert: (report  generate ) equals: summary.
! !


!ReportsTest methodsFor: 'TransferNet tests' stamp: 'JMPO 6/13/2023 14:42:46'!
test01AnEmptyAccountReturnsATransferNetOfZero
	
	| testingAccount report |
	testingAccount := ReceptiveAccount new .
	
	report := AccountTransferNet ofAccount: testingAccount .
	
	self assert: (report generate = (0*peso)).! !

!ReportsTest methodsFor: 'TransferNet tests' stamp: 'JMPO 6/12/2023 20:18:02'!
test02AnAccountThatReceivedATransferenceShowsItsImpactOnTransferNet
	
	| destinationAccount originAccount originReport destinationReport |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	originReport := AccountTransferNet ofAccount: originAccount .
	destinationReport := AccountTransferNet ofAccount: destinationAccount .
	
	self assert: (destinationReport generate = (2*peso)).
	self assert: (originReport generate = (-2*peso)).! !

!ReportsTest methodsFor: 'TransferNet tests' stamp: 'JMPO 6/13/2023 14:42:54'!
test03EmptyPortfolioReturnsATransferNetOfZero
	
	| portfolio report |
		
	portfolio := Portfolio new .
	
	report := AccountTransferNet ofAccount: portfolio .
	
	self assert: (report generate = (0*peso)).
	
	! !

!ReportsTest methodsFor: 'TransferNet tests' stamp: 'JMPO 6/13/2023 14:42:58'!
test04APortfolioWithNoTranferencesReturnsATransferNetOfZero
	
	| account portfolio report |
	
	account := ReceptiveAccount new .
	Deposit register: 10 * peso on: account .
	Withdraw register: 5 * peso on: account .
	
	portfolio := Portfolio with: account .
	
	report := AccountTransferNet ofAccount: portfolio .
	
	self assert: (report generate = (0*peso)).
	
	! !

!ReportsTest methodsFor: 'TransferNet tests' stamp: 'JMPO 6/12/2023 21:43:55'!
test05APortfolioTracksTransferencesBetweenAccounts
	
	| destinationPortfolio destinationAccount originPortfolio originAccount account originReport destinationReport|
	
	account := ReceptiveAccount new.
	Deposit register: 10 * peso on: account .
	destinationAccount := ReceptiveAccount new.
	originAccount := ReceptiveAccount new.
	
	Transfer amount: 2 * peso from: account to: destinationAccount .	
	Transfer amount: 2 * peso from: originAccount to: account.
	
	destinationPortfolio := Portfolio with: destinationAccount .
	originPortfolio := Portfolio with: originAccount .
	
	originReport := AccountTransferNet ofAccount: originPortfolio .
	destinationReport := AccountTransferNet ofAccount: destinationPortfolio .
	
	self assert: (originReport generate = (-2*peso)).
	self assert: (destinationReport generate = (2*peso)).! !

!ReportsTest methodsFor: 'TransferNet tests' stamp: 'JMPO 6/12/2023 20:22:27'!
test06APortfolioOfPortfoliosTracksTransferencesBetweenAccounts
	
	| fatherPortfolio destinationPortfolio destinationAccount originPortfolio originAccount account report|
	
	account := ReceptiveAccount new.
	Deposit register: 10 * peso on: account .
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	Transfer amount: 1 * peso from: account to: originAccount.
		
	destinationAccount := ReceptiveAccount new.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	destinationPortfolio := Portfolio with: destinationAccount .
	originPortfolio := Portfolio with: originAccount .
	fatherPortfolio := Portfolio with: destinationPortfolio with: originPortfolio .
	
	report := AccountTransferNet ofAccount: fatherPortfolio .
	
	self assert: (report generate = (1*peso)).! !


!classDefinition: #SpecialReportsTests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #SpecialReportsTests
	instanceVariableNames: 'testingTreePrinter testingTreeString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!SpecialReportsTests methodsFor: 'portfolio tree printer - TDD' stamp: 'JMPO 6/13/2023 14:46:32'!
test01AnEmptyPortfolioPrintsItsOwnName
	
	| portfolio |
	
	portfolio := Portfolio newWithName: 'Familia Pérez'.
	testingTreePrinter := PortfolioTreePrinter forPortfolio: portfolio.	
	
	testingTreeString :=  'Portfolio de Familia Pérez',
	(Character newLineCharacter asString).
	
	self assert: ( testingTreePrinter stringTree = testingTreeString ).	
	
	
	! !

!SpecialReportsTests methodsFor: 'portfolio tree printer - TDD' stamp: 'JMPO 6/13/2023 14:49:41'!
test02APortfolioWithAnAccountPrintsWithCorrectIndentation
	
	| portfolio account |
	
	account := ReceptiveAccount newWithName: 'Jorge Pérez'.
	portfolio := Portfolio withName: 'Familia Pérez' with: account .
	
	testingTreePrinter := PortfolioTreePrinter forPortfolio: portfolio.	
	
	testingTreeString :=
	'Portfolio de Familia Pérez',
	(Character newLineCharacter asString), 
	'    Cuenta de Jorge Pérez',
	(Character newLineCharacter asString).
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).	
	
	
	! !

!SpecialReportsTests methodsFor: 'portfolio tree printer - TDD' stamp: 'JMPO 6/13/2023 14:50:07'!
test03APortfolioOfPortfoliosPrintsWithCorrectIndentation
	
	| childPortfolio parentPortfolio account1 account2 |
	account1 := ReceptiveAccount newWithName: 'Jorge Pérez'.
	account2 := ReceptiveAccount newWithName: 'Marta Pérez'.
	childPortfolio := Portfolio withName: 'Hijos Familia Pérez' with: account2. 
	parentPortfolio := Portfolio withName: 'Familia Pérez' with: account1 with: childPortfolio.
	
	testingTreePrinter := PortfolioTreePrinter forPortfolio: parentPortfolio .	
	testingTreeString := 
	'Portfolio de Familia Pérez',
	(Character newLineCharacter asString),
	'    Cuenta de Jorge Pérez' ,
	(Character newLineCharacter asString),
	'    Portfolio de Hijos Familia Pérez',
	(Character newLineCharacter asString), 
	'        Cuenta de Marta Pérez',
	(Character newLineCharacter asString).
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).	! !

!SpecialReportsTests methodsFor: 'portfolio tree printer - TDD' stamp: 'JMPO 6/13/2023 14:50:32'!
test04ExtensionDeUnCaso
	
	"Extiende el test03 para otro portfolio, no es necesariamente TDD"
	| childPortfolio1 childPortfolio2 parentPortfolio account1 account2 account3 |
	account1 := ReceptiveAccount newWithName: 'Jorge Pérez'.
	account2 := ReceptiveAccount newWithName: 'Marta Pérez'.
	account3 := ReceptiveAccount newWithName: 'Pedro Pérez'.
	childPortfolio1 := Portfolio withName: 'Nietos Familia Pérez' with: account3. 
	childPortfolio2 := Portfolio withName: 'Hijos Familia Pérez' with: account2 with: childPortfolio1 . 
	parentPortfolio := Portfolio withName: 'Familia Pérez' with: account1 with: childPortfolio2.
	
	testingTreePrinter := PortfolioTreePrinter forPortfolio: parentPortfolio .	
	testingTreeString := 
	'Portfolio de Familia Pérez',
	(Character newLineCharacter asString),
	'    Cuenta de Jorge Pérez',
	(Character newLineCharacter asString),
	'    Portfolio de Hijos Familia Pérez',
	(Character newLineCharacter asString),
	'        Cuenta de Marta Pérez',
	(Character newLineCharacter asString),
	'        Portfolio de Nietos Familia Pérez',
	(Character newLineCharacter asString),
	'            Cuenta de Pedro Pérez',
	(Character newLineCharacter asString).
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).	! !


!SpecialReportsTests methodsFor: 'portfolio detailed tree printer - TDD' stamp: 'JMPO 6/13/2023 14:50:45'!
test01AEmptyPortfolioShowsAnEmptySpecialReport

	| portfolio |
	
	portfolio := Portfolio newWithName: 'Familia Pérez'.
	testingTreePrinter := PortfolioTreeDetailedPrinter forPortfolio: portfolio.
	
	testingTreeString := 
	'Portfolio de Familia Pérez', 
	(Character newLineCharacter asString),
	'    Balance = 0 pesos',
	(Character newLineCharacter asString).
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).! !

!SpecialReportsTests methodsFor: 'portfolio detailed tree printer - TDD' stamp: 'JMPO 6/13/2023 14:50:56'!
test02APortfolioWithoutTransactionsShowaNameOfAccounts

	| account portfolio |
	
	account := ReceptiveAccount  newWithName: 'Martin Pérez'.
	portfolio := Portfolio withName: 'Familia Pérez' with: account .
	
	testingTreePrinter := PortfolioTreeDetailedPrinter forPortfolio: portfolio.
	
	testingTreeString := 
	'Portfolio de Familia Pérez' ,
	(Character newLineCharacter asString),
	'    Cuenta de Martin Pérez',
	(Character newLineCharacter asString),
	'        Balance = 0 pesos',
	(Character newLineCharacter asString),
	'    Balance = 0 pesos',
	(Character newLineCharacter asString).
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).! !

!SpecialReportsTests methodsFor: 'portfolio detailed tree printer - TDD' stamp: 'JMPO 6/13/2023 14:51:07'!
test03APortfolioWithTranferencesShowsAccountsNamesAndTransactions

	| senderAccount receiverAccount portfolio |
	
	senderAccount := ReceptiveAccount  newWithName: 'Martin Pérez'.
	Deposit register: 200 * peso on: senderAccount .
	Withdraw register: 100 * peso on: senderAccount .
	receiverAccount := ReceptiveAccount  newWithName: 'Juan Pérez'.
	Transfer amount: 20 * peso from: senderAccount  to: receiverAccount.

	portfolio := Portfolio withName: 'Familia Pérez' with: senderAccount with: receiverAccount .
	
	testingTreePrinter := PortfolioTreeDetailedPrinter forPortfolio: portfolio.
	
	testingTreeString  :=
	'Portfolio de Familia Pérez',
	(Character newLineCharacter asString),
	'    Cuenta de Martin Pérez',
	(Character newLineCharacter asString),
	'        Depósito por 200 pesos',
	(Character newLineCharacter asString),
	'        Extracción por 100 pesos',
	(Character newLineCharacter asString),
	'        Salida por transferencia de 20 pesos',
	(Character newLineCharacter asString),
	'        Balance = 80 pesos',
	(Character newLineCharacter asString),
	'    Cuenta de Juan Pérez',
	(Character newLineCharacter asString),
	'        Entrada por transferencia de 20 pesos',
	(Character newLineCharacter asString),
	'        Balance = 20 pesos',
	(Character newLineCharacter asString), 
	'    Balance = 100 pesos',
	(Character newLineCharacter asString).
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).! !

!SpecialReportsTests methodsFor: 'portfolio detailed tree printer - TDD' stamp: 'JMPO 6/13/2023 14:51:20'!
test04APortfolioOfPortfoliosShowsAccountsNamesAndTransactions

	| account portfolioParent portfolioChild |
	
	account := ReceptiveAccount  newWithName: 'Martin Pérez'.
	Deposit register: 100 * peso on: account .
	Withdraw register: 50 * peso on: account .
	
	portfolioChild  := Portfolio withName: 'Hijos Pérez' with: account .
	portfolioParent := Portfolio withName: 'Familia Pérez' with: portfolioChild .
	testingTreePrinter := PortfolioTreeDetailedPrinter forPortfolio: portfolioParent .
	
	testingTreeString  := 
	'Portfolio de Familia Pérez' ,
	(Character newLineCharacter asString),
	'    Portfolio de Hijos Pérez',
	(Character newLineCharacter asString),
	'        Cuenta de Martin Pérez' ,
	(Character newLineCharacter asString),
	'            Depósito por 100 pesos',
	(Character newLineCharacter asString),
	'            Extracción por 50 pesos',
	(Character newLineCharacter asString),
	'            Balance = 50 pesos',
	(Character newLineCharacter asString),
	'        Balance = 50 pesos',
	(Character newLineCharacter asString), 
	'    Balance = 50 pesos',
	(Character newLineCharacter asString). 
	
	self assert: (testingTreePrinter stringTree = testingTreeString ).! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balanceOfPortfolio.
	self assert: 12 * peso equals: destinationAccount balanceOfPortfolio.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balanceOfPortfolio.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'Mc 6/12/2023 17:06:22'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balanceOfPortfolio.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'Mc 6/12/2023 17:06:22'!
balanceOfPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/12/2023 20:01:54'!
acceptSpecialReportSolicitudeFrom: aSpecialReport
	
	self subclassResponsibility .! !


!Account methodsFor: 'accessing' stamp: 'JMPO 6/11/2023 16:41:56'!
transactionsDo: aBlockClosure
	
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'JMPO 6/11/2023 20:05:15'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'noname'.! !

!Portfolio methodsFor: 'initialization' stamp: 'JMPO 6/11/2023 20:04:55'!
initializeWithName: aNameForPortfolio
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aNameForPortfolio .! !


!Portfolio methodsFor: 'main protocol' stamp: 'Mc 6/12/2023 17:06:22'!
balanceOfPortfolio
	
	^accounts sum: [ :anAccount | anAccount balanceOfPortfolio ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'accessing' stamp: 'JMPO 6/11/2023 20:51:05'!
accountsDo: aBlockClosure
	
	accounts do: [:anAccount | aBlockClosure value: anAccount ].! !

!Portfolio methodsFor: 'accessing' stamp: 'JMPO 6/11/2023 20:32:03'!
name
	
	^name.! !

!Portfolio methodsFor: 'accessing' stamp: 'JMPO 6/11/2023 15:23:03'!
transactionsDo: aBlockClosure
	
	accounts do: [:anAccount | anAccount transactionsDo: aBlockClosure ].! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/12/2023 20:01:54'!
acceptSpecialReportSolicitudeFrom: aSpecialReport
	
	^aSpecialReport addPortfolioToTree: self .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'JMPO 6/13/2023 14:46:11'!
newWithName: aNameForPortfolio
	
	^self new initializeWithName: aNameForPortfolio .! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'JMPO 6/11/2023 20:04:04'!
withName: aNameForPortfolio with: anAccount

	^self new 
		initializeWithName: aNameForPortfolio ;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'JMPO 6/11/2023 20:04:24'!
withName: aNameForPortfolio with: anAccount with: anotherAccount

	^self new 
		initializeWithName: aNameForPortfolio ;
		add: anAccount;
		add: anotherAccount ;
		yourself! !


!Portfolio class methodsFor: 'exception signals' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions username'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JMPO 6/11/2023 19:53:56'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	username := 'John Doe'.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JMPO 6/11/2023 19:54:36'!
initializeWithName: anAccountName

	super initialize.
	transactions := OrderedCollection new.
	username := anAccountName .! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'Mc 6/12/2023 17:06:22'!
balanceOfPortfolio

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'JMPO 6/11/2023 20:48:32'!
name
	
	^username .! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'JMPO 6/11/2023 15:21:30'!
transactionsDo: aBlockClosure
	
	transactions do: [:aTransaction | aBlockClosure value: aTransaction ]. ! !


!ReceptiveAccount methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/12/2023 20:01:54'!
acceptSpecialReportSolicitudeFrom: aSpecialReport

	^aSpecialReport addAccountToTree: self .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'JMPO 6/13/2023 14:48:10'!
newWithName: anAccontName
	
	^self new initializeWithName: anAccontName .! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'accountToReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'JMPO 6/11/2023 16:55:47'!
initializeWith: anAccount
	
	accountToReport := anAccount .! !


!AccountReport methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/11/2023 16:57:08'!
reportDeposit: aDeposit
	
	self subclassResponsibility .! !

!AccountReport methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/12/2023 19:47:36'!
reportTransferDepositLeg: aDepositLeg
	
	self subclassResponsibility .! !

!AccountReport methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/12/2023 19:47:44'!
reportTransferWithdrawLeg: aWithdrawLeg
	
	self subclassResponsibility .! !

!AccountReport methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/11/2023 16:57:24'!
reportWithdraw: aWithdraw
	
	self subclassResponsibility .! !


!AccountReport methodsFor: 'main protocol' stamp: 'JMPO 6/11/2023 17:18:46'!
generate
	
	self subclassResponsibility .! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'main protocol' stamp: 'JMPO 6/11/2023 20:40:32'!
generate
	
	| summary | 
	summary := OrderedCollection new initialize .
	
	accountToReport transactionsDo: ([:aTransaction | summary add: (aTransaction acceptReportSolicitudeFrom: self). ]).
			
	summary add: (self reportBalance ) .
	
	^summary .! !


!AccountSummary methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/11/2023 15:53:46'!
reportDeposit: aDeposit
	
	^('Depósito por ', (self reportTransactionValueForSummary: aDeposit) asString ).! !

!AccountSummary methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/12/2023 19:48:07'!
reportTransferDepositLeg: aDepositLeg
	
	^('Entrada por transferencia de ', (self reportTransactionValueForSummary: aDepositLeg) asString ).! !

!AccountSummary methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/12/2023 19:48:17'!
reportTransferWithdrawLeg: aWithdrawLeg
	
	^('Salida por transferencia de ', (self reportTransactionValueForSummary: aWithdrawLeg) asString ).! !

!AccountSummary methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/11/2023 15:54:11'!
reportWithdraw: aWithdraw
	
	^('Extracción por ', (self reportTransactionValueForSummary: aWithdraw) asString).! !


!AccountSummary methodsFor: 'accesing for portfolio tree' stamp: 'Mc 6/12/2023 17:10:25'!
balanceOfPortfolio

	^self reportBalance. ! !


!AccountSummary methodsFor: 'private' stamp: 'Mc 6/12/2023 17:06:22'!
reportBalance
	|partsOfTheString|
	
	(accountToReport balanceOfPortfolio = 0) ifTrue: [^'Balance = 0 pesos'].
	
	partsOfTheString := (accountToReport balanceOfPortfolio asString) substringsSeparatedBy: ($ ).
	^ ('Balance = ', (partsOfTheString at: 1) , ' ', (partsOfTheString at: 3))! !

!AccountSummary methodsFor: 'private' stamp: 'JMPO 6/11/2023 15:51:00'!
reportTransactionValueForSummary: aTransaction
	|partsOfTheString|
	
	partsOfTheString := ((aTransaction value) asString) substringsSeparatedBy: ($ ).
	^ ((partsOfTheString at: 1) , ' ', (partsOfTheString at: 3))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'JMPO 6/11/2023 15:04:00'!
ofAccount: anAccount
	
	^self new initializeWith: anAccount .! !


!classDefinition: #AccountTransferNet category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransferNet methodsFor: 'main protocol' stamp: 'JMPO 6/11/2023 20:40:32'!
generate
	
	| transferencesBalance |
	transferencesBalance := 0*peso.
	
	accountToReport transactionsDo: ([:aTransaction | transferencesBalance := transferencesBalance + (aTransaction acceptReportSolicitudeFrom: self)]).
	
	^transferencesBalance .! !


!AccountTransferNet methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/11/2023 17:33:20'!
reportDeposit: aDeposit
	
	^(0*peso).! !

!AccountTransferNet methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/12/2023 19:48:41'!
reportTransferDepositLeg: aDepositLeg
	
	^(aDepositLeg value). ! !

!AccountTransferNet methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/12/2023 19:48:51'!
reportTransferWithdrawLeg: aWithdrawLeg
	
	^(aWithdrawLeg value negated). ! !

!AccountTransferNet methodsFor: 'DD - visiting methods for AccountSummary' stamp: 'JMPO 6/11/2023 17:33:23'!
reportWithdraw: aWithdraw
	
	^(0*peso).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: 'ServiciosFinancieros-Solucion'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'JMPO 6/11/2023 16:49:56'!
ofAccount: anAccount
	
	^self new initializeWith: anAccount .! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'JMPO 6/8/2023 16:20:09'!
affectTransferNet: aTransferNet
	
	self subclassResponsibility .! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/11/2023 20:40:31'!
acceptReportSolicitudeFrom: aReport
	
	self subclassResponsibility .! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'JMPO 6/8/2023 16:20:43'!
affectTransferNet: aTransferNet

	^aTransferNet + 0.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/11/2023 20:40:32'!
acceptReportSolicitudeFrom: aReport
	
	^aReport reportDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/11/2023 20:40:32'!
acceptReportSolicitudeFrom: aReport
	
	self subclassResponsibility .! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'value' stamp: 'JMPO 6/8/2023 16:22:23'!
affectTransferNet: aTransferNet

	^(self affectBalance: aTransferNet) .! !


!TransferDepositLeg methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/11/2023 20:40:32'!
acceptReportSolicitudeFrom: aReport
	
	^aReport reportTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'value' stamp: 'JMPO 6/8/2023 16:22:23'!
affectTransferNet: aTransferNet

	^(self affectBalance: aTransferNet) .! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/11/2023 20:40:32'!
acceptReportSolicitudeFrom: aReport
	
	^aReport reportTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'JMPO 6/8/2023 16:21:10'!
affectTransferNet: aTransferNet

	^aTransferNet + 0.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'DD - visitor pattern' stamp: 'JMPO 6/11/2023 20:40:32'!
acceptReportSolicitudeFrom: aReport
	
	^aReport reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #SpecialAccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #SpecialAccountReport
	instanceVariableNames: 'assignedPortfolio currentIndentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!SpecialAccountReport methodsFor: 'initialization' stamp: 'Mc 6/12/2023 14:36:17'!
initializeWith: aPortfolio
	
	assignedPortfolio := aPortfolio .
	currentIndentation := 0.! !


!SpecialAccountReport methodsFor: 'main protocol' stamp: 'Mc 6/12/2023 17:53:45'!
stringTree
	
	|tree stringTree|
	
	tree := self generate.
	stringTree := ''.
	
	tree do:[ :anElement | stringTree := stringTree , (anElement , (Character newLineCharacter) asString )].
	
	^stringTree.! !


!SpecialAccountReport methodsFor: 'DD - visiting methods for Portfolio printing' stamp: 'Mc 6/12/2023 17:32:04'!
addAccountToTree: anAccount

	self subclassResponsibility.! !

!SpecialAccountReport methodsFor: 'DD - visiting methods for Portfolio printing' stamp: 'Mc 6/12/2023 17:32:15'!
addPortfolioToTree: anAccount

	self subclassResponsibility.! !


!SpecialAccountReport methodsFor: 'private' stamp: 'Mc 6/12/2023 14:36:36'!
currentIdentation
	
	|space|
	space := ''.
	(currentIndentation ) timesRepeat: [space := space, ' '].
	^space.  ! !

!SpecialAccountReport methodsFor: 'private' stamp: 'Mc 6/12/2023 17:31:32'!
generate

	self subclassResponsibility.! !


!classDefinition: #PortfolioTreeDetailedPrinter category: 'ServiciosFinancieros-Solucion'!
SpecialAccountReport subclass: #PortfolioTreeDetailedPrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreeDetailedPrinter methodsFor: 'private' stamp: 'JMPO 6/12/2023 23:52:30'!
generate

	| treeStructure |
	treeStructure := OrderedCollection new initialize .
	currentIndentation  := 0.
	
	treeStructure add: ('Portfolio de ', assignedPortfolio name).
	
	currentIndentation := currentIndentation + 4.

	assignedPortfolio accountsDo: [ :anAccount | treeStructure addAll: (anAccount acceptSpecialReportSolicitudeFrom: self)].
	
	treeStructure add: (self currentIdentation, 'Balance = ',((assignedPortfolio balanceOfPortfolio amount) asString), ' pesos').
	currentIndentation := currentIndentation - 4.
	
	^treeStructure.
		! !


!PortfolioTreeDetailedPrinter methodsFor: 'DD - visiting methods for Portfolio printing' stamp: 'JMPO 6/12/2023 23:52:03'!
addAccountToTree: anAccount

	|  summaryOfAccount newReport  |
	newReport := OrderedCollection new initialize. 
	summaryOfAccount  := (AccountSummary ofAccount: anAccount) generate.
		
	newReport add: (self currentIdentation , 'Cuenta de ' , anAccount name).
	currentIndentation := currentIndentation + 4.
	
	summaryOfAccount do:[ :aReportedTransaction | newReport add:(self currentIdentation,  aReportedTransaction )].
	currentIndentation := currentIndentation - 4.
	
	^newReport 
	! !

!PortfolioTreeDetailedPrinter methodsFor: 'DD - visiting methods for Portfolio printing' stamp: 'JMPO 6/12/2023 23:51:53'!
addPortfolioToTree: aPortfolio

	| childTree |
	childTree := OrderedCollection  new initialize.
	
	childTree add: (self currentIdentation , 'Portfolio de ' , aPortfolio name).
	currentIndentation := currentIndentation + 4.
	
	aPortfolio accountsDo: [ :anAccount |  childTree  addAll: (anAccount acceptSpecialReportSolicitudeFrom: self)].
	
	childTree add: (self currentIdentation, 'Balance = ', ((aPortfolio balanceOfPortfolio amount) asString), ' pesos' ). 
	currentIndentation := currentIndentation - 4.
	
	^childTree.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeDetailedPrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreeDetailedPrinter class
	instanceVariableNames: ''!

!PortfolioTreeDetailedPrinter class methodsFor: 'instance creation' stamp: 'Mc 6/12/2023 14:41:17'!
forPortfolio: aPortfolio

	^self new initializeWith: aPortfolio .! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
SpecialAccountReport subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'DD - visiting methods for Portfolio printing' stamp: 'JMPO 6/13/2023 15:01:21'!
addAccountToTree: anAccount
	
	| string |
	
	string := OrderedCollection new.
	
	currentIndentation := currentIndentation + 4.
	
	string add: ((self currentIdentation ),'Cuenta de ', (anAccount name)).
	
	currentIndentation := currentIndentation - 4.
	
	^string
	! !

!PortfolioTreePrinter methodsFor: 'DD - visiting methods for Portfolio printing' stamp: 'JMPO 6/13/2023 15:01:11'!
addPortfolioToTree: aPortfolio
	
	| childTree |
	childTree := OrderedCollection new.
	
	currentIndentation := currentIndentation + 4.
	childTree add: (self currentIdentation ,'Portfolio de ', aPortfolio name).
	
	aPortfolio accountsDo:  ([:anAccount |childTree addAll: (anAccount acceptSpecialReportSolicitudeFrom: self)]).
	
	currentIndentation := currentIndentation - 4.
	^childTree. 
	
	
	
	
	
	! !


!PortfolioTreePrinter methodsFor: 'private' stamp: 'JMPO 6/12/2023 20:01:54'!
generate
	| treeStructure |
	treeStructure := OrderedCollection new initialize .
	currentIndentation  := 0.
	
	treeStructure add: ('Portfolio de ', assignedPortfolio name).
	
	assignedPortfolio accountsDo: ([:anAccount |treeStructure addAll: (anAccount acceptSpecialReportSolicitudeFrom: self)]).
	
	^treeStructure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'Mc 6/12/2023 14:41:17'!
forPortfolio: aPortfolio

	^self new initializeWith: aPortfolio .! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
