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

{ #category : #initialization }
OKRFrontendApplicationContext >> basePath [

	^ 'http://localhost:10000'
]

{ #category : #accessing }
OKRFrontendApplicationContext >> contentView [

	^ application contentView
]

{ #category : #accessing }
OKRFrontendApplicationContext >> currenUser [

	^ application currentUser
]

{ #category : #accessing }
OKRFrontendApplicationContext >> httpClient [

	^ ZnClient new
]

{ #category : #initialization }
OKRFrontendApplicationContext >> initializeOn: anOKRFrontendApplication [

	application := anOKRFrontendApplication
]

{ #category : #workflow }
OKRFrontendApplicationContext >> logout [

	application logout
]

{ #category : #accessing }
OKRFrontendApplicationContext >> mainContentView [

	^ application contentView
]

{ #category : #'user identification' }
OKRFrontendApplicationContext >> userIdentifiedAs: aUser [

	application userIdentifiedAs: aUser
]
