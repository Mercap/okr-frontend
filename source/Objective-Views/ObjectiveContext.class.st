Class {
	#name : #ObjectiveContext,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'applicationContext',
		'keyResults'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance creation' }
ObjectiveContext class >> using: aHttpClient workingWith: anApplicationContext [
	
	^self new initializeUsing: aHttpClient workingWith: anApplicationContext
]

{ #category : #computing }
ObjectiveContext >> addKeyResultNamed: aString weighing: aFloat [

	keyResults add: ( self jsonObjectForKeyResultNamed: aString weighing: aFloat )
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
	applicationContext := anApplicationContext.
	keyResults := OrderedCollection new
]

{ #category : #accessing }
ObjectiveContext >> jsonForObjectiveNamed: aString [

	^ NeoJSONObject new
		at: #description put: aString;
		at: #keyResults put: keyResults;
		yourself
]

{ #category : #accessing }
ObjectiveContext >> jsonObjectForKeyResultNamed: aString weighing: aFloat [

	^ NeoJSONObject new
		at: #description put: aString;
		at: #weight put: aFloat;
		yourself
]

{ #category : #accesing }
ObjectiveContext >> keyResults [

	^ keyResults
]

{ #category : #Accessing }
ObjectiveContext >> objectives [

	| request response |
	request := HttpRequest get: self objectivesPath.
	response := request applyOn: httpClient.
	^ response isSuccess
		ifTrue: [ self parse: response ]
		ifFalse: [ HttpRequestDidNotSucceed signal: 'Error al consultar objetivos' ]

]

{ #category : #accessing }
ObjectiveContext >> objectivesPath [
	
	^(self applicationContext basePath,'/objectives') asUrl
]

{ #category : #parsing }
ObjectiveContext >> parse: aResponse [

	^NeoJSONObject fromString: aResponse contents

]

{ #category : #computing }
ObjectiveContext >> usingDefinedKeyResultsAddObjectiveNamed: aString [

	| request |

	request := HttpRequest
		post: self objectivesPath
		configuredUsing: [ :req | 
			( req body json: ( self jsonForObjectiveNamed: aString ) )
				+ ( req headers setContentTypeTo: 'application/vnd.mercap.objective+json' )
			].

	( request applyOn: httpClient ) isSuccess
		ifFalse: [ HttpRequestDidNotSucceed signal: 'Error al agregar el objetivo' ]
]
