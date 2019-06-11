Class {
	#name : #Team,
	#superclass : #Object,
	#instVars : [
		'name',
		'members',
		'id'
	],
	#category : #'Team-Views'
}

{ #category : #'Instance Creation' }
Team class >> named: aName [

	^ self new initializeNamed: aName
]

{ #category : #Management }
Team >> addMember: aPerson [

	members add: aPerson
]

{ #category : #Accessing }
Team >> id [
	^id
]

{ #category : #Accessing }
Team >> id: anID [

	id := anID
]

{ #category : #initialization }
Team >> initializeNamed: aName [

	name := aName.
	members := OrderedCollection new. 
]

{ #category : #Accessing }
Team >> members [

	^ members
]

{ #category : #Accessing }
Team >> name [

	^ name
]
