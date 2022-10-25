Class {
	#name : #DDMin,
	#superclass : #Object,
	#category : #DDMin
}

{ #category : #splitting }
DDMin >> complementOf: inputs without: subsetToRemove [

	^ inputs
		  flatCollect: [ :e | 
			  e == subsetToRemove
				  ifTrue: [ #(  ) ]
				  ifFalse: [ e ] ]
		  as: subsetToRemove species
]

{ #category : #reduction }
DDMin >> executeTestForSubsets: subsets [

	subsets do: [ :subsetToIgnore | 
		| inputToTest success |
		inputToTest := self complementOf: subsets without: subsetToIgnore.
		success := self test: inputToTest.
		success ifFalse: [ ^ { false. inputToTest } ] ].
	^ { true }
]

{ #category : #reduction }
DDMin >> reduce: input [

	^ self reduce: input initialSplitSize: 2
]

{ #category : #reduction }
DDMin >> reduce: input initialSplitSize: initialSplitSize [

	| splitSize reductionSet |
	splitSize := initialSplitSize.
	reductionSet := input.
	[ reductionSet size >= splitSize ] whileTrue: [ 
		| subsets previousReductionSet result success |
		previousReductionSet := reductionSet.
		subsets := self split: reductionSet size: splitSize.
		result := self executeTestForSubsets: subsets.
		success := result first.
		success ifFalse: [ reductionSet := result second ].
		reductionSet size < previousReductionSet size ifFalse: [ 
			splitSize := splitSize * 2 ] ].
	^ reductionSet
]

{ #category : #splitting }
DDMin >> split: input size: anInteger [ 
	
	| subsetSizes subsets inputStream |
	subsetSizes := (input size / anInteger) ceiling.
	subsets := OrderedCollection new.
	inputStream := input readStream.
	[ inputStream atEnd ] whileFalse: [
		subsets add: (inputStream next: subsetSizes)
	].
	^ subsets
]

{ #category : #testing }
DDMin >> test: input [

	self subclassResponsibility
]
