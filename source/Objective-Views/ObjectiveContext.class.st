Class {
	#name : #ObjectiveContext,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'applicationContext'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance creation' }
ObjectiveContext class >> using: aHttpClient workingWith: anApplicationContext [
	
	^self new initializeUsing: aHttpClient workingWith: anApplicationContext
]

{ #category : #adding }
ObjectiveContext >> addObjective: anObjective [

	| request |
	request := HttpRequest
		post: self objectivesPath
		configuredUsing: [ :req | req body json: anObjective asString ].

	(request applyOn: httpClient) isSuccess
		ifFalse: [ Error signal: 'Error al agregar el objetivo' ]

]

{ #category : #'as yet unclassified' }
ObjectiveContext >> applicationContext [
	^ applicationContext
]

{ #category : #'as yet unclassified' }
ObjectiveContext >> createKeyResultsView [
	
	^AddKeyResultsWebView workingWith: self
]

{ #category : #initialization }
ObjectiveContext >> initializeUsing: aHttpClient workingWith: anApplicationContext [

	httpClient := aHttpClient.
	applicationContext := anApplicationContext
]

{ #category : #Accessing }
ObjectiveContext >> objectives [

	| request response |
	request := HttpRequest get: self objectivesPath.
	response := request applyOn: httpClient.
	^ response isSuccess
		ifTrue: [ self parse: response ]
		ifFalse: [ Error signal: 'Error al consultar objetivos' ]

]

{ #category : #accessing }
ObjectiveContext >> objectivesPath [
	
	^'http://okr-api.mercap.net/objectives' asUrl
]

{ #category : #parsing }
ObjectiveContext >> parse: aResponse [

	^NeoJSONObject fromString: aResponse contents

]
