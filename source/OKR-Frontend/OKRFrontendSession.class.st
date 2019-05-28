Class {
	#name : #OKRFrontendSession,
	#superclass : #WillowSession,
	#instVars : [
		'application'
	],
	#category : #'OKR-Frontend'
}

{ #category : #Controlling }
OKRFrontendSession >> applicationContext [ 

	^ application
]

{ #category : #Controlling }
OKRFrontendSession >> startUpApplicationContextFor: aWillowApplication [

	super startUpApplicationContextFor: aWillowApplication.
	application := aWillowApplication
]
