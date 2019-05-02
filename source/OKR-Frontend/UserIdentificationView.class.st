Class {
	#name : #UserIdentificationView,
	#superclass : #WAPainter,
	#instVars : [
		'context'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
UserIdentificationView class >> workingWith: aWorkingContext [
	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #initialization }
UserIdentificationView >> initializeWorkingWith: aWorkingContext [
	context := aWorkingContext
]

{ #category : #rendering }
UserIdentificationView >> renderContentOn: aCanvas [ 
	aCanvas render: 'Hola, quien sos?'.
	self componentSupplier halt: 'aca habria que crear un boton que identifique a un usuario y al clickear pretendemos que se le envie a context userIdentifiedAs: theUser'
]
