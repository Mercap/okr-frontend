Class {
	#name : #ObjectiveContext,
	#superclass : #Object,
	#instVars : [
		'httpClient'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance creation' }
ObjectiveContext class >> using: aHttpClient [ 
	
	^self new initializeUsing: aHttpClient 
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

{ #category : #initialization }
ObjectiveContext >> initializeUsing: aHttpClient [ 
	
	httpClient := aHttpClient 
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
