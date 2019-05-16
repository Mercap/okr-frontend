Class {
	#name : #Team,
	#superclass : #Object,
	#instVars : [
		'name',
		'members'
	],
	#category : #'Team-Views'
}

{ #category : #'Instance Creation' }
Team class >> named: aName [

	^ self new initializeNamed: aName
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
