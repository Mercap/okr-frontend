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

{ #category : #accessing }
OKRFrontendApplicationContext >> availableUsers [
	^ #(pedro mariano)
]

{ #category : #accessing }
OKRFrontendApplicationContext >> contentView [
	^application contentView
]

{ #category : #accessing }
OKRFrontendApplicationContext >> currenUser [
	^application currentUser
]

{ #category : #initialization }
OKRFrontendApplicationContext >> initializeOn: anOKRFrontendApplication [
	application := anOKRFrontendApplication
]

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> renderObjectivesView [

	application
		switchContentViewTo:
			(ObjectivesWebView
				workingWith: (ObjectivesWebViewContext within: self))
]

{ #category : #'user identification' }
OKRFrontendApplicationContext >> userIdentifiedAs: aUser [ 
	application userIdentifiedAs: aUser
]
