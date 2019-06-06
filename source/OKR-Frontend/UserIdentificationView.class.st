Class {
	#name : #UserIdentificationView,
	#superclass : #WAPainter,
	#instVars : [
		'context',
		'userPickView'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
UserIdentificationView class >> workingWith: aWorkingContext [

	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #initialization }
UserIdentificationView >> initializeUserPickView [

	userPickView := self componentSupplier
		singleSelectionListBoxDisplayingAtOnce: 5
		applying: [ :theList |  ].
	userPickView allowAnyOf: context availableUsers.
	userPickView onTrigger
		serializeIt;
		evaluate: [ context userIdentifiedAs: userPickView currentSelection ];
		render: context mainContentView
]

{ #category : #initialization }
UserIdentificationView >> initializeWorkingWith: aWorkingContext [

	context := aWorkingContext.
	self initializeUserPickView
]

{ #category : #rendering }
UserIdentificationView >> renderContentOn: aCanvas [

	aCanvas render: userPickView
]
