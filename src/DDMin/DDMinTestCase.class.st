Class {
	#name : #DDMinTestCase,
	#superclass : #TestCase,
	#category : #DDMin
}

{ #category : #tests }
DDMinTestCase >> testReduceAtBeginning [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :e | 
		"Fail if the string does not contain e"
		(e includes: $e) not ].
	
	self assert: (ddmin reduce: 'e123456789') equals: 'e'
]

{ #category : #tests }
DDMinTestCase >> testReduceAtEnd [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :e | 
		"Fail if the string does not contain e"
		(e includes: $e) not ].
	
	self assert: (ddmin reduce: '123456789e') equals: 'e'
]

{ #category : #tests }
DDMinTestCase >> testReduceAtMiddle [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :e | 
		"Fail if the string does not contain e"
		(e includes: $e) not ].
	
	self assert: (ddmin reduce: '1234e56789') equals: 'e'
]

{ #category : #tests }
DDMinTestCase >> testReduceNonFailing [

	| ddmin input |
	ddmin := AnonymousDDMin testing: [ :e | "success" true ].
	
	input := 'e123456789'.
	self assert: (ddmin reduce: input) equals: input
]

{ #category : #tests }
DDMinTestCase >> testReduceOddInput [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :e | 
		"Fail if the string does not contain e"
		(e includes: $e) not ].
	
	self assert: (ddmin reduce: '1234e5678') equals: 'e'
]

{ #category : #tests }
DDMinTestCase >> testReduceRedundantLargeSequence [

	| ddmin ipsum |
	ddmin := AnonymousDDMin testing: [ :e | (e asBag occurrencesOf: $a) <= 10 ].

	ipsum := String loremIpsum: 1024.

	self assert: (ddmin reduce: ipsum) equals: 'aaaaaaaaaaa'
]

{ #category : #tests }
DDMinTestCase >> testReduceRedundantSequence [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :e | "Fail if the string contains a before b"
		         ((e includes: $a) and: [ 
			          (e includes: $b) and: [ 
				          (e indexOf: $a) < (e indexOf: $b) ] ]) not ].

	self assert: (ddmin reduce: 'a12345b6789b') equals: 'ab'
]

{ #category : #tests }
DDMinTestCase >> testReduceSequence [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :e | "Fail if the string contains a before b"
		         ((e includes: $a) and: [ 
			          (e includes: $b) and: [ 
				          (e indexOf: $a) < (e indexOf: $b) ] ]) not ].

	self assert: (ddmin reduce: 'a123456789b') equals: 'ab'
]
