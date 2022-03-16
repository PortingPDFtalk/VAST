'From VisualWorks®, 8.3 of 28. Juli 2017 on 16. März 2022 at 09:53:55'!

"Created 16. März 2022 um 09:53:55 by VA Smalltalk Transform(1.4.0.8,chaider)"

AbtFeatureLoader new loadFeatureMapsNamed: #('Platform Portability')!

Application create: #ValuesApp with:
	(#(GreaseCoreApp GreaseVASTCoreApp)
		collect: [:className | Smalltalk at: className ifAbsent: [
			Application errorPrerequisite: #ValuesApp missing: className]])!

ValuesApp becomeDefault!

Application subclass: #ValuesApp
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

!ValuesApp class privateMethods !
abtIsViewApplication
	^false!
initializeAfterLoad
	(Smalltalk at: #Value) resetNamedValuesRegistry! !
!ValuesApp publicMethods!

notice
	^'The MIT License

Copyright © 2009-2018 Christian Haider

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.'!

parcelName
	^'Values'!

storeVersion
	^'3.0.0.3'!

 !
"VisualWorks stub classes"

EsOrderedDictionary
	subclass: #Valuemap
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

Valuemap comment: 'VisualWorks class'
!

Color
	subclass: #ColorValue
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

ColorValue comment: 'VisualWorks class'
!

DateAndTime
	subclass: #Timestamp
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

Timestamp comment: 'VisualWorks class'
!

Object
	subclass: #Value
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: 'NamedValuesRegistry'
	poolDictionaries: ''!

Value comment:
'Value is the abstract root object of values (literal objects).
All Value classes which have subclasses are considered abstract. Only leaf classes can have instances!!
Literal objects are created immutable with constructors.
The instance variables are object constants.

Subclasses must implement the following messages:
	class specification
		localSpecification'!

Value
	subclass: #Printvalue
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

Printvalue comment:
'A Printvalue holds a representation of a Value to be printed.
It consists of
	- classname 	<String>										properly resolved against a target class (#name or #fullName)
	- arguments 	<SequenceableCollection of: Printargument>		the list of arguments with constructor variable name and a Printvalue

Printvalues are created when printing the source for a Value in the first pass. The second pass takes the Printvalue and produces a nicely indented soure string for the value.'!

Printvalue
	subclass: #ArrayPrintvalue
	classInstanceVariableNames: ''
	instanceVariableNames: 'arguments'
	classVariableNames: ''
	poolDictionaries: ''!

ArrayPrintvalue comment:
'ArrayPrintvalue is a special Printvalue for sequentiable collections of Values'!

Object
	subclass: #Emitter
	classInstanceVariableNames: ''
	instanceVariableNames: 'printer stream level'
	classVariableNames: ''
	poolDictionaries: ''!

Emitter comment:
'Emitter outputs a Printvalue as formatted source code to a stream.
Subclasses write source or text.
This implements the second pass of the source generation for Values.

Instance Variables
	printer	<ValuePrinter>					the printer to resolve namespace names
	level	<Integer>						the indention level
	stream	<WriteStream | TextStream>		the output stream
'!

Emitter
	subclass: #SourceEmitter
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

SourceEmitter comment:
'SourceEmitter outputs source code.'!

SourceEmitter
	subclass: #Blockemitter
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

Blockemitter comment:
'Emits source as indented block'!

Emitter
	subclass: #TextEmitter
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

TextEmitter comment:
'TextEmitter outputs a descriptive text.'!

TextEmitter
	subclass: #TextLineemitter
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

TextLineemitter comment:
'TextLineEmitter emits text as one line'!

Value
	subclass: #Printargument
	classInstanceVariableNames: ''
	instanceVariableNames: 'name value'
	classVariableNames: ''
	poolDictionaries: ''!

Printargument comment:
'A Printargument holds the data to print one instance variable (constant) and its value.

	- name 	<String> 		the name of the argument
	- value 	<Printvalue>	the print value of the value

With Printvalue it represents the source for a Value'!

Printargument
	subclass: #DictionaryPrintargument
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

DictionaryPrintargument comment:
'DictionaryPrintargument holds the Printvalues for key and value of an entry in a dictionary.
Both key and value can be Values'!

Printvalue
	subclass: #LiteralPrintvalue
	classInstanceVariableNames: ''
	instanceVariableNames: 'string'
	classVariableNames: ''
	poolDictionaries: ''!

LiteralPrintvalue comment:
'LiteralPrintvalue is a Printvalue for literals.

Instance Variables:
	string	<String>	the representation as a string'!

Printvalue
	subclass: #DictionaryPrintvalue
	classInstanceVariableNames: ''
	instanceVariableNames: 'arguments isOrdered'
	classVariableNames: ''
	poolDictionaries: ''!

DictionaryPrintvalue comment:
'DictionaryPrintvalue is used for printing Dictionaries

Instance Variables:
	arguments	<SequenceableCollection of DictionaryPrintargument>	the Printarguments for each entry'!

Object
	subclass: #ValuePrinter
	classInstanceVariableNames: ''
	instanceVariableNames: 'target'
	classVariableNames: ''
	poolDictionaries: ''!

ValuePrinter comment:
'ValuePrinter creates the source for a Value.
For each level, a new ValuePrinter is created.

Instance Variables:
	target	<Value class>	defines the scoping for the created source - how class names are printed
	level	<Integer>		the indent level
	stream	<WriteStream>	a writestream passed around to collect the sources

'!

Printvalue
	subclass: #ValuePrintvalue
	classInstanceVariableNames: ''
	instanceVariableNames: 'classname arguments'
	classVariableNames: ''
	poolDictionaries: ''!

ValuePrintvalue comment:
'ValuePrintvalue holds the data to print a Value.

Instance Variables:
	arguments	<SequenceableCollection of: (Printargument | EmptyArgument)>	the arguments
	classname	<String>														the namespace aware name of the class

'!

TextEmitter
	subclass: #TextBlockemitter
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

TextBlockemitter comment:
'TextBlockEmitter emits text as indented block'!

SourceEmitter
	subclass: #Lineemitter
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

Lineemitter comment:
'Emits source as one line'!

!ArrayPrintvalue class publicMethods!

arguments: argumentsArray
	| inst |
	inst := self new.
	inst initializeArguments: argumentsArray.
	^inst! !

ArrayPrintvalue class addSelectors: #(#arguments:) toCategories: #('instance creation')
!

!ArrayPrintvalue class publicMethods!

localSpecification
	<sequence: #arguments>! !

ArrayPrintvalue class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!ArrayPrintvalue publicMethods!

arguments
	"<Array>"

	^arguments ifNil: [#()]!

sourceWith: emitter
	emitter emitArraySourceFor: self arguments! !

ArrayPrintvalue addSelectors: #(#arguments #sourceWith:) toCategories: #('accessing')
!

!ArrayPrintvalue publicMethods!

initializeArguments: argumentsArray
	(argumentsArray notNil and: [
	argumentsArray notEmpty]) ifTrue: [
			arguments := (Array withAll: argumentsArray) beImmutable].
	self beImmutable! !

ArrayPrintvalue addSelectors: #(#initializeArguments:) toCategories: #('initialize-release')
!

!ArrayPrintvalue publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer array: 'arguments' value: self arguments).
	^printer printvalue: self arguments: args! !

ArrayPrintvalue addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!ArrayPrintvalue publicMethods!

isLine
	^self arguments size = 1 or: [
	self arguments size < 5 and: [
	self arguments allSatisfy: [:arg | arg isSimple]]]! !

ArrayPrintvalue addSelectors: #(#isLine) toCategories: #('testing')
!

!Blockemitter publicMethods!

initializePrinter: aPrinter stream: aWriteStream level: anInteger
	printer := aPrinter.
	stream := aWriteStream.
	level := anInteger + 1! !

Blockemitter addSelectors: #(#initializePrinter:stream:level:) toCategories: #('initialize-release')
!

!Blockemitter publicMethods!

emitSeparator
	self stream cr.
	self level + 1 timesRepeat: [self stream tab]! !

Blockemitter addSelectors: #(#emitSeparator) toCategories: #('writing')
!

!DictionaryPrintargument class publicMethods!

localSpecification
	<constant: #name class: #(#Printvalue)>
	<constant: #value class: #(#Printvalue)>! !

DictionaryPrintargument class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!DictionaryPrintvalue class publicMethods!

arguments: argumentsArray isOrdered: isOrderedBoolean
	| inst |
	inst := self new.
	inst initializeArguments: argumentsArray isOrdered: isOrderedBoolean.
	^inst! !

DictionaryPrintvalue class addSelectors: #(#arguments:isOrdered:) toCategories: #('instance creation')
!

!DictionaryPrintvalue class publicMethods!

arguments: argumentsArray
	^self arguments: argumentsArray isOrdered: nil!

isOrdered: isOrderedBoolean
	^self arguments: nil isOrdered: isOrderedBoolean! !

DictionaryPrintvalue class addSelectors: #(#arguments: #isOrdered:) toCategories: #('instance creation optional')
!

!DictionaryPrintvalue class publicMethods!

localSpecification
	<sequence: #arguments>
	<optional: #isOrdered class: #(#Boolean) default: 'false'>! !

DictionaryPrintvalue class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!DictionaryPrintvalue publicMethods!

arguments
	"<Array>"

	^arguments ifNil: [#()]!

isOrdered
	"<Boolean>"

	^isOrdered ifNil: [false]!

sourceWith: emitter
	self isEmpty ifTrue: [
		^emitter emit: self targetClassname , ' new'].
	emitter emitDictionarySourceFor: self!

targetClass
	^self isOrdered
		ifTrue: [Valuemap]
		ifFalse: [Dictionary]!

targetClassname
	^self targetClass name asString! !

DictionaryPrintvalue addSelectors: #(#arguments #isOrdered #sourceWith: #targetClass #targetClassname) toCategories: #('accessing')
!

!DictionaryPrintvalue publicMethods!

initializeArguments: argumentsArray isOrdered: isOrderedBoolean
	(argumentsArray notNil and: [
	argumentsArray notEmpty]) ifTrue: [
			arguments := (Array withAll: argumentsArray) beImmutable].
	(isOrderedBoolean notNil and: [
	self isOrdered ~= isOrderedBoolean]) ifTrue: [
			isOrdered := isOrderedBoolean].
	self beImmutable! !

DictionaryPrintvalue addSelectors: #(#initializeArguments:isOrdered:) toCategories: #('initialize-release')
!

!DictionaryPrintvalue publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer array: 'arguments' value: self arguments).
	args add: (printer optional: 'isOrdered' value: isOrdered).
	^printer printvalue: self arguments: args! !

DictionaryPrintvalue addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!DictionaryPrintvalue publicMethods!

isEmpty
	^self arguments isEmpty!

isLine
	^self isEmpty! !

DictionaryPrintvalue addSelectors: #(#isEmpty #isLine) toCategories: #('testing')
!

!Emitter class publicMethods!

for: aPrinter
	| inst |
	inst := self new.
	inst initializePrinter: aPrinter stream: nil level: -1.
	^inst!

for: aPrinter on: aWriteStream at: anInteger
	| inst |
	inst := self new.
	inst initializePrinter: aPrinter stream: aWriteStream level: anInteger.
	^inst! !

Emitter class addSelectors: #(#for: #for:on:at:) toCategories: #('instance creation')
!

!Emitter publicMethods!

emitterClassFor: printvalue
	"<Emitter class>"

	^self subclassResponsibility!

emitterFor: printvalue
	"<Emitter>"

	^(self emitterClassFor: printvalue) for: self printer on: self stream at: self level!

level
	"<Integer>
	the indent level"

	^level ifNil: [0]!

printer
	"<ValuePrinter>"

	^printer!

stream
	"<WriteStream | TextStream>
	the output stream"

	^stream ifNil: [stream := self streamClass on: (String new: 100)]!

streamClass
	"<WriteStream class | TextStream class>"

	^self subclassResponsibility! !

Emitter addSelectors: #(#emitterClassFor: #emitterFor: #level #printer #stream #streamClass) toCategories: #('accessing')
!

!Emitter publicMethods!

initializePrinter: aPrinter stream: aWriteStream level: anInteger
	printer := aPrinter.
	stream := aWriteStream.
	level := anInteger! !

Emitter addSelectors: #(#initializePrinter:stream:level:) toCategories: #('initialize-release')
!

!Emitter publicMethods!

emit: aString
	self stream nextPutAll: aString!

emitArgument: aPrintargument
	self emit: aPrintargument name , ': '.
	aPrintargument value sourceFor: self!

emitArraySourceFor: anArray
	self inBracketsDo: [
		anArray size > 4
			ifTrue: [self emitLongCollection: anArray]
			ifFalse: [
			self emitSmallCollection: anArray]]!

emitClass: aString
	self emit: aString!

emitDictionarySourceFor: aDictionaryPrintvalue
	self inBracketsDo: [
		aDictionaryPrintvalue arguments size > 4
			ifTrue: [
			self emitLongDictionary: aDictionaryPrintvalue]
			ifFalse: [
			self emitSmallDictionary: aDictionaryPrintvalue]]!

emitEmpty: aValuePrintvalue
	"write the constructor for an empty instance"

	self emitClass: aValuePrintvalue classname.
	self emit: ' new'!

emitLongCollection: aSequenceableCollection
	self emit: '(', (OrderedCollection nameRelativeTo: self printer target) , ' new: ' , aSequenceableCollection size printString, ')'.
	aSequenceableCollection do: [:value |
		self emitSeparator.
		self emit: 'add: '.
		value sourceFor: self.
		self stream nextPut: $;].
	self emitSeparator.
	self emit: 'yourself'!

emitLongDictionary: aDictionaryPrintvalue
	self emit: '(', (aDictionaryPrintvalue targetClass nameRelativeTo: self printer target), ' new: ' , aDictionaryPrintvalue arguments size printString, ')'.
	aDictionaryPrintvalue arguments do: [:argument |
		self emitSeparator.
		self emit: 'add: '.
		argument name sourceFor: self.
		self emit: ' -> '.
		argument value sourceFor: self.
		self stream nextPut: $;].
	self emitSeparator.
	self emit: 'yourself'!

emitSeparator
	self subclassResponsibility!

emitSmallCollection: aSequenceableCollection
	self emit: (Array nameRelativeTo: self printer target).
	aSequenceableCollection do: [:value |
		self emitSeparator.
		self emit: 'with: '.
		value sourceFor: self]!

emitSmallDictionary: aDictionaryPrintvalue
	self emit: (aDictionaryPrintvalue targetClass nameRelativeTo: self printer target).
	aDictionaryPrintvalue arguments do: [:argument |
		self emitSeparator.
		self emit: 'with: '.
		argument name sourceFor: self.
		self emit: ' -> '.
		argument value sourceFor: self]!

emitValue: aString
	self emit: aString!

inBracketsDo: aZeroArgumentBlock
	self stream nextPut: $(.
	aZeroArgumentBlock ensure: [self stream nextPut: $)]! !

Emitter addSelectors: #(#emit: #emitArgument: #emitArraySourceFor: #emitClass: #emitDictionarySourceFor: #emitEmpty: #emitLongCollection: #emitLongDictionary: #emitSeparator #emitSmallCollection: #emitSmallDictionary: #emitValue: #inBracketsDo:) toCategories: #('writing')
!

!Lineemitter publicMethods!

emitSeparator
	self stream space! !

Lineemitter addSelectors: #(#emitSeparator) toCategories: #('writing')
!

!LiteralPrintvalue class publicMethods!

string: stringString
	| inst |
	inst := self new.
	inst initializeString: stringString.
	^inst! !

LiteralPrintvalue class addSelectors: #(#string:) toCategories: #('instance creation')
!

!LiteralPrintvalue class publicMethods!

localSpecification
	<constant: #string class: #(#String)>! !

LiteralPrintvalue class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!LiteralPrintvalue publicMethods!

sourceWith: emitter
	emitter emitValue: self string!

string
	"<String>"

	^string! !

LiteralPrintvalue addSelectors: #(#sourceWith: #string) toCategories: #('accessing')
!

!LiteralPrintvalue publicMethods!

initializeString: stringString
	string := stringString.
	self beImmutable! !

LiteralPrintvalue addSelectors: #(#initializeString:) toCategories: #('initialize-release')
!

!LiteralPrintvalue publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'string' value: self string).
	^printer printvalue: self arguments: args! !

LiteralPrintvalue addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!LiteralPrintvalue publicMethods!

isLine
	^true!

isSimple
	^(self string first = $() not! !

LiteralPrintvalue addSelectors: #(#isLine #isSimple) toCategories: #('testing')
!

!Printargument class publicMethods!

name: nameString value: valuePrintvalue
	| inst |
	inst := self new.
	inst initializeName: nameString value: valuePrintvalue.
	^inst! !

Printargument class addSelectors: #(#name:value:) toCategories: #('instance creation')
!

!Printargument class publicMethods!

localSpecification
	<constant: #name class: #(#String)>
	<constant: #value class: #(#Printvalue)>! !

Printargument class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!Printargument publicMethods!

name
	"<String>"

	^name!

sourceWith: emitter
	emitter emitArgument: self!

value
	"<Printvalue>"

	^value! !

Printargument addSelectors: #(#name #sourceWith: #value) toCategories: #('accessing')
!

!Printargument publicMethods!

initializeName: nameString value: valuePrintvalue
	name := nameString.
	value := valuePrintvalue.
	self beImmutable! !

Printargument addSelectors: #(#initializeName:value:) toCategories: #('initialize-release')
!

!Printargument publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'name' value: self name).
	args add: (printer constant: 'value' value: self value).
	^printer printvalue: self arguments: args! !

Printargument addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!Printargument publicMethods!

isSimple
	^self value isSimple! !

Printargument addSelectors: #(#isSimple) toCategories: #('testing')
!

!Printvalue publicMethods!

description
	"<Text>"

	| emitter |
	emitter := self textemitterClass new.
	self sourceWith: emitter.
	^emitter stream contents!

emitterClass
	"<SourceEmitter class>"

	^self isLine
		ifTrue: [Lineemitter]
		ifFalse: [Blockemitter]!

sourceFor: outerEmitter
	"<String>"

	^self sourceWith: (outerEmitter emitterFor: self)!

sourceWith: emitter
	"write yourself with the emitter"

	^self subclassResponsibility!

sourceWithPrinter: aPrinter
	"<String>"

	| emitter |
	emitter := self emitterClass for: aPrinter.
	self sourceWith: emitter.
	^emitter stream contents!

textemitterClass
	"<SourceEmitter class>"

	^self isLine
		ifTrue: [TextLineemitter]
		ifFalse: [TextBlockemitter]! !

Printvalue addSelectors: #(#description #emitterClass #sourceFor: #sourceWith: #sourceWithPrinter: #textemitterClass) toCategories: #('accessing')
!

!Printvalue publicMethods!

isLine
	^false!

isSimple
	"does it have to be printed in brackets?
	only literals are simple"

	^false! !

Printvalue addSelectors: #(#isLine #isSimple) toCategories: #('testing')
!

!SourceEmitter publicMethods!

emitterClassFor: printvalue
	^printvalue isLine
		ifTrue: [Lineemitter]
		ifFalse: [Blockemitter]!

streamClass
	^WriteStream! !

SourceEmitter addSelectors: #(#emitterClassFor: #streamClass) toCategories: #('accessing')
!

!TextBlockemitter publicMethods!

initializePrinter: aPrinter stream: aWriteStream level: anInteger
	printer := aPrinter.
	stream := aWriteStream.
	level := anInteger + 1! !

TextBlockemitter addSelectors: #(#initializePrinter:stream:level:) toCategories: #('initialize-release')
!

!TextBlockemitter publicMethods!

emitSeparator
	self stream cr.
	self level + 1 timesRepeat: [self stream tab]!

inBracketsDo: aZeroArgumentBlock
	aZeroArgumentBlock value! !

TextBlockemitter addSelectors: #(#emitSeparator #inBracketsDo:) toCategories: #('writing')
!

!TextEmitter publicMethods!

emitterClassFor: printvalue
	^printvalue isLine
		ifTrue: [TextLineemitter]
		ifFalse: [TextBlockemitter]!

streamClass
	^WriteStream! !

TextEmitter addSelectors: #(#emitterClassFor: #streamClass) toCategories: #('accessing')
!

!TextEmitter publicMethods!

emitArraySourceFor: anArray
	self emitSmallCollection: anArray!

emitBold: aString
	"could not find bold text"

	self stream nextPutAll: aString!

emitClass: aString
	self emitBold: aString!

emitDictionarySourceFor: aDictionaryPrintvalue
	self emitSmallDictionary: aDictionaryPrintvalue!

emitSmallCollection: aSequenceableCollection
	aSequenceableCollection do: [:value |
		self emitSeparator.
		value sourceFor: self]!

emitSmallDictionary: aDictionaryPrintvalue
	aDictionaryPrintvalue arguments do: [:argument |
		self emitSeparator.
		argument name sourceFor: self.
		self emit: ': '.
		argument value sourceFor: self]!

emitValue: aString
	self emitBold: aString! !

TextEmitter addSelectors: #(#emitArraySourceFor: #emitBold: #emitClass: #emitDictionarySourceFor: #emitSmallCollection: #emitSmallDictionary: #emitValue:) toCategories: #('writing')
!

!TextLineemitter publicMethods!

emitSeparator
	self stream space! !

TextLineemitter addSelectors: #(#emitSeparator) toCategories: #('writing')
!

!Value class publicMethods!

obsolete
	self allInstancesDo: #beMutable.
	super obsolete! !

Value class addSelectors: #(#obsolete) toCategories: #('class initialization')
!

!Value class publicMethods!

primeRuntime
	"reset and load all class variables to fill the caches to avoid lazy initialization at runtime.
	This should be executed when deploying after all application fonts and extensions are loaded"
	"self primeRuntime"

	self resetNamedValuesRegistry.
	Object namesByValues!

resetNamedValuesRegistry
	"self resetNamedValuesRegistry"

	NamedValuesRegistry := nil! !

Value class addSelectors: #(#primeRuntime #resetNamedValuesRegistry) toCategories: #('initialize-release')
!

!Value class publicMethods!

namedValuesAt: aClass
	"<Dictionary key: Value value: Symbol>
	the named instances of aClass"

	^self namedValuesRegistry at: aClass ifAbsent: [Dictionary new]!

namedValuesAt: aClass ifAbsentPut: aBlock
	"<Dictionary key: Value value: Symbol>
	the named instances of aClass"

	^self namedValuesRegistry at: aClass ifAbsentPut: aBlock!

namedValuesRegistry
	"<Dictionary key: Class value: (Dictionary key: Value value: Symbol)>
	the named instances of classes.
	This is a light weight implementation to hold all named instances of all classes, instead of storing them with the class"
	
	^NamedValuesRegistry ifNil: [NamedValuesRegistry := Dictionary new]! !

Value class addSelectors: #(#namedValuesAt: #namedValuesAt:ifAbsentPut: #namedValuesRegistry) toCategories: #('named values')
!

!Value class publicMethods!

specificationPragmas
	<pragmas: #class>
	^#(
		#constant:class:
		#constant:class:comment:
		
		#optional:class:default:
		#optional:class:default:comment:
		
		#sequence:
		#sequence:comment:
		
		#map:
		#map:comment:
	)! !

Value class addSelectors: #(#specificationPragmas) toCategories: #('pragmas')
!

!Value publicMethods!

= anObject
	"all instvars must be equal"

	^self isEqualValue: anObject!

hash
	^(1 to: self class instSize) inject: 0 into: [:hash :i | hash bitXor: (self instVarAt: i) hash]!

isEqualValue: anObject
	self == anObject ifTrue: [
		^true].
	self class = anObject class ifFalse: [
		^false].
	1 to: self class instSize do: [:i |
		((self instVarAt: i) isEqualValue: (anObject instVarAt: i)) ifFalse: [
			^false]].
	^true! !

Value addSelectors: #(#= #hash #isEqualValue:) toCategories: #('comparing')
!

!Value publicMethods!

postCopy
	super postCopy.
	self beImmutable! !

Value addSelectors: #(#postCopy) toCategories: #('copying')
!

!Value publicMethods!

passMode
	"for OpenTalk StSt (Smalltalk to Smalltalk)"

	^#value! !

Value addSelectors: #(#passMode) toCategories: #('marshaling')
!

!Value publicMethods!

printOn: stream
	stream nextPutAll: self asSource!

printvalueWith: printer
	^printer printvalue: self arguments: #()! !

Value addSelectors: #(#printOn: #printvalueWith:) toCategories: #('printing')
!

!Value publicMethods!

isEmpty
	^self = self class new!

notEmpty
	^self isEmpty not! !

Value addSelectors: #(#isEmpty #notEmpty) toCategories: #('testing')
!

!Valuemap publicMethods!

atIndex: anIndex
	"<Association>"

	anIndex isInteger ifFalse: [
		^ExCLDTInvalidArgument signalWith: anIndex].
	^self associationAtIndex: anIndex ifAbsent: [
		ExCLDTIndexOutOfRange signalWith: anIndex]!

first
	"<Association>"

	^self associationAt: self keys first!

indexOf: aKey
	"<Integer>"

	^self keys indexOf: aKey!

last
	"<Association>"

	^self associationAt: self keys last! !

Valuemap addSelectors: #(#atIndex: #first #indexOf: #last) toCategories: #('accessing')
!

!Valuemap publicMethods!

keysForPrinting
	^self keys!

printvalueWith: printer
	^DictionaryPrintvalue arguments: (self printargumentsWith: printer) isOrdered: true! !

Valuemap addSelectors: #(#keysForPrinting #printvalueWith:) toCategories: #('printing')
!

!ValuePrinter class publicMethods!

newFor: targetClass
	| inst |
	inst := self new.
	inst initializeTarget: targetClass.
	^inst! !

ValuePrinter class addSelectors: #(#newFor:) toCategories: #('instance creation')
!

!ValuePrinter publicMethods!

array: selectorname value: object
	"<Printargument | nil>"

	object isEmpty ifTrue: [
		^nil].
	^Printargument name: selectorname value: (object printvalueWith: self)!

classnameOf: value
	^value class nameRelativeTo: self target!

constant: selectorname value: object
	"<Printargument>"

	^Printargument name: selectorname value: (object printvalueWith: self)!

dictionary: selectorname value: object
	"<Printargument | nil>"

	object isEmpty ifTrue: [
		^nil].
	^Printargument name: selectorname value: (object printvalueWith: self)!

optional: selectorname value: object
	"<Printargument | nil>"

	^object ifNotNil: [
		Printargument name: selectorname value: (object printvalueWith: self)]!

printvalue: aValue arguments: arguments
	aValue class new = aValue ifTrue: [
		^ValuePrintvalue classname: (self classnameOf: aValue)].
	^ValuePrintvalue
		classname: (self classnameOf: aValue)
		arguments: (arguments select: [:arg |
			arg notNil])!

target
	"<Value class>
	the class for which the object is printed.
	Takes the visibility of classes into account for short class name generation"

	^target! !

ValuePrinter addSelectors: #(#array:value: #classnameOf: #constant:value: #dictionary:value: #optional:value: #printvalue:arguments: #target) toCategories: #('accessing')
!

!ValuePrinter publicMethods!

initializeTarget: targetClass
	target := targetClass! !

ValuePrinter addSelectors: #(#initializeTarget:) toCategories: #('initialize-release')
!

!ValuePrintvalue class publicMethods!

classname: classnameString arguments: argumentsArray
	| inst |
	inst := self new.
	inst initializeClassname: classnameString arguments: argumentsArray.
	^inst! !

ValuePrintvalue class addSelectors: #(#classname:arguments:) toCategories: #('instance creation')
!

!ValuePrintvalue class publicMethods!

classname: classnameString
	^self classname: classnameString arguments: nil! !

ValuePrintvalue class addSelectors: #(#classname:) toCategories: #('instance creation optional')
!

!ValuePrintvalue class publicMethods!

localSpecification
	<constant: #classname class: #(#String)>
	<sequence: #arguments>! !

ValuePrintvalue class addSelectors: #(#localSpecification) toCategories: #('specification')
!

!ValuePrintvalue publicMethods!

arguments
	"<Array>"

	^arguments ifNil: [#()]!

classname
	"<String>"

	^classname!

sourceWith: emitter
	self arguments isEmpty ifTrue: [
		^emitter emitEmpty: self].
	emitter inBracketsDo: [
		emitter emitClass: self classname.
		self arguments do: [:arg |
			emitter emitSeparator.
			emitter emitArgument: arg]]! !

ValuePrintvalue addSelectors: #(#arguments #classname #sourceWith:) toCategories: #('accessing')
!

!ValuePrintvalue publicMethods!

initializeClassname: classnameString arguments: argumentsArray
	classname := classnameString.
	(argumentsArray notNil and: [
	argumentsArray notEmpty]) ifTrue: [
			arguments := (Array withAll: argumentsArray) beImmutable].
	self beImmutable! !

ValuePrintvalue addSelectors: #(#initializeClassname:arguments:) toCategories: #('initialize-release')
!

!ValuePrintvalue publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'classname' value: self classname).
	args add: (printer array: 'arguments' value: self arguments).
	^printer printvalue: self arguments: args! !

ValuePrintvalue addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!ValuePrintvalue publicMethods!

isLine
	self arguments size = 1 ifTrue: [
		^self arguments first value isLine].
	^self arguments size < 5 and: [
	self arguments allSatisfy: [:arg | arg isSimple]]! !

ValuePrintvalue addSelectors: #(#isLine) toCategories: #('testing')
!

!ColorValue class publicMethods!

fromByte: anInteger
	^self fromBytes: (ByteArray new: 3 withAll: anInteger)!

fromBytes: threeBytes
	^self fromBytesRed: threeBytes first green: (threeBytes at: 2) blue: threeBytes last!

fromBytesRed: redByte green: greenByte blue: blueByte
	^self red: redByte / 255 green: greenByte / 255 blue: blueByte / 255!

red: r green: g blue: b
	^super red: r * 255 green: g * 255 blue: b * 255! !

ColorValue class addSelectors: #(#fromByte: #fromBytes: #fromBytesRed:green:blue: #red:green:blue:) toCategories: #('instance creation')
!

!ColorValue class publicMethods!

namedValueNames
	"The selection is the common set of color names with identical colors in VW and Squeak/Pharo
	The colors are all variations of min and max of the 3 components"
	"self namesByValues"
	
	^#(#black #white
	#red #green #blue
	#cyan #magenta #yellow)!

black
	^super black asColorValue!

white
	^super white asColorValue!

red
	^super red asColorValue!

green
	^super green asColorValue!

blue
	^super blue asColorValue!

cyan
	^super cyan asColorValue!

magenta
	^self fromBytesRed: 255 green: 0 blue: 255!

yellow
	^super yellow asColorValue! !

ColorValue class addSelectors: #(#namedValueNames #black #white #red #green #blue #cyan #magenta #yellow) toCategories: #('named values')
!

!ColorValue publicMethods!

asByteArray
	^ByteArray
		with: (self red * 255) truncated
		with: (self green * 255) truncated
		with: (self blue * 255) truncated!

asGrayValue
	"<Number>
	between 0.0 (Black) and 1.0 (White) suitable for PDF DeviceGray"

	^self brightness!

rgbIndex
	"<Integer>
	Three 8 bit RGB numbers interpreted as number for ordering"

	^self asByteArray inject: 0 into: [:num :byte | (num bitShift: 8) + byte]!

asColorValue
	^self!

asByteArray
	^ByteArray
		with: (self red * 255) truncated
		with: (self green * 255) truncated
		with: (self blue * 255) truncated! !

ColorValue addSelectors: #(#asByteArray #asGrayValue #rgbIndex #asColorValue #asByteArray) toCategories: #('converting')
!

!ColorValue publicMethods!

printvalueWith: printer
	| args |
	(self class nameOrNilFor: self) ifNotNil: [:symbol |
		^LiteralPrintvalue string: (printer classnameOf: self) , ' ' , symbol asString].
	args := OrderedCollection new.
	args add: (printer constant: 'fromBytesRed' value: (self red * 255) rounded).
	args add: (printer constant: 'green' value: (self green * 255) rounded).
	args add: (printer constant: 'blue' value: (self blue * 255) rounded).
	^printer printvalue: self arguments: args! !

ColorValue addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!ColorValue publicMethods!

isEmpty
	^false!

= anObject
	^self class == anObject class and: [
	self red = anObject red and: [
	self green = anObject green and: [
	self blue = anObject blue]]]! !

ColorValue addSelectors: #(#isEmpty #=) toCategories: #('testing')
!

!ColorValue publicMethods!

red
	"<Number[0..1]>
	the red part of the receiver"

	^super red / 16rFFFF!

green
	"<Number[0..1]>
	the green part of the receiver"

	^super green / 16rFFFF!

blue
	"<Number[0..1]>
	the blue part of the receiver"

	^super blue / 16rFFFF!

cyan
	"<Number[0..1]>
	the cyan part of the receiver"

	^1.0 - self red!

magenta
	"<Number[0..1]>
	the magenta part of the receiver"

	^1.0 - self green!

yellow
	"<Number[0..1]>
	the yellow part of the receiver"

	^1.0 - self blue! !

ColorValue addSelectors: #(#red #green #blue #cyan #magenta #yellow) toCategories: #('accessing')
!

!Timestamp class publicMethods!

d: dayInteger m: monthInteger y: yearInteger
	^self d: dayInteger m: monthInteger y: yearInteger h: 0 m: 0 s: 0!

d: dayInteger m: monthInteger y: yearInteger h: hoursInteger
	^self d: dayInteger m: monthInteger y: yearInteger h: hoursInteger m: 0 s: 0!

d: dayInteger m: monthInteger y: yearInteger h: hoursInteger m: minutesInteger
	^self d: dayInteger m: monthInteger y: yearInteger h: hoursInteger m: minutesInteger s: 0!

d: dayInteger m: monthInteger y: yearInteger h: hoursInteger m: minutesInteger s: secondsInteger
	| date time |
	date := Date d: dayInteger m: monthInteger y: yearInteger.
	time := Time h: hoursInteger m: minutesInteger s: secondsInteger.
	^self date: date time: time! !

Timestamp class addSelectors: #(#d:m:y: #d:m:y:h: #d:m:y:h:m: #d:m:y:h:m:s:) toCategories: #('instance creation')
!

!Timestamp publicMethods!

printvalueWith: printer
	| wst |
	wst := WriteStream on: (String new: 50).
	wst
		nextPut: $(;
		nextPutAll: (printer classnameOf: self);
		nextPutAll: ' d: ';
		nextPutAll: self dayOfMonth printString;
		nextPutAll: ' m: ';
		nextPutAll: self month printString;
		nextPutAll: ' y: ';
		nextPutAll: self year printString.
	(self hour isZero and: [
	self minute isZero and: [
	self second isZero]]) ifTrue: [
			wst nextPut: $).
			^LiteralPrintvalue string: wst contents].
	wst
		nextPutAll: ' h: ';
		nextPutAll: self hour printString.
	(self minute isZero and: [
	self second isZero]) ifTrue: [
			wst nextPut: $).
			^LiteralPrintvalue string: wst contents].
	wst
		nextPutAll: ' m: ';
		nextPutAll: self minute printString.
	self second isZero ifTrue: [
		wst nextPut: $).
		^LiteralPrintvalue string: wst contents].
	wst
		nextPutAll: ' s: ';
		nextPutAll: self second printString;
		nextPut: $).
	^LiteralPrintvalue string: wst contents! !

Timestamp addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!EsString publicMethods!

literalString
	^self storeString!

 !

EsString addSelectors: #(#literalString) toCategories: #('printing')!

!Symbol publicMethods!

literalString
	self asString isSmalltalkIdentifier ifTrue: [
		^self printString].
	^self storeString!

 !

Symbol addSelectors: #(#literalString) toCategories: #('printing')!

!Array publicMethods!

literalString
	| wst |
	wst := String new writeStream.
	wst nextPutAll: '#('.
	self do: [:elem | wst nextPutAll: elem asSource] separatedBy: [wst space].
	wst nextPut: $).
	^wst contents!

 !

Array addSelectors: #(#literalString) toCategories: #('printing')!

!KeyedCollection publicMethods!

keysForPrinting
	^[self keys asSortedCollection] on: Error do: [:ex | ex return: self keys]!

printargumentsWith: printer
	| args |
	args := OrderedCollection new.
	self keysForPrinting do: [:key |
		args add: (DictionaryPrintargument
			name: (key printvalueWith: printer)
			value: ((self at: key) printvalueWith: printer))].
	^args!

 !

KeyedCollection addSelectors: #(#keysForPrinting #printargumentsWith:) toCategories: #('printing')!

!Color publicMethods!

asColorValue
	^ColorValue red: self red / 16rFFFF green: self green / 16rFFFF blue: self blue / 16rFFFF!

 !

Color addSelectors: #(#asColorValue) toCategories: #('converting')!

!Class publicMethods!

nameRelativeTo: targetClass
	"<String>"
	"self nameRelativeTo: Object"
	"there are no namespaces in VA"

	^self name asString! !

Class addSelectors: #(#nameRelativeTo:) toCategories: #('accessing')
!

!Class publicMethods!

isInScope: aClass
	"<Boolean>
	true if aClass is visible by the receiver - aClass can be used in the source without namespace qualifier.
	false when aClass cannot be seen by the receiver - use the fullName"
	"All classes are globally visible in VA"

	^true! !

Class addSelectors: #(#isInScope:) toCategories: #('testing')
!

!Date class publicMethods!

d: dayInteger m: monthInteger y: yearInteger
	^self newDay: dayInteger monthIndex: monthInteger year: yearInteger! !

Date class addSelectors: #(#d:m:y:) toCategories: #('instance creation')
!

!Date publicMethods!

printvalueWith: printer
	| wst |
	wst := WriteStream on: (String new: 25).
	wst
		nextPut: $(;
		nextPutAll: (printer classnameOf: self);
		nextPutAll: ' d: ';
		nextPutAll: self dayOfMonth printString;
		nextPutAll: ' m: ';
		nextPutAll: self monthIndex printString;
		nextPutAll: ' y: ';
		nextPutAll: self year printString;
		nextPut: $).
	^LiteralPrintvalue string: wst contents! !

Date addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!Dictionary publicMethods!

isEqualValue: anObject
	^self contentsEquals: anObject! !

Dictionary addSelectors: #(#isEqualValue:) toCategories: #('dictionary testing')
!

!Dictionary publicMethods!

keysForPrinting
	^[self keys asSortedCollection] on: Error do: [:ex | ex return: self keys]!

printargumentsWith: printer
	| args |
	args := OrderedCollection new.
	self keysForPrinting do: [:key |
		args add: (DictionaryPrintargument
			name: (key printvalueWith: printer)
			value: ((self at: key) printvalueWith: printer))].
	^args!

printvalueWith: printer
	^DictionaryPrintvalue arguments: (self printargumentsWith: printer)! !

Dictionary addSelectors: #(#keysForPrinting #printargumentsWith: #printvalueWith:) toCategories: #('printing')
!

!Duration class publicMethods!

nanoseconds: aNumber
	^aNumber nanoseconds! !

Duration class addSelectors: #(#nanoseconds:) toCategories: #('instance creation')
!

!Duration publicMethods!

printvalueWith: printer
	| wst |
	wst := WriteStream on: (String new: 25).
	wst
		nextPut: $(;
		nextPutAll: (printer classnameOf: self);
		nextPutAll: ' nanoseconds: ';
		nextPutAll: self asNanoseconds printString;
		nextPut: $).
	^LiteralPrintvalue string: wst contents! !

Duration addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!Object class publicMethods!

namedValueNames
	"<Array of: Symbol>
	names to print for special known values"
	
	^#()!

nameOrNilFor: aValue
	"<Symbol | nil>"

	^self namesByValues at: aValue ifAbsent: [nil]!

namesByValues
	"<Dictionary key: Value value: Symbol>"

	^Value namedValuesAt: self ifAbsentPut: [self newNamesByValues]!

newNamesByValues
	"<Dictionary key: Value value: Symbol>"

	| dict |
	dict := Valuemap new: self namedValueNames size.
	self namedValueNames do: [:symbol | dict at: (self perform: symbol) put: symbol].
	^dict! !

Object class addSelectors: #(#namedValueNames #nameOrNilFor: #namesByValues #newNamesByValues) toCategories: #('named values')
!

!Object publicMethods!

isEqualValue: anObject
	^self = anObject! !

Object addSelectors: #(#isEqualValue:) toCategories: #('comparing')
!

!Object publicMethods!

asDescription
	"<Text>
	produces a text equivalent to the soure with bold leaf values"

	^self asDescriptionFor: self class!

asDescriptionFor: targetClass
	"<Text>
	produces a text equivalent to the source"

	| printer printvalue |
	printer := ValuePrinter newFor: targetClass.
	printvalue := self printvalueWith: printer.
	^printvalue description!

asSource
	"<String>
	produces a string which can be evaluated in the context of the receiver class to an object equivalent to the receiver"

	^self asSourceFor: self class!

asSourceFor: targetClass
	"<String>
	produces a string which can be evaluated in the context of targetClass to an object equivalent to the receiver"

	| printer printvalue |
	printer := ValuePrinter newFor: targetClass.
	printvalue := self printvalueWith: printer.
	^printvalue sourceWithPrinter: printer!

printvalueWith: printer
	^LiteralPrintvalue string: self storeString!

literalString
	"<String | nil>
	answers a string iff the receiver can be printed so that the compiler reconstructs the receiver from it"

	^nil! !

Object addSelectors: #(#asDescription #asDescriptionFor: #asSource #asSourceFor: #printvalueWith: #literalString) toCategories: #('printing')
!

!Object publicMethods!

beImmutable
	self markReadOnly: true.
	^self!

beMutable
	self markReadOnly: false.
	^self! !

Object addSelectors: #(#beImmutable #beMutable) toCategories: #('actions')
!

!Point publicMethods!

printvalueWith: printer
	| string |
	string := (self x asSourceFor: printer target) , ' @ ' , (self y asSourceFor: printer target).
	^LiteralPrintvalue string: string! !

Point addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!Rectangle publicMethods!

printvalueWith: printer
	| wst |
	wst := WriteStream on: (String new: 25).
	wst
		nextPut: $(;
		nextPutAll: (self origin asSourceFor: printer target);
		nextPutAll: ' corner: ';
		nextPutAll: (self corner asSourceFor: printer target);
		nextPut: $).
	^LiteralPrintvalue string: wst contents! !

Rectangle addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

!SequenceableCollection publicMethods!

printvalueWith: printer
	self isLiteral ifTrue: [
		^LiteralPrintvalue string: self literalString].
	^ArrayPrintvalue arguments: (self collect: [:item | item printvalueWith: printer])!

printvalueWith: printer
	self isLiteral ifTrue: [
		^LiteralPrintvalue string: self literalString].
	^ArrayPrintvalue arguments: (self collect: [:item | item printvalueWith: printer])! !

SequenceableCollection addSelectors: #(#printvalueWith: #printvalueWith:) toCategories: #('printing')
!

!Time class publicMethods!

h: hoursInteger
	^self h: hoursInteger m: 0 s: 0!

h: hoursInteger m: minutesInteger
	^self h: hoursInteger m: minutesInteger s: 0!

h: hoursInteger m: minutesInteger s: secondsInteger
	| inst |
	inst := self new.
	inst hours: hoursInteger minutes: minutesInteger seconds: secondsInteger.
	^inst!

zero
	^self h: 0! !

Time class addSelectors: #(#h: #h:m: #h:m:s: #zero) toCategories: #('instance creation')
!

!Time publicMethods!

printvalueWith: printer
	| wst |
	wst := WriteStream on: (String new: 25).
	(self hours isZero and: [
	self minutes isZero and: [
	self seconds isZero]]) ifTrue: [
			wst
				nextPutAll: (printer classnameOf: self);
				nextPutAll: ' zero'.
			^LiteralPrintvalue string: wst contents].
	wst
		nextPut: $(;
		nextPutAll: (printer classnameOf: self);
		nextPutAll: ' h: ';
		nextPutAll: self hours printString.
	(self minutes isZero and: [
	self seconds isZero]) ifTrue: [
			wst nextPut: $).
			^LiteralPrintvalue string: wst contents].
	wst
		nextPutAll: ' m: ';
		nextPutAll: self minutes printString.
	self seconds isZero ifTrue: [
		wst nextPut: $).
		^LiteralPrintvalue string: wst contents].
	wst
		nextPutAll: ' s: ';
		nextPutAll: self seconds printString;
		nextPut: $).
	^LiteralPrintvalue string: wst contents! !

Time addSelectors: #(#printvalueWith:) toCategories: #('printing')
!

ValuesApp classes do: [:class |
	EtTools managerInterface versionClass: class in: ValuesApp withName: '3.0.0.3']!
ValuesApp releaseEachClassIn: ValuesApp classes!
EtTools managerInterface versionApplication: ValuesApp withName: '3.0.0.3'!
EtTools managerInterface flushCache!

ValuesApp initializeAfterLoad!
ValuesApp loaded!
