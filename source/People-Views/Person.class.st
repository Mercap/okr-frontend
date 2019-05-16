Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'lastName',
		'name',
		'email'
	],
	#category : #'People-Views'
}

{ #category : #'instance creation' }
Person class >> namedFirst: aName last: aLastname availableAt: anEmail [

	^ self new initializeNamedFirst: aName last: aLastname availableAt: anEmail
]

{ #category : #Accessing }
Person >> email [

	^ email
]

{ #category : #'initialization - private' }
Person >> initializeNamedFirst: aName last: aLastname availableAt: anEmail [

	name := aName.
	lastName := aLastname.
	email := anEmail
]

{ #category : #Accessing }
Person >> lastname [

	^ lastName
]

{ #category : #Accessing }
Person >> name [

	^ name
]
