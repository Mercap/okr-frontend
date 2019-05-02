Class {
	#name : #OKRFrontendApplicationContext,
	#superclass : #Object,
	#instVars : [
		'application'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
OKRFrontendApplicationContext class >> on: anOKRFrontendApplication [
	^ self new initializeOn: anOKRFrontendApplication
]

{ #category : #initialization }
OKRFrontendApplicationContext >> initializeOn: anOKRFrontendApplication [
	application := anOKRFrontendApplication
]
