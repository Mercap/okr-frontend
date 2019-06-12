Class {
	#name : #ObjectiveContext,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'keyResults'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance creation' }
ObjectiveContext class >> using: aHttpClient [

	^ self new initializeUsing: aHttpClient
]

{ #category : #computing }
ObjectiveContext >> addKeyResultNamed: aString weighing: aFloat [

	keyResults add: ( self jsonObjectForKeyResultNamed: aString weighing: aFloat )
]

{ #category : #Accessing }
ObjectiveContext >> basePath [

	^ self session applicationContext basePath
]

{ #category : #computing }
ObjectiveContext >> createKeyResultsView [

	^AddKeyResultsWebView workingWith: self
]

{ #category : #Accessing }
ObjectiveContext >> domainPath [

	^ 'objetives'
]

{ #category : #initialization }
ObjectiveContext >> initializeUsing: aHttpClient [

	httpClient := aHttpClient.
	keyResults := OrderedCollection new
]

{ #category : #Accessing }
ObjectiveContext >> jsonForObjectiveNamed: aString [

	^ NeoJSONObject new
		at: #description put: aString;
		at: #keyResults put: keyResults;
		yourself
]

{ #category : #Accessing }
ObjectiveContext >> jsonObjectForKeyResultNamed: aString weighing: aFloat [

	^ NeoJSONObject new
		at: #description put: aString;
		at: #weight put: aFloat;
		yourself
]

{ #category : #Accessing }
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

{ #category : #Accessing }
ObjectiveContext >> objectivesPath [

	^('<1s>/<2s>' expandMacrosWith: self basePath with: self domainPath) asUrl
]

{ #category : #parsing }
ObjectiveContext >> parse: aResponse [

	^NeoJSONObject fromString: aResponse contents

]

{ #category : #Accessing }
ObjectiveContext >> requestContext [

	"Answer the current WARequestContext instance."

	^ WACurrentRequestContext value
]

{ #category : #Accessing }
ObjectiveContext >> session [

	^ self requestContext session
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
