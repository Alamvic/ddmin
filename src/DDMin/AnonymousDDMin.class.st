Class {
	#name : #AnonymousDDMin,
	#superclass : #DDMin,
	#instVars : [
		'testBlock'
	],
	#category : #DDMin
}

{ #category : #'instance creation' }
AnonymousDDMin class >> testing: aFullBlockClosure [ 
	
	^ self new
		testBlock: aFullBlockClosure;
		yourself
]

{ #category : #testing }
AnonymousDDMin >> test: input [

	^ testBlock value: input
]

{ #category : #accessing }
AnonymousDDMin >> testBlock: aFullBlockClosure [ 
	
	testBlock := aFullBlockClosure
]
