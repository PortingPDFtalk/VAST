'From VisualWorks®, 8.3 of 28. Juli 2017 on 3. April 2022 at 10:46:58'!

"Created 3. April 2022 um 10:46:58 by VA Smalltalk Transform(1.4.0.10,chaider)"


Application create: #ValuesToolsTestingApp with:
	(#(ValuesToolsApp ValuesTestingApp)
		collect: [:className | Smalltalk at: className ifAbsent: [
			Application errorPrerequisite: #ValuesToolsTestingApp missing: className]])!

ValuesToolsTestingApp becomeDefault!

Application subclass: #ValuesToolsTestingApp
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

!ValuesToolsTestingApp publicMethods!

storeVersion
	^'3.0.0.1'!

 !TestCase
	subclass: #ValueGenerationTests
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

ValueGenerationTests comment:
'Tests for the various parts of the source code generation'!

!ValueGenerationTests publicMethods!

testAllOptionalParameterCombinations
	| parameterCollections |
	parameterCollections := ValueSpecification exampleAllOptional parameterCombinations.
	self assert: (parameterCollections collect: [:parameters |
		(parameters collect: [:p | p selector]) asArray]) asArray = #(
#(#name #default #list #properties) 
#(#name #default #list) 
#(#name #default #properties) 
#(#name #default) 
#(#name #list #properties) 
#(#name #list) 
#(#name #properties) 
#(#name) 
#(#default #list #properties) 
#(#default #list) 
#(#default #properties) 
#(#default) 
#(#list #properties) 
#(#list) 
#(#properties))!

testArraySpecification
	self assert: ArraySpecification example selector = #list.
	self assert: ArraySpecification example name = 'list'.
	self assert: ArraySpecification example comment = 'a list of things'.
	self assert: ArraySpecification example capitalizedName = 'List'.
	self assert: ArraySpecification example type printString = #(#Array) printString.
	self assert: ArraySpecification example typeName = 'Array'.
	self assert: ArraySpecification example argumentName = 'listArray'.
	self assert: (ArraySpecification example initializeExpressionFor: Testvalue) = '(listArray notNil and: [
	listArray notEmpty]) ifTrue: [
		list := (Array withAll: listArray) beImmutable]'.
	self assert: (ArraySpecification example sourceAccessorFor: Testvalue) = 'list
	"<Array>
	a list of things"

	^list ifNil: [#()]'!

testConstantSpecification
	self assert: ConstantSpecification example name = 'name'.
	self assert: ConstantSpecification example comment = 'first there were names'.
	self assert: ConstantSpecification example capitalizedName = 'Name'.
	self assert: ConstantSpecification example type printString = #(#String) printString.
	self assert: ConstantSpecification example typeName = 'String'.
	self assert: ConstantSpecification example argumentName = 'nameString'.
	self assert: (ConstantSpecification example initializeExpressionFor: Testvalue) = 'name := nameString'!

testConstantSpecificationArgumentName
	self assert: ArraySpecification example argumentName = 'listArray'.
	self assert: DictionarySpecification example argumentName = 'propertiesDictionary'.
	self assert: ConstantSpecification example argumentName = 'nameString'.
	self assert: OptionalConstantSpecification example argumentName = 'defaultString'.!

testConstantSpecificationExampleString
	self assert: (ArraySpecification example exampleStringFor: Object) = '#(1 #a $x ''name'')'.
	self assert: (DictionarySpecification example exampleStringFor: Object) = '(Valuemap with: 1 -> #symbol with: #key -> ''string'')'.
	self assert: (ConstantSpecification example exampleStringFor: Object) = '''a string'''.
	self assert: (OptionalConstantSpecification example exampleStringFor: Object) = '''a string'''!

testConstantSpecificationInitializeExpression
	self assert: (ArraySpecification example initializeExpressionFor: Testvalue) = '(listArray notNil and: [
	listArray notEmpty]) ifTrue: [
		list := (Array withAll: listArray) beImmutable]'.
	self assert: (DictionarySpecification example initializeExpressionFor: Testvalue) = '(propertiesDictionary notNil and: [
	propertiesDictionary notEmpty]) ifTrue: [
		properties := (Valuemap withAll: propertiesDictionary) beImmutable]'.
	self assert: (ConstantSpecification example initializeExpressionFor: Testvalue) = 'name := nameString'.
	self assert: (OptionalConstantSpecification example initializeExpressionFor: Testvalue) = '(defaultString notNil and: [
	self default ~= defaultString]) ifTrue: [
		default := defaultString]'!

testConstantSpecificationName
	self assert: ConstantSpecification example selector = #name.
	self assert: OptionalConstantSpecification example selector = #default.
	self assert: ArraySpecification example selector = #list.
	self assert: DictionarySpecification example selector = #properties.

	self assert: ConstantSpecification example name = 'name'.
	self assert: OptionalConstantSpecification example name = 'default'.
	self assert: ArraySpecification example name = 'list'.
	self assert: DictionarySpecification example name = 'properties'.

	self assert: ConstantSpecification example comment = 'first there were names'.
	self assert: OptionalConstantSpecification example comment = 'if nothing is said'.
	self assert: ArraySpecification example comment = 'a list of things'.
	self assert: DictionarySpecification example comment = 'The Properties'.

	self assert: ConstantSpecification example setterName = 'name:'.
	self assert: OptionalConstantSpecification example setterName = 'default:'.
	self assert: ArraySpecification example setterName = 'list:'.
	self assert: DictionarySpecification example setterName = 'properties:'.

	self assert: ConstantSpecification example capitalizedName = 'Name'.
	self assert: OptionalConstantSpecification example capitalizedName = 'Default'.
	self assert: ArraySpecification example capitalizedName = 'List'.
	self assert: DictionarySpecification example capitalizedName = 'Properties'.!

testConstantSpecificationType
	self assert: ArraySpecification example type printString = #(#Array) printString.
	self assert: DictionarySpecification example type printString = #(#Dictionary) printString.
	self assert: ConstantSpecification example type printString = #(#String) printString.
	self assert: OptionalConstantSpecification example type printString = #(#String) printString.

	self assert: ArraySpecification example typeName = 'Array'.
	self assert: DictionarySpecification example typeName = 'Dictionary'.
	self assert: ConstantSpecification example typeName = 'String'.
	self assert: OptionalConstantSpecification example typeName = 'String'!

testDictionarySpecification
	self assert: DictionarySpecification example selector = #properties.
	self assert: DictionarySpecification example name = 'properties'.
	self assert: DictionarySpecification example comment = 'The Properties'.
	self assert: DictionarySpecification example capitalizedName = 'Properties'.
	self assert: DictionarySpecification example type printString = #(#Dictionary) printString.
	self assert: DictionarySpecification example typeName = 'Dictionary'.
	self assert: DictionarySpecification example argumentName = 'propertiesDictionary'.
	self assert: (DictionarySpecification example initializeExpressionFor: Testvalue) = '(propertiesDictionary notNil and: [
	propertiesDictionary notEmpty]) ifTrue: [
		properties := (Valuemap withAll: propertiesDictionary) beImmutable]'.
	self assert: (DictionarySpecification example sourceAccessorFor: Testvalue) = 'properties
	"<Dictionary>
	The Properties"

	^properties ifNil: [Dictionary new beImmutable]'!

testFullSpecification
	self assert: Value specification = ValueSpecification new.
	self assert: (OptionalConstantSpecification specification constants collect: [:c | c selector]) = #(#selector #comment #type #default).!

testNoOptionalParameterCombinations
	| parameterCollections |
	parameterCollections := ValueSpecification exampleNoOptional parameterCombinations.
	self assert: (parameterCollections collect: [:parameters |
		(parameters collect: [:p | p selector]) asArray]) asArray = #(
#(#name #default #list #properties)
)!

testOptionalConstantSpecification
	self assert: OptionalConstantSpecification example name = 'default'.
	self assert: OptionalConstantSpecification example comment = 'if nothing is said'.
	self assert: OptionalConstantSpecification example capitalizedName = 'Default'.
	self assert: OptionalConstantSpecification example type printString = #(#String) printString.
	self assert: OptionalConstantSpecification example typeName = 'String'.
	self assert: OptionalConstantSpecification example argumentName = 'defaultString'.
	self assert: (OptionalConstantSpecification example initializeExpressionFor: Testvalue) = '(defaultString notNil and: [
	self default ~= defaultString]) ifTrue: [
		default := defaultString]'!

testOptionalParameterCombinations
	| parameterCollections |
	parameterCollections := ValueSpecification example parameterCombinations.
	self assert: (parameterCollections collect: [:parameters | (parameters collect: [:p | p selector]) asArray]) asArray = #(
#(#name #default #list #properties) 
#(#name #default #list) 
#(#name #default #properties) 
#(#name #default) 
#(#name #list #properties) 
#(#name #list) 
#(#name #properties) 
#(#name))!

testOptionalParameters
	| parameters |
	parameters := ValueSpecification example constants asSet select: [:constant | constant isOptional not].
	self assert: parameters asArray = (Array with: (ConstantSpecification selector: #name comment: 'first there were names' type: #(#String)))!

testPrintExpression
	self assert: ConstantSpecification example printExpression = 'constant: ''name'' value: self name'.
	self assert: OptionalConstantSpecification example printExpression = 'optional: ''default'' value: default'.
	self assert: ArraySpecification example printExpression = 'array: ''list'' value: self list'.
	self assert: DictionarySpecification example printExpression = 'dictionary: ''properties'' value: self properties'!

testSource
	self assert: OptionalConstantSpecification specification sourcePrintvalueWith = 'printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: ''selector'' value: self selector).
	args add: (printer optional: ''comment'' value: comment).
	args add: (printer constant: ''type'' value: self type).
	args add: (printer optional: ''default'' value: default).
	^printer printvalue: self arguments: args'!

testSource2
	self assert: ValueSpecification specification sourcePrintvalueWith = 'printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer array: ''constants'' value: self constants).
	^printer printvalue: self arguments: args'!

testSourceConstructorWithoutOptionals
	| parameters |
	parameters := ValueSpecification example constants select: [:constant | constant isOptional not].
	self assert: (ValueSpecification example sourceConstructorFor: parameters) = 
'name: nameString
	| inst |
	inst := self new.
	inst initializeName: nameString default: nil list: nil properties: nil.
	^inst'!

testSourceExample
	self assert: (ValueSpecification example sourceExampleFor: Object) = 
'example
	^Object
		name: ''a string''
		default: ''a string''
		list: #(1 #a $x ''name'')
		properties: (Valuemap with: 1 -> #symbol with: #key -> ''string'')'!

testSourceInitialize
	self assert: (ValueSpecification example sourceInitializerFor: Testvalue) = 'initializeName: nameString default: defaultString list: listArray properties: propertiesDictionary
	name := nameString.
	(defaultString notNil and: [
	self default ~= defaultString]) ifTrue: [
		default := defaultString].
	(listArray notNil and: [
	listArray notEmpty]) ifTrue: [
		list := (Array withAll: listArray) beImmutable].
	(propertiesDictionary notNil and: [
	propertiesDictionary notEmpty]) ifTrue: [
		properties := (Valuemap withAll: propertiesDictionary) beImmutable].
	self beImmutable'! !

ValueGenerationTests addSelectors: #(#testAllOptionalParameterCombinations #testArraySpecification #testConstantSpecification #testConstantSpecificationArgumentName #testConstantSpecificationExampleString #testConstantSpecificationInitializeExpression #testConstantSpecificationName #testConstantSpecificationType #testDictionarySpecification #testFullSpecification #testNoOptionalParameterCombinations #testOptionalConstantSpecification #testOptionalParameterCombinations #testOptionalParameters #testPrintExpression #testSource #testSource2 #testSourceConstructorWithoutOptionals #testSourceExample #testSourceInitialize) toCategories: #('Testing')
!

!ValuesToolsTestingApp class publicMethods!

abtIsViewApplication
	^false!

 !

ValuesToolsTestingApp class addSelectors: #(#abtIsViewApplication) toCategories: #('testing')!

!ValuePrinterTests publicMethods!

testArrayWithValue
	self assert: (Array with: ValueSpecification example) asSource = '(Array with: (ValueSpecification
	constants: (Array
		with: (ConstantSpecification selector: #name comment: ''first there were names'' type: #{String})
		with: (OptionalConstantSpecification selector: #default comment: ''if nothing is said'' type: #{String} default: ''String new'')
		with: (ArraySpecification selector: #list comment: ''a list of things'')
		with: (DictionarySpecification selector: #properties comment: ''The Properties''))))'!

testValuespecificationExample
	self assert: ValueSpecification example asSource = '(ValueSpecification
	constants: (Array
		with: (ConstantSpecification selector: #name comment: ''first there were names'' type: #{String})
		with: (OptionalConstantSpecification selector: #default comment: ''if nothing is said'' type: #{String} default: ''String new'')
		with: (ArraySpecification selector: #list comment: ''a list of things'')
		with: (DictionarySpecification selector: #properties comment: ''The Properties'')))'! !

ValuePrinterTests addSelectors: #(#testArrayWithValue #testValuespecificationExample) toCategories: #('Testing')
!

ValuesToolsTestingApp classes do: [:class |
	EtTools managerInterface versionClass: class in: ValuesToolsTestingApp withName: '3.0.0.1']!
ValuesToolsTestingApp releaseEachClassIn: ValuesToolsTestingApp classes!
EtTools managerInterface versionApplication: ValuesToolsTestingApp withName: '3.0.0.1'!
EtTools managerInterface flushCache!

ValuesToolsTestingApp initializeAfterLoad!
ValuesToolsTestingApp loaded!
