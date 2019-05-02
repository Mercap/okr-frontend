Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'name',
		'lastName',
		'mail'
	],
	#category : #'People-Views'
}

{ #category : #'instance creation' }
Person class >> named: aName lastName: aLastName mail: aMail [ 
	
	^self new initializeNamed: aName lastName: aLastName mail: aMail
]

{ #category : #initialization }
Person >> initializeNamed: aName lastName: aLastName mail: aMail [

	name := aName.
	lastName := aLastName.
	mail := aMail
]
