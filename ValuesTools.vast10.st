'From VisualWorks®, 8.3 of 28. Juli 2017 on 25. März 2022 at 18:01:51'!

"Created 25. März 2022 um 18:01:51 by VA Smalltalk Transform(1.4.0.9,chaider)"


Application create: #ValuesToolsApp with:
	(#(ValuesApp MedRBExtensionsApp AbtRunViewsApp AbtOrganizerApp)
		collect: [:className | Smalltalk at: className ifAbsent: [
			Application errorPrerequisite: #ValuesToolsApp missing: className]])!

ValuesToolsApp becomeDefault!

Application subclass: #ValuesToolsApp
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

!ValuesToolsApp publicMethods!

packageName
	^'Values Tools'!

storeVersion
	^'3.0.0.4'!

 !Value
	subclass: #BindingSpecification
	classInstanceVariableNames: ''
	instanceVariableNames: 'selector comment'
	classVariableNames: ''
	poolDictionaries: ''!

BindingSpecification comment:
'BindingSpecification describes one constant (slot, instvar) of a Value class.
Subclasses exist for different types.
Part of a ValueSpecification. 
Used for source generating.

Subclasses must implement the following messages:
	accessing
		type
	source generation
		pragmaMessageString
		printExpressionWithNewline:
		printSelector

Instance Variables:
	selector		<Symbol>	the instvar

'!

BindingSpecification
	subclass: #TypedConstantSpecification
	classInstanceVariableNames: ''
	instanceVariableNames: 'type'
	classVariableNames: ''
	poolDictionaries: ''!

TypedConstantSpecification comment:
'TypedConstantSpecification specifies a simple constant with a type. Subclasses define mandatory and optional versions'!

TypedConstantSpecification
	subclass: #ConstantSpecification
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

ConstantSpecification comment:
'ConstantSpecification specifies a simple mandatory constant with a type'!

Value
	subclass: #ValueSpecification
	classInstanceVariableNames: ''
	instanceVariableNames: 'constants'
	classVariableNames: ''
	poolDictionaries: ''!

ValueSpecification comment:
'ValueSpecification describes the structure of a Value class

Instance Variables:
	constants	<SequenceableCollection of: BindingSpecification>	the constants (inst vars) of the Value class'!

BindingSpecification
	subclass: #CollectionSpecification
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

CollectionSpecification comment:
'CollectionSpecification specifies a collecion constant: Array or Dictionary'!

CollectionSpecification
	subclass: #ArraySpecification
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

ArraySpecification comment:
'ArraySpecification specifies an Array constant'!

TypedConstantSpecification
	subclass: #OptionalConstantSpecification
	classInstanceVariableNames: ''
	instanceVariableNames: 'default'
	classVariableNames: ''
	poolDictionaries: ''!

OptionalConstantSpecification comment:
'OptionalConstantSpecification specifies a simple optional constant with a type and a default'!

CollectionSpecification
	subclass: #DictionarySpecification
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

DictionarySpecification comment:
'DictionarySpecification specifies a Dictionary constant'!

!ArraySpecification class publicMethods!

example
	^ArraySpecification selector: #list comment: 'a list of things'! !

ArraySpecification class addSelectors: #(#example) toCategories: #('test instances')
!

!ArraySpecification publicMethods!

default
	^'#()'!

type
	^#Array! !

ArraySpecification addSelectors: #(#default #type) toCategories: #('accessing')
!

!ArraySpecification publicMethods!

exampleStringFor: aTargetClass
	"<String>"

	^'#(1 #a $x ''name'')'!

initializeExpressionFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPut: $(;
		nextPutAll: self argumentName;
		nextPutAll: ' notNil and: [';
		cr;
		tab;
		nextPutAll: self argumentName;
		nextPutAll: ' notEmpty]) ifTrue: [';
		cr;
		tab;
		tab;
		nextPutAll: self name;
		nextPutAll: ' := (';
		nextPutAll: (Array nameRelativeTo: aTargetClass);
		nextPutAll: ' withAll: ';
		nextPutAll: self argumentName;
		nextPutAll: ') beImmutable]'.
	^wst contents!

pragmaMessageString
	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPutAll: 'arrayConstant: ';
		nextPutAll: self selector printString.
	^wst contents!

printExpression
	^'array: ', self name printString, ' value: self ', self name!

printSelector
	^#literalArraySourceFor:! !

ArraySpecification addSelectors: #(#exampleStringFor: #initializeExpressionFor: #pragmaMessageString #printExpression #printSelector) toCategories: #('source generation')
!

!BindingSpecification class publicMethods!

selector: selectorSymbol comment: commentString
	| inst |
	inst := self new.
	inst initializeSelector: selectorSymbol comment: commentString.
	^inst! !

BindingSpecification class addSelectors: #(#selector:comment:) toCategories: #('instance creation')
!

!BindingSpecification class publicMethods!

selector: selectorSymbol
	^self selector: selectorSymbol comment: nil! !

BindingSpecification class addSelectors: #(#selector:) toCategories: #('instance creation optional')
!

!BindingSpecification class publicMethods!

localSpecification
	<constant: #selector class: #(#Symbol)>
	<optional: #comment class: #(#String) default: 'String new'>! !

BindingSpecification class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!BindingSpecification publicMethods!

comment
	"<String>"

	^comment ifNil: [String new]!

default
	^self typeName, ' new beImmutable'!

defaultFor: aTargetClass
	^self default!

name
	"<String>"

	^selector asString!

passModeString
	"for OpenTalk StSt #passInstVars"

	^#default asString!

selector
	"<Symbol>	required"

	^selector!

type
	"<LiteralBindingReference>	required"
	"the class of the constant values"

	^self subclassResponsibility! !

BindingSpecification addSelectors: #(#comment #default #defaultFor: #name #passModeString #selector #type) toCategories: #('accessing')
!

!BindingSpecification publicMethods!

initializeSelector: selectorSymbol comment: commentString
	selector := selectorSymbol.
	(commentString notNil and: [
	self comment ~= commentString]) ifTrue: [
			comment := commentString].
	self beImmutable! !

BindingSpecification addSelectors: #(#initializeSelector:comment:) toCategories: #('initialize-release')
!

!BindingSpecification publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'selector' value: self selector).
	args add: (printer optional: 'comment' value: comment).
	^printer printvalue: self arguments: args! !

BindingSpecification addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!BindingSpecification publicMethods!

accessorExpressionFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 30).
	wst
		nextPutAll: self name;
		nextPutAll: ' ifNil: [';
		nextPutAll: (self defaultFor: aTargetClass);
		nextPut: $].
	^wst contents!

accessorFor: aTargetClass
	| sourceAccessor |
	sourceAccessor := self sourceAccessorFor: aTargetClass.
	(aTargetClass needs: sourceAccessor) ifFalse: [
		^nil].
	^AddMethodChange compile: sourceAccessor in: aTargetClass classified: #accessing!

argumentName
	"<String>"

	^self name , self typeName!

argumentOrNilStringWhen: useArgument
	"<String>"

	useArgument ifFalse: [^nil printString].
	^self argumentName!

capitalizedName
	"<String>"

	^self name copyReplaceFrom: 1 to: 1 with: (String with: self name first asUppercase)!

exampleParameterStringFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 30).
	wst
		nextPutAll: self setterName;
		space;
		nextPutAll: (self exampleStringFor: aTargetClass).
	^wst contents!

exampleStringFor: aTargetClass
	"<String>"

	^self type value literalExample asSourceFor: aTargetClass!

initializeExpressionFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPutAll: self name;
		nextPutAll: ' := ';
		nextPutAll: self argumentName.
	^wst contents!

parameterString
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 30).
	wst
		nextPutAll: self setterName;
		space;
		nextPutAll: self argumentName.
	^wst contents!

pragmaMessageString
	"<String>"

	self subclassResponsibility!

pragmaString
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 30).
	wst
		nextPut: $<;
		nextPutAll: self pragmaMessageString;
		nextPut: $>.
	^wst contents!

printExpression
	"<String>"

	self subclassResponsibility!

printSelector
	"<Symbol>"
	"the first part of the selector used by the print method to print its contents"

	self subclassResponsibility!

setterName
	"<String>"

	^self name copyWith: $:!

sourceAccessorFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPutAll: self name;
		crtab;
		nextPutAll: '"<';
		nextPutAll: self typeName;
		nextPut: $>.
	self comment notEmpty ifTrue: [
		wst
			crtab;
			nextPutAll: self comment].
	wst
		nextPut: $";
		cr;
		crtab;
		nextPut: $^;
		nextPutAll: (self accessorExpressionFor: aTargetClass).
	^wst contents!

typeName
	"<String>"

	^self type name asString! !

BindingSpecification addSelectors: #(#accessorExpressionFor: #accessorFor: #argumentName #argumentOrNilStringWhen: #capitalizedName #exampleParameterStringFor: #exampleStringFor: #initializeExpressionFor: #parameterString #pragmaMessageString #pragmaString #printExpression #printSelector #setterName #sourceAccessorFor: #typeName) toCategories: #('source generation')
!

!BindingSpecification publicMethods!

isOptional
	"<Boolean>"

	^false! !

BindingSpecification addSelectors: #(#isOptional) toCategories: #('testing')
!

!CollectionSpecification publicMethods!

isOptional
	"empty collection is the default"

	^true! !

CollectionSpecification addSelectors: #(#isOptional) toCategories: #('testing')
!

!ConstantSpecification class publicMethods!

example
	^ConstantSpecification selector: #name comment: 'first there were names' type: #String! !

ConstantSpecification class addSelectors: #(#example) toCategories: #('test instances')
!

!ConstantSpecification publicMethods!

accessorExpressionFor: aTargetClass
	"<String>"

	^self name!

pragmaMessageString
	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPutAll: 'constant: ';
		nextPutAll: self selector printString;
		nextPutAll: ' type: ';
		nextPutAll: self type printString.
	^wst contents!

printExpression
	^'constant: ', self name printString, ' value: self ', self name! !

ConstantSpecification addSelectors: #(#accessorExpressionFor: #pragmaMessageString #printExpression) toCategories: #('source generation')
!

!DictionarySpecification class publicMethods!

example
	^DictionarySpecification selector: #properties comment: 'The Properties'! !

DictionarySpecification class addSelectors: #(#example) toCategories: #('test instances')
!

!DictionarySpecification publicMethods!

default
	^self defaultFor: Object!

defaultFor: aTargetClass
	^(Dictionary nameRelativeTo: aTargetClass) , ' new beImmutable'!

passModeString
	^#value asString!

type
	^#Dictionary! !

DictionarySpecification addSelectors: #(#default #defaultFor: #passModeString #type) toCategories: #('accessing')
!

!DictionarySpecification publicMethods!

exampleStringFor: aTargetClass
	"<String>"

	^'(' , (Valuemap nameRelativeTo: aTargetClass) , ' with: 1 -> #symbol with: #key -> ''string'')'!

initializeExpressionFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPut: $(;
		nextPutAll: self argumentName;
		nextPutAll: ' notNil and: [';
		cr;
		tab;
		nextPutAll: self argumentName;
		nextPutAll: ' notEmpty]) ifTrue: [';
		cr;
		tab;
		tab;
		nextPutAll: self name;
		nextPutAll: ' := (';
		nextPutAll: (Valuemap nameRelativeTo: aTargetClass);
		nextPutAll: ' withAll: ';
		nextPutAll: self argumentName;
		nextPutAll: ') beImmutable]'.
	^wst contents!

pragmaMessageString
	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPutAll: 'dictionaryConstant: ';
		nextPutAll: self selector printString.
	^wst contents!

printExpression
	^'dictionary: ', self name printString, ' value: self ', self name!

printSelector
	^#literalDictionarySourceFor:! !

DictionarySpecification addSelectors: #(#exampleStringFor: #initializeExpressionFor: #pragmaMessageString #printExpression #printSelector) toCategories: #('source generation')
!

!OptionalConstantSpecification class publicMethods!

selector: selectorSymbol comment: commentString type: typeLiteralBindingReference default: defaultString
	| inst |
	inst := self new.
	inst
		initializeSelector: selectorSymbol
		comment: commentString
		type: typeLiteralBindingReference
		default: defaultString.
	^inst! !

OptionalConstantSpecification class addSelectors: #(#selector:comment:type:default:) toCategories: #('instance creation')
!

!OptionalConstantSpecification class publicMethods!

selector: selectorSymbol comment: commentString type: typeLiteralBindingReference
	^self
		selector: selectorSymbol
		comment: commentString
		type: typeLiteralBindingReference
		default: nil!

selector: selectorSymbol type: typeLiteralBindingReference
	^self selector: selectorSymbol comment: nil type: typeLiteralBindingReference default: nil!

selector: selectorSymbol type: typeLiteralBindingReference default: defaultString
	^self
		selector: selectorSymbol
		comment: nil
		type: typeLiteralBindingReference
		default: defaultString! !

OptionalConstantSpecification class addSelectors: #(#selector:comment:type: #selector:type: #selector:type:default:) toCategories: #('instance creation optional')
!

!OptionalConstantSpecification class publicMethods!

localSpecification
	<optional: #default class: #(#String) default: 'super default'>! !

OptionalConstantSpecification class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!OptionalConstantSpecification class publicMethods!

example
	^OptionalConstantSpecification
		selector: #default
		comment: 'if nothing is said'
		type: #String
		default: 'String new'! !

OptionalConstantSpecification class addSelectors: #(#example) toCategories: #('test instances')
!

!OptionalConstantSpecification publicMethods!

default
	^default ifNil: [super default]! !

OptionalConstantSpecification addSelectors: #(#default) toCategories: #('accessing')
!

!OptionalConstantSpecification publicMethods!

initializeSelector: selectorSymbol comment: commentString type: typeLiteralBindingReference default: defaultString
	selector := selectorSymbol.
	(commentString notNil and: [
	self comment ~= commentString]) ifTrue: [
			comment := commentString].
	type := typeLiteralBindingReference.
	(defaultString notNil and: [
	self default ~= defaultString]) ifTrue: [
			default := defaultString].
	self beImmutable! !

OptionalConstantSpecification addSelectors: #(#initializeSelector:comment:type:default:) toCategories: #('initialize-release')
!

!OptionalConstantSpecification publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'selector' value: self selector).
	args add: (printer optional: 'comment' value: comment).
	args add: (printer constant: 'type' value: self type).
	args add: (printer optional: 'default' value: default).
	^printer printvalue: self arguments: args! !

OptionalConstantSpecification addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!OptionalConstantSpecification publicMethods!

initializeExpressionFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPut: $(;
		nextPutAll: self argumentName;
		nextPutAll: ' notNil and: [';
		cr;
		tab;
		nextPutAll: 'self ';
		nextPutAll: self name;
		nextPutAll: ' ~= ';
		nextPutAll: self argumentName;
		nextPutAll: ']) ifTrue: [';
		cr;
		tab;
		tab;
		nextPutAll: self name;
		nextPutAll: ' := ';
		nextPutAll: self argumentName;
		nextPut: $].
	^wst contents!

pragmaMessageString
	| wst |
	wst := WriteStream on: (String new: 40).
	wst
		nextPutAll: 'constant: ';
		nextPutAll: self selector printString;
		nextPutAll: ' type: ';
		nextPutAll: self type printString;
		nextPutAll: ' default: ';
		nextPutAll: (default ifNil: ['nil'] ifNotNil: [self default printString]).
	^wst contents!

printExpression
	^'optional: ', self name printString, ' value: ', self name! !

OptionalConstantSpecification addSelectors: #(#initializeExpressionFor: #pragmaMessageString #printExpression) toCategories: #('source generation')
!

!OptionalConstantSpecification publicMethods!

isOptional
	^true! !

OptionalConstantSpecification addSelectors: #(#isOptional) toCategories: #('testing')
!

!TypedConstantSpecification class publicMethods!

selector: selectorSymbol
	"type is required!!
	#selector:type: must be used to create a non empty instance"

	^self shouldNotImplement!

selector: selectorSymbol comment: commentString type: typeLiteralBindingReference
	| inst |
	inst := self new.
	inst
		initializeSelector: selectorSymbol
		comment: commentString
		type: typeLiteralBindingReference.
	^inst! !

TypedConstantSpecification class addSelectors: #(#selector: #selector:comment:type:) toCategories: #('instance creation')
!

!TypedConstantSpecification class publicMethods!

selector: selectorSymbol type: typeLiteralBindingReference
	^self selector: selectorSymbol comment: nil type: typeLiteralBindingReference! !

TypedConstantSpecification class addSelectors: #(#selector:type:) toCategories: #('instance creation optional')
!

!TypedConstantSpecification class publicMethods!

localSpecification
	<constant: #type class: #(#LiteralBindingReference)>! !

TypedConstantSpecification class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!TypedConstantSpecification publicMethods!

type
	"<LiteralBindingReference>	required"
	"the class of the constant values"

	^type! !

TypedConstantSpecification addSelectors: #(#type) toCategories: #('accessing')
!

!TypedConstantSpecification publicMethods!

initializeSelector: selectorSymbol comment: commentString type: typeLiteralBindingReference
	selector := selectorSymbol.
	(commentString notNil and: [
	self comment ~= commentString]) ifTrue: [
			comment := commentString].
	type := typeLiteralBindingReference.
	self beImmutable!

initializeSelector: selectorSymbol type: typeLiteralBindingReference
	selector := selectorSymbol.
	type := typeLiteralBindingReference.
	self beImmutable! !

TypedConstantSpecification addSelectors: #(#initializeSelector:comment:type: #initializeSelector:type:) toCategories: #('initialize-release')
!

!TypedConstantSpecification publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'selector' value: self selector).
	args add: (printer optional: 'comment' value: comment).
	args add: (printer constant: 'type' value: self type).
	^printer printvalue: self arguments: args! !

TypedConstantSpecification addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!TypedConstantSpecification publicMethods!

printSelector
	^#writeValue:! !

TypedConstantSpecification addSelectors: #(#printSelector) toCategories: #('source generation')
!

!ValueSpecification class publicMethods!

printSelector
	^#printvalueWith:! !

ValueSpecification class addSelectors: #(#printSelector) toCategories: #('accessing')
!

!ValueSpecification class publicMethods!

constants: constantsArray
	| inst |
	inst := self new.
	inst initializeConstants: constantsArray.
	^inst! !

ValueSpecification class addSelectors: #(#constants:) toCategories: #('instance creation')
!

!ValueSpecification class publicMethods!

localSpecification
	<sequence: #constants>! !

ValueSpecification class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!ValueSpecification class publicMethods!

example
	^ValueSpecification constants: (Array
		with: (ConstantSpecification
			selector: #name
			comment: 'first there were names'
			type: #String)
		with: (OptionalConstantSpecification
			selector: #default
			comment: 'if nothing is said'
			type: #String
			default: 'String new')
		with: (ArraySpecification selector: #list comment: 'a list of things')
		with: (DictionarySpecification selector: #properties comment: 'The Properties'))!

exampleAllOptional
	^ValueSpecification constants: (Array
		with: (OptionalConstantSpecification
			selector: #name
			comment: 'first there were names'
			type: #String
			default: 'String new')
		with: (OptionalConstantSpecification
			selector: #default
			comment: 'if nothing is said'
			type: #String
			default: 'String new')
		with: (ArraySpecification selector: #list comment: 'a list of things')
		with: (DictionarySpecification selector: #properties comment: 'The Properties'))!

exampleNoOptional
	^ValueSpecification constants: (Array
		with: (ConstantSpecification selector: #name type: #String)
		with: (ConstantSpecification selector: #default type: #String)
		with: (ConstantSpecification selector: #list type: #Array)
		with: (ConstantSpecification selector: #properties type: #Valuemap))! !

ValueSpecification class addSelectors: #(#example #exampleAllOptional #exampleNoOptional) toCategories: #('test instances')
!

!ValueSpecification publicMethods!

constants
	^constants ifNil: [#()]! !

ValueSpecification addSelectors: #(#constants) toCategories: #('accessing')
!

!ValueSpecification publicMethods!

initializeConstants: constantsArray
	(constantsArray notNil and: [
	constantsArray notEmpty]) ifTrue: [
		constants := (Array withAll: constantsArray) beImmutable].
	self beImmutable! !

ValueSpecification addSelectors: #(#initializeConstants:) toCategories: #('initialize-release')
!

!ValueSpecification publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer array: 'constants' value: self constants).
	^printer printvalue: self arguments: args! !

ValueSpecification addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!ValueSpecification publicMethods!

addMethodsFor: aTargetClass to: compositeChange
	aTargetClass hasSpecification ifTrue: [
		| parameterCombinations |
		(self changesForInstvarsOf: aTargetClass) do: [:change |
			self addChange: change to: compositeChange].
		parameterCombinations := self parameterCombinations.
		self
			addChange: (self
				addMethod: (self sourceConstructorFor: parameterCombinations first)
				for: aTargetClass class
				in: #'instance creation')
			to: compositeChange.
		(parameterCombinations copyFrom: 2 to: parameterCombinations size) do: [:parameters |
			self
				addChange: (self
					addMethod: (self sourceOptionalConstructorFor: parameters)
					for: aTargetClass class
					in: #'instance creation optional')
				to: compositeChange].
		self addChange: (self initializerFor: aTargetClass) to: compositeChange.
		self constants do: [:constantSpec |
			self addChange: (constantSpec accessorFor: aTargetClass) to: compositeChange]].
	aTargetClass == Value ifTrue: [
		^self].
	aTargetClass hasSpecification ifTrue: [
		self addChange: (self passInstVarsFor: aTargetClass) to: compositeChange.
		self addChange: (self sourcePrintvalueWithFor: aTargetClass) to: compositeChange].
	aTargetClass isLeafClass ifTrue: [
		"should go into the test resources package"
		
self addChange: (self exampleFor: aTargetClass) to: compositeChange]!

changesForInstvarsOf: aTargetClass
	"<Collection of: Change>"

	| changes |
	changes := OrderedCollection new.
	changes addAll: (self changesForObsoleteInstVarsOf: aTargetClass).
	changes addAll: (self classChangeForChangingInstVarsOf: aTargetClass).
	^changes!

changesForObsoleteInstVarsOf: aTargetClass
	| changes constantNames obsoleteInstvars methodsReferencingOldInstVars obsoleteConstructors |
	changes := OrderedCollection new.
	constantNames := self constants collect: [:const | const name].
	obsoleteInstvars := aTargetClass instVarNames reject: [:varName |
		constantNames includes: varName].
	obsoleteInstvars isEmpty ifTrue: [
		^changes].
	methodsReferencingOldInstVars := obsoleteInstvars inject: Set new into: [:set :varName |
		set addAll: (aTargetClass whichSelectorsAccess: varName).
		set].
	(methodsReferencingOldInstVars detect: [:selector | 'initialize*' match: selector asString] ifNone: [nil]) ifNotNil: [:initializer |
		obsoleteConstructors := aTargetClass class whichSelectorsReferTo: initializer.
		obsoleteConstructors do: [:constructor |
			changes add: (RemoveMethodChange remove: constructor from: aTargetClass class)]].
	methodsReferencingOldInstVars do: [:selector |
		changes add: (RemoveMethodChange remove: selector from: aTargetClass)].
	^changes!

classChangeForChangingInstVarsOf: aTargetClass
	"<SequenceableCollection of: AddClassChange>"

	| localConstants newInstvarString oldInstvarString change newDefinition |
	localConstants := self constants reject: [:const |
		aTargetClass superclass allInstVarNames includes: const name].
	newInstvarString := localConstants inject: String new into: [:string :const | string , const name , ' '].
	oldInstvarString := aTargetClass instanceVariableString.
	newInstvarString = oldInstvarString ifTrue: [
		^#()].
	newDefinition := aTargetClass definitionString
		copyReplaceAll: 'instanceVariableNames: ' , oldInstvarString printString
		with: 'instanceVariableNames: ' , newInstvarString printString.
	change := AddClassChange definition: newDefinition application: System defaultApplication.
	^Array with: change! !

ValueSpecification addSelectors: #(#addMethodsFor:to: #changesForInstvarsOf: #changesForObsoleteInstVarsOf: #classChangeForChangingInstVarsOf:) toCategories: #('source generation')
!

!ValueSpecification publicMethods!

addChange: aRefactoryChangeOrNil to: compositeChange
	aRefactoryChangeOrNil ifNotNil: [compositeChange addChange: aRefactoryChangeOrNil]!

combinationsOf: elements
	"<SequenceableCollection of: (SequenceableCollection of: BindingSpecification)>"
	"sorted, so that all parameters are first and no optional parameters are last"

	| head tail tailcombinations withHead |
	elements isEmpty ifTrue: [
		^#(#())].
	head := elements first.
	tail := elements copyFrom: 2 to: elements size.
	tailcombinations := self combinationsOf: tail.
	withHead := tailcombinations collect: [:combo | (Array with: head) , combo].
	^withHead , tailcombinations!

exampleFor: aTargetClass
	"<AddMethodChange | nil>"

	| source |
	aTargetClass isLeafClass ifFalse: [
		^nil].
	source := (aTargetClass class includesSelector: #example)
		ifTrue: [
			[	| example |
				example := aTargetClass perform: #example.
				example asMethodSourceNamed: 'example'
			] on: Error do: [:ex |
				self sourceExampleFor: aTargetClass]]
		ifFalse: [self sourceExampleFor: aTargetClass].
	^self addMethod: source for: aTargetClass class in: #'test instances'!

initializerFor: aTargetClass
	"<AddMethodChange | nil>"

	self constants isEmpty ifTrue: [
		^nil].
	^self
		addMethod: (self sourceInitializerFor: aTargetClass)
		for: aTargetClass
		in: #'initialize-release'!

needsPassInstVars
	"<Boolean>"

	^self constants anySatisfy: [:constant | constant passModeString = #value asString]!

parameterCombinations
	"<SequenceableCollection of: (SequenceableCollection of: BindingSpecification)>"
	"sorted, so that all parameters are first and no optional parameters are last"
	"each combinations contains the right conatants in the original order"

	| required optional |
	required := self constants reject: [:c | c isOptional].
	optional := self constants select: [:c | c isOptional].
	^((self combinationsOf: optional) collect: [:optionals |
		| selection |
		selection := (required , optionals) asSet.
		self constants select: [:c | selection includes: c]]) reject: [:p |
			p isEmpty]!

passInstVarsFor: aTargetClass
	"<AddMethodChange | nil>"

	self needsPassInstVars ifFalse: [
		^nil].
	[self sourcePassInstVarsOf: aTargetClass] on: ExCLDTKeyNotFound do: [:ex |
		^nil].
	^self addMethod: (self sourcePassInstVarsOf: aTargetClass) for: aTargetClass in: #marshaling!

printSelector
	^self class printSelector!

sourceConstructorFor: usedConstants
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 60).
	usedConstants do: [:constant | wst nextPutAll: constant parameterString] separatedBy: [
		wst space].
	wst
		crtab;
		nextPutAll: '| inst |';
		crtab;
		nextPutAll: 'inst := self new.';
		crtab;
		nextPutAll: 'inst initialize';
		nextPutAll: self constants first capitalizedName;
		nextPut: $:;
		space;
		nextPutAll: (self constants first argumentOrNilStringWhen: (usedConstants includes: self constants first)).
	(self constants copyFrom: 2 to: self constants size) do: [:constant |
		wst
			space;
			nextPutAll: constant setterName;
			space;
			nextPutAll: (constant argumentOrNilStringWhen: (usedConstants includes: constant))].
	wst
		nextPut: $.;
		crtab;
		nextPutAll: '^inst'.
	^wst contents!

sourceExampleFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 60).
	wst
		nextPutAll: 'example';
		crtab;
		nextPut: $^;
		nextPutAll: aTargetClass name.
	self constants isEmpty
		ifTrue: [wst nextPutAll: ' new']
		ifFalse: [
		self constants do: [:constant |
			wst
				crtab;
				tab;
				nextPutAll: (constant exampleParameterStringFor: aTargetClass)]].
	^wst contents!

sourceInitializeCallString
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 60).
	wst
		nextPutAll: 'initialize';
		nextPutAll: self constants first capitalizedName;
		nextPut: $:;
		space;
		nextPutAll: self constants first argumentName.
	(self constants copyFrom: 2 to: self constants size) do: [:constant |
		wst
			space;
			nextPutAll: constant parameterString].
	^wst contents!

sourceInitializerFor: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 60).
	wst nextPutAll: self sourceInitializeCallString.
	self constants do: [:constant |
		wst
			crtab;
			nextPutAll: (constant initializeExpressionFor: aTargetClass);
			nextPut: $.].
	wst
		crtab;
		nextPutAll: 'self beImmutable'.
	^wst contents!

sourceOptionalConstructorFor: usedConstants
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 60).
	usedConstants do: [:constant | wst nextPutAll: constant parameterString] separatedBy: [
		wst space].
	wst
		crtab;
		nextPutAll: '^self'.
	self constants do: [:constant |
		wst
			space;
			nextPutAll: constant setterName;
			space;
			nextPutAll: (constant argumentOrNilStringWhen: (usedConstants includes: constant))].
	^wst contents!

sourcePassInstVarsOf: aTargetClass
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 60).
	wst
		nextPutAll: #passInstVars asString;
		crtab;
		nextPut: $";
		nextPutAll: 'for OpenTalk StSt';
		nextPut: $";
		cr;
		crtab;
		nextPutAll: '^#('.
	aTargetClass allInstVarNames do: [:ivar |
		| selector constant |
		selector := ivar asSymbol.
		constant := self constants detect: [:c | c selector = selector].
		wst nextPutAll: constant passModeString] separatedBy: [
		wst space].
	wst nextPut: $).
	^wst contents!

sourcePrintvalueWith
	"<String>"

	| wst |
	wst := WriteStream on: (String new: 100).
	wst
		nextPutAll: #printvalueWith: asString;
		nextPutAll: ' printer';
		crtab;
		nextPutAll: '| args |';
		crtab;
		nextPutAll: 'args := OrderedCollection new.'.
	self constants do: [:constant |
		wst
			crtab;
			nextPutAll: 'args add: (printer ';
			nextPutAll: constant printExpression;
			nextPutAll: ').'].
	wst
		crtab;
		nextPutAll: '^printer printvalue: self arguments: args'.
	^wst contents!

sourcePrintvalueWithFor: aTargetClass
	"<AddMethodChange | nil>"

	^self addMethod: self sourcePrintvalueWith for: aTargetClass in: #printing! !

ValueSpecification addSelectors: #(#addChange:to: #combinationsOf: #exampleFor: #initializerFor: #needsPassInstVars #parameterCombinations #passInstVarsFor: #printSelector #sourceConstructorFor: #sourceExampleFor: #sourceInitializeCallString #sourceInitializerFor: #sourceOptionalConstructorFor: #sourcePassInstVarsOf: #sourcePrintvalueWith #sourcePrintvalueWithFor:) toCategories: #('source generation private')
!

!ValuesToolsApp class publicMethods!

addValuesToolsMenuItemsToOrganizer
	"Add Values Tools menu items to the organizer menus."

	| organizerView classesContainer menuBar menuBarClasses popupClassesMenu |
	organizerView := AbtApplicationsOrganizerView current.
	popupClassesMenu := organizerView subpartNamed: 'ClassesPopup'.
	(popupClassesMenu subpartNamed: 'GenerateMethodsForValue' ifAbsent: []) ifNotNil: [
		popupClassesMenu removeSubpartNamed: 'ValuesToolsSeparator' ifAbsent: [].
		popupClassesMenu removeSubpartNamed: 'GenerateMethodsForValue' ifAbsent: []].
	#('ClassesPopup' 'ClassesPulldown') do: [:menuType |
		| classesMenu menuItem menuComponents itemName |
		classesMenu := organizerView subpartNamed: menuType.
		menuComponents := classesMenu components.
		itemName := 'ValuesToolsSeparator'.
		menuItem := AbtSeparatorView new.
		menuItem
			name: itemName;
			parentView: classesMenu.
		menuComponents at: itemName put: menuItem afterValue: menuComponents last.
		itemName := 'GenerateMethodsForValue'.
		menuItem := AbtPushButtonView new.
		menuItem
			name: itemName;
			parentView: classesMenu;
			object: 'add Value methods...';
			abtWhen: #clicked
				perform: ((DirectedMessage new)
					receiver: Value;
					selector: #generateMethods;
					yourself).
		menuComponents at: itemName put: menuItem afterValue: menuComponents last.

		"Recreate menu."
		menuComponents do: [:item |
			(item primaryWidget == nil or: [
			item primaryWidget isDestroyed]) ifFalse: [
					item primaryWidget destroyWidget]].
		menuComponents do: [:item | item createWidget].
		menuComponents do: [:item | item setPostCreationSettings]].
	classesContainer := organizerView classesContainer.
	classesContainer
		abtWhen: #popUpMenuRequest
		perform: ((DirectedMessage new)
			receiver: self;
			selector: #enableValuesToolsMenu:;
			arguments: (Array with: #popup asAtom);
			yourself).
	classesContainer
		abtWhen: #itemPopUpMenuRequest
		perform: ((DirectedMessage new)
			receiver: self;
			selector: #enableValuesToolsMenu:;
			arguments: (Array with: #popup asAtom);
			yourself).
	menuBar := organizerView subpartNamed: 'MenuBar'.
	menuBarClasses := menuBar subpartNamed: 'MenuBarClasses'.
	menuBarClasses
		abtWhen: #menuCascaded
		perform: ((DirectedMessage new)
			receiver: self;
			selector: #enableValuesToolsMenu:;
			arguments: (Array with: #pulldown asAtom);
			yourself)!

enableValuesToolsMenu: aMenuType
	"Enable/disable the classes menu items as appropriate."

	| organizerView applicationsMenu enableAction |
	organizerView := AbtApplicationsOrganizerView current.
	applicationsMenu := organizerView subpartNamed: 'Classes' , (organizerView menuNameSuffix: aMenuType) ifAbsent: [
		^nil].
	enableAction := (organizerView isOneClassSelected and: [
	(organizerView selectedClass includesBehavior: Value) or: [
	organizerView selectedClass includesBehavior: Value class]])
			ifTrue: [
			#enable]
			ifFalse: [
			#disable].
	organizerView
		subpartNamed: 'GenerateMethodsForValue'
		inPart: applicationsMenu
		perform: enableAction!

initializeAfterLoad
	(Smalltalk at: #Value) resetNamedValuesRegistry.
	self addValuesToolsMenuItemsToOrganizer!

startUp
	"When the system starts add menu item."

	CwAppContext default asyncExecInUI: [self addValuesToolsMenuItemsToOrganizer]!

removing
	| popupClassesMenu |
	popupClassesMenu := AbtApplicationsOrganizerView current subpartNamed: 'ClassesPopup'.
	(popupClassesMenu subpartNamed: 'GenerateMethodsForValue' ifAbsent: []) ifNotNil: [
		popupClassesMenu removeSubpartNamed: 'ValuesToolsSeparator' ifAbsent: [].
		popupClassesMenu removeSubpartNamed: 'GenerateMethodsForValue' ifAbsent: []]!

 !

ValuesToolsApp class addSelectors: #(#addValuesToolsMenuItemsToOrganizer #enableValuesToolsMenu: #initializeAfterLoad #startUp #removing) toCategories: #('startup')!

!ValuesToolsApp class publicMethods!

abtIsViewApplication
	^false!

 !

ValuesToolsApp class addSelectors: #(#abtIsViewApplication) toCategories: #('testing')!

!CgIcon publicMethods!

icon
	^self!

 !

CgIcon addSelectors: #(#icon) toCategories: #('accessing')!

!WriteStream publicMethods!

crtab
	self
		cr;
		tab!

 !

WriteStream addSelectors: #(#crtab) toCategories: #('printing')!

!Number publicMethods!

nanoseconds
	^Duration fromNanoseconds: self!

 !

Number addSelectors: #(#nanoseconds) toCategories: #('durations')!

!ArrayPrintvalue class publicMethods!

example
	^ArrayPrintvalue arguments: (Array
		with: (Printargument name: 'selector' value: '#value')
		with: (Printargument name: 'type' value: '#{Number}'))! !

ArrayPrintvalue class addSelectors: #(#example) toCategories: #('test instances')
!

!Behavior publicMethods!

needs: source
	"<Boolean>"

	| selector parseTree classAndMethod |
	parseTree := RBParser parseMethod: source.
	selector := parseTree selector.
	(self canUnderstand: selector) ifFalse: [
		^true].
	classAndMethod := self findSelector: selector.
	^(classAndMethod first parseTreeFor: selector) ~= parseTree! !

Behavior addSelectors: #(#needs:) toCategories: #('source generation')
!

!Boolean class publicMethods!

literalExample
	^true! !

Boolean class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!ByteArray class publicMethods!

literalExample
	^#[42]! !

ByteArray class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Character class publicMethods!

literalExample
	^$a! !

Character class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Collection publicMethods!

betterTestInstanceThan: aCollection
	"<Boolean>
	true, iff the receiver is better as a test instance than aValue"

	^self size >= aCollection size! !

Collection addSelectors: #(#betterTestInstanceThan:) toCategories: #('comparing')
!

!ColorValue class publicMethods!

literalExample
	^ColorValue red! !

ColorValue class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Date class publicMethods!

literalExample
	^Date d: 19 m: 5 y: 2006! !

Date class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!DictionaryPrintargument class publicMethods!

example
	^DictionaryPrintargument name: Printvalue new value: Printvalue new! !

DictionaryPrintargument class addSelectors: #(#example) toCategories: #('test instances')
!

!DictionaryPrintvalue class publicMethods!

example
	^DictionaryPrintvalue arguments: (Array
		with: (DictionaryPrintargument
			name: (LiteralPrintvalue string: '123')
			value: (LiteralPrintvalue string: '#value'))
		with: (DictionaryPrintargument
			name: (LiteralPrintvalue string: '#other')
			value: (LiteralPrintvalue string: '#{Number}')))! !

DictionaryPrintvalue class addSelectors: #(#example) toCategories: #('test instances')
!

!Duration class publicMethods!

literalExample
	^42 nanoseconds!

fromNanoseconds: aNumber
	| microseconds seconds |
	microseconds := aNumber / 1000.
	seconds := microseconds / 1000000.
	^self totalSeconds: seconds microseconds: microseconds - (seconds * 1000000)! !

Duration class addSelectors: #(#literalExample #fromNanoseconds:) toCategories: #('instance creation')
!

!LiteralPrintvalue class publicMethods!

example
	^LiteralPrintvalue string: '(Date d: 8 m: 7 y: 2007)'! !

LiteralPrintvalue class addSelectors: #(#example) toCategories: #('test instances')
!

!Object class publicMethods!

literalExample
	^self error: 'this is no literal object'! !

Object class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Object publicMethods!

asLiteralSource
	"use #asSource"

	self halt! !

Object addSelectors: #(#asLiteralSource) toCategories: #('printing')
!

!Printargument class publicMethods!

example
	^Printargument
		name: 'constant'
		value: (ValuePrintvalue
			classname: 'ConstantSpecification'
			arguments: (Array
				with: (Printargument name: 'selector' value: '#value')
				with: (Printargument name: 'type' value: '#{Number}')))! !

Printargument class addSelectors: #(#example) toCategories: #('test instances')
!

!Rectangle class publicMethods!

literalExample
	^1@2 extent: 20@10! !

Rectangle class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!String class publicMethods!

literalExample
	^'a string'! !

String class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Symbol class publicMethods!

literalExample
	^#symbol! !

Symbol class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Time class publicMethods!

literalExample
	^Time h: 11 m: 8 s: 28! !

Time class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!Timestamp class publicMethods!

literalExample
	^Timestamp d: 19 m: 5 y: 2006 h: 11 m: 7 s: 55! !

Timestamp class addSelectors: #(#literalExample) toCategories: #('instance creation')
!

!UndefinedObject publicMethods!

literalExample
	^nil! !

UndefinedObject addSelectors: #(#literalExample) toCategories: #('printing')
!

!Value class publicMethods!

toolListIcon
	"An Icon for the tools list."

	| palette maskData shapeData paletteEntries |
	maskData := #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 96 0 0 3 96 0 0 15 248 0 0 15 248 0 0 3 96 0 0 15 248 0 0 15 248 0 0 3 96 0 0 3 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0].
	shapeData := #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 36 0 0 10 24 0 0 170 101 64 0 169 149 64 0 6 20 0 0 153 85 64 0 101 85 64 0 5 20 0 0 5 20 0 0 0 0 0 0 0 0 0 0 0 0 0].
	paletteEntries := Array
		with: (CgPaletteEntry color: (Color red: 8191 green: 8191 blue: 8191) animating: false)
		with: (CgPaletteEntry color: (Color red: 2120 green: 2120 blue: 2120) animating: false)
		with: (CgPaletteEntry color: (Color red: 3180 green: 3180 blue: 3180) animating: false).
	palette := CgIndexedPalette entries: paletteEntries.
	^CgIcon
		width: 16
		height: 16
		depth: 1
		palette: palette
		shapePad: 4
		shapeData: shapeData
		maskPad: 4
		maskData: maskData!

abtInstanceGraphicsDescriptor
	"Return the descriptor for the icon representing the class."

	^self toolListIcon! !

Value class addSelectors: #(#toolListIcon #abtInstanceGraphicsDescriptor) toCategories: #('accessing')
!

!Value class publicMethods!

leafClasses
	^self allSubclasses select: [:subclass | subclass isLeafClass]!

subclassesWithConstants
	^Value allSubclasses select: [:aClass | aClass instVarNames notEmpty]! !

Value class addSelectors: #(#leafClasses #subclassesWithConstants) toCategories: #('accessing class hierarchy')
!

!Value class publicMethods!

evaluate: source
	^self compiler evaluate: source for: self! !

Value class addSelectors: #(#evaluate:) toCategories: #('compiling')
!

!Value class publicMethods!

allLeafClassesHaveEmptyInstance
	"tests that #asSource and #= are implemented"
	"self allLeafClassesHaveEmptyInstance"

	| nonConforming |
	nonConforming := Value leafClasses reject: [:class |
		class new asSource = (class name asString , ' new')].
	nonConforming notEmpty ifTrue: [
		^self error: 'some classes do not conform to the Value protocol'].
	^true!

allLeafClassesHaveWorkingExample
	"tests that #example is implemented and works"
	"self allLeafClassesHaveWorkingExample"

	| nonConforming |
	nonConforming := Value leafClasses reject: [:class |
		(((class class includesSelector: #localSpecification) and: [
		class class includesSelector: #example]) or: [
			true]) and: [
			class example asSource = (class evaluate: (class example asSourceFor: class)) asSource]].
	nonConforming notEmpty ifTrue: [
		^self error: 'some classes do not conform to the Value protocol'].
	^true!

allValuesHavePrinters
	"tests that #printvalueWith: is implemented when there is state"
	"self allValuesHavePrinters"

	| nonConforming |
	nonConforming := Value subclassesWithConstants reject: [:class |
		class includesSelector: ValueSpecification printSelector].
	nonConforming notEmpty ifTrue: [
		^self error: 'some classes do not conform to the Value protocol'].
	^true! !

Value class addSelectors: #(#allLeafClassesHaveEmptyInstance #allLeafClassesHaveWorkingExample #allValuesHavePrinters) toCategories: #('conformance testing')
!

!Value class publicMethods!

constant: aSymbol class: aLiteralBindingReference
	^ConstantSpecification selector: aSymbol type: aLiteralBindingReference!

constant: aSymbol class: aLiteralBindingReference comment: commentString
	^ConstantSpecification
		selector: aSymbol
		comment: commentString
		type: aLiteralBindingReference!

map: aSymbol
	^DictionarySpecification selector: aSymbol!

map: aSymbol comment: commentString
	^DictionarySpecification selector: aSymbol comment: commentString!

optional: aSymbol class: aLiteralBindingReference default: aString
	^OptionalConstantSpecification selector: aSymbol type: aLiteralBindingReference default: aString!

optional: aSymbol class: aLiteralBindingReference default: aString comment: commentString
	^OptionalConstantSpecification
		selector: aSymbol
		comment: commentString
		type: aLiteralBindingReference
		default: aString!

sequence: aSymbol
	^ArraySpecification selector: aSymbol!

sequence: aSymbol comment: commentString
	^ArraySpecification selector: aSymbol comment: commentString! !

Value class addSelectors: #(#constant:class: #constant:class:comment: #map: #map:comment: #optional:class:default: #optional:class:default:comment: #sequence: #sequence:comment:) toCategories: #('pragmas')
!

!Value class publicMethods!

differentPrintMethods
	"self differentPrintMethods"
	"construct change objects for all printers with different source code than generated"

	| change |
	change := CompositeRefactoryChange named: 'Different print methods in subclasses of ' , self name asString.
	self subclassesWithConstants do: [:aClass |
		(aClass specification sourcePrintvalueWithFor: aClass) ifNotNil: [:aRefactoryChangeOrNil |
			change addChange: aRefactoryChangeOrNil]].
	change changes isEmpty ifTrue: [
		^Value warn: 'No changes'].
	change inspect!

generateMethods
	"construct change objects and opens the list for the user to execute"

	| change |
	(self hasSpecification not and: [
	self isLeafClass not]) ifTrue: [
			^Value warn: 'no specification found and abstract'].
	change := CompositeRefactoryChange named: 'Create value methods for ' , self name asString.
	self specification addMethodsFor: self to: change.
	change changes isEmpty ifTrue: [
		^Value warn: 'No changes'].
	change inspect! !

Value class addSelectors: #(#differentPrintMethods #generateMethods) toCategories: #('source generation')
!

!Value class publicMethods!

localSpecification
	"specification of the constants with pragmas.
	Only for the instvars defined in this class - access the full specification with #specification"

	^self subclassResponsibility!

specification
	"<ValueSpecification>"
	"the comprehensive specification of the constants of this class"

	| constants superclasses |
	constants := OrderedCollection new.
	superclasses := self withAllSuperclasses reverse.	"from superclasses to subclasses"
	superclasses remove: Object.
	superclasses remove: Value.
	superclasses do: [:aSuperclass |
		(aSuperclass class includesSelector: #localSpecification) ifTrue: [
			| pragmas consts |
			pragmas := (aSuperclass class compiledMethodAt: #localSpecification) pragmas.
			consts := pragmas collect: [:pragma |
				Value perform: pragma keyword withArguments: pragma arguments].
			consts do: [:constant |
				(constants detect: [:c | c name = constant name] ifNone: [nil]) ifNotNil: [:c |
					constants remove: c	"subclasses overwrite superclass specifications"].
				constants add: constant]]].
	^ValueSpecification constants: constants! !

Value class addSelectors: #(#localSpecification #specification) toCategories: #('specification')
!

!Value class publicMethods!

example
	"<Value>"

	^self new!

literalExample
	^self example! !

Value class addSelectors: #(#example #literalExample) toCategories: #('test instances')
!

!Value class publicMethods!

hasSpecification
	^self class includesSelector: #localSpecification! !

Value class addSelectors: #(#hasSpecification) toCategories: #('testing')
!

!Value class publicMethods!

isLeafClass
	^self subclasses isEmpty! !

Value class addSelectors: #(#isLeafClass) toCategories: #('testing class hierarchy')
!

!Value class publicMethods!

warn: aString
	"Post the warning message."
	"Transformation NOTE: the pool constant syntax >::< is unknown in VW, 
	therefore, we use the values of the constants"

	(AbtMessagePrompter new)
		buttonType: 1;
		messageString: aString;
		iconType: 5;
		prompt	"CwConstant::XmOK"	"CwConstant::XmICONWARNING"!

request: aString initialAnswer: anAnswerString
	"Request a string from the user"

	(AbtTextPrompter new)
		messageString: aString;
		defaultAnswerString: anAnswerString;
		prompt! !

Value class addSelectors: #(#warn: #request:initialAnswer:) toCategories: #('user interface')
!

!Value publicMethods!

addAsMethod
	"<(Association key: class value: Symbol) | nil>
	generate a method for the receiver"

	^self addAsMethodNamed: self selectorString!

addAsMethodNamed: initialName
	"<Symbol | nil>
	generate a method for the receiver"

	| selectorString selector action source pretty change |
	self isUsefulTestInstance ifFalse: [
		^nil].
	selectorString := Value
		request: 'class method name in ' , self class name asString
		initialAnswer: initialName.
	selectorString isEmpty ifTrue: [
		^nil].
	selector := selectorString asSymbol.
	(self class respondsTo: selector) ifTrue: [
		Value warn: 'Method ' , selectorString , ' already exists. Please choose another name'.
		^self addAsMethodNamed: selectorString].
	source := self asMethodSourceFor: self class class named: selector.
	action := (self class class needs: source)
		ifTrue: [
		pretty := (RBParser parseMethod: source) formattedCode.
		change := AddMethodChange
			compile: pretty
			in: self class class
			protocols: (Array with: self methodProtocol)
			application: System defaultApplication.
		change]
		ifFalse: [
		nil].
	action ifNotNil: #execute.
	^self class class -> selector!

addAsTestInstanceIn: packageName
	"generate a method for the receiver"
	"Replace an existing instance when better"

	| selector source action |
	self isUsefulTestInstance ifFalse: [
		^self].
	selector := self selectorString asSymbol.
	(self isBetterTestInstanceSelector: selector) ifFalse: [
		^self].
	source := self asMethodSourceFor: self class class named: selector.
	action := (self class class needs: source)
		ifTrue: [
		| pretty change |
		pretty := (RBParser parseMethod: source) formattedCode.
		change := AddMethodChange
			compile: pretty
			in: self class class
			protocols: (Array with: self methodProtocol)
			application: System defaultApplication.
		change]
		ifFalse: [
		nil].
	action ifNotNil: #execute!

addMethod: source for: target in: protocol
	"<AddMethodChange | nil>"

	| pretty |
	(target needs: source) ifFalse: [
		^nil].
	pretty := (RBParser parseMethod: source) formattedCode.
	^AddMethodChange compile: pretty in: target classified: protocol!

addMethod: source for: target in: protocol package: aPackageModel
	"<AddMethodChange | nil>"

	| pretty change |
	(target needs: source) ifFalse: [
		^nil].
	pretty := (RBParser parseMethod: source) formattedCode.
	change := AddMethodChange compile: pretty in: target classified: protocol.
	change package: aPackageModel.
	^change!

addMethodNamed: selector for: target in: protocol
	"<AddMethodChange | nil>"

	^self addMethod: (self asMethodSourceNamed: selector) for: target in: protocol!

addMethodNamed: selector for: aMetaClass in: protocol package: aPackageModel
	"<AddMethodChange | nil>"

	^self
		addMethod: (self asMethodSourceFor: aMetaClass named: selector)
		for: aMetaClass
		in: protocol
		package: aPackageModel!

asMethodSourceFor: aMetaClass named: selector
	| wst |
	wst := WriteStream on: (String new: 200).
	wst
		nextPutAll: selector;
		crtab;
		nextPut: $^;
		nextPutAll: (self asSourceFor: aMetaClass soleInstance).
	^wst contents!

asMethodSourceNamed: selector
	| wst |
	wst := WriteStream on: (String new: 200).
	wst
		nextPutAll: selector;
		crtab;
		nextPut: $^;
		nextPutAll: self asSource.
	^wst contents!

betterTestInstanceThan: aValue
	"<Boolean>
	true, iff the receiver is better as a test instance than aValue"

	^true!

isBetterTestInstanceSelector: aSymbol
	(self class respondsTo: aSymbol) ifFalse: [
		^true].
	^self betterTestInstanceThan: (self class perform: aSymbol)!

isUsefulTestInstance
	^self notEmpty!

methodProtocol
	^#'test instances'!

newSelectorBasedOn: aString
	"<Symbol | nil>
	return a new selector by adding '_<Integer>' to the base selector"

	| selector count |
	selector := aString asSymbol.
	count := 1.
	[self class respondsTo: selector] whileTrue: [
		selector := (aString , '_' , count printString) asSymbol.
		count := count + 1].
	^selector!

selectorString
	"<String>"
	"if this object should be savable, implement this method to return a suitable unique string"

	^'example', self class name asString! !

Value addSelectors: #(#addAsMethod #addAsMethodNamed: #addAsTestInstanceIn: #addMethod:for:in: #addMethod:for:in:package: #addMethodNamed:for:in: #addMethodNamed:for:in:package: #asMethodSourceFor:named: #asMethodSourceNamed: #betterTestInstanceThan: #isBetterTestInstanceSelector: #isUsefulTestInstance #methodProtocol #newSelectorBasedOn: #selectorString) toCategories: #('source generation')
!

!Valuemap publicMethods!

describeOn: textStream
	textStream nextPutAllText: self class name asString asText allBold.
	textStream nextPutAll: ' new'.
	self keysAndValuesDo: [:key :value |
		textStream
			cr;
			tab;
			nextPutAll: 'at: ' , key printString , ' put: '.
		textStream nextPutAllText: value printString asText allBold.
		textStream nextPut: $;].
	textStream
		cr;
		tab;
		nextPutAll: 'yourself'!

descriptionText
	"<Text>	nicely formated for the user"

	| wst |
	wst := WriteStream on: (String new: 200).
	self describeOn: wst.
	^wst contents! !

Valuemap addSelectors: #(#describeOn: #descriptionText) toCategories: #('printing')
!

!ValuePrintvalue class publicMethods!

example
	^ValuePrintvalue
		classname: 'ConstantSpecification'
		arguments: (Array
			with: (Printargument name: 'selector' value: '#value')
			with: (Printargument name: 'type' value: '#{Number}'))! !

ValuePrintvalue class addSelectors: #(#example) toCategories: #('test instances')
!

ValuesToolsApp classes do: [:class |
	EtTools managerInterface versionClass: class in: ValuesToolsApp withName: '3.0.0.4']!
ValuesToolsApp releaseEachClassIn: ValuesToolsApp classes!
EtTools managerInterface versionApplication: ValuesToolsApp withName: '3.0.0.4'!
EtTools managerInterface flushCache!

ValuesToolsApp initializeAfterLoad!
ValuesToolsApp loaded!
