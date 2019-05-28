Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'name',
		'email',
		'id',
		'lastname'
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

{ #category : #Accessing }
Person >> email: anEmail [

	email := anEmail
]

{ #category : #Accessing }
Person >> id [

	^ id
]

{ #category : #Accessing }
Person >> id: anID [

	id := anID
]

{ #category : #'initialization - private' }
Person >> initializeNamedFirst: aName last: aLastname availableAt: anEmail [

	name := aName.
	lastname := aLastname.
	email := anEmail
]

{ #category : #Accessing }
Person >> lastname [

	^ lastname
]

{ #category : #Accessing }
Person >> lastname: aLastname [

	lastname := aLastname
]

{ #category : #Accessing }
Person >> name [

	^ name
]

{ #category : #Accessing }
Person >> name: aName [

	name := aName
]
