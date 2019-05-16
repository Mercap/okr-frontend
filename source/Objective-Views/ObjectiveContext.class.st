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

{ #category : #initialization }
ObjectiveContext >> initializeUsing: aHttpClient [ 
	
	httpClient := aHttpClient 
]

{ #category : #Accessing }
ObjectiveContext >> objectives [

	| request |
	request := HttpRequest get: self objectivesPath.
	^self parse: (request applyOn: httpClient) 
]

{ #category : #accessing }
ObjectiveContext >> objectivesPath [
	
	^'http://okr-api.mercap.net/objectives' asUrl
]

{ #category : #parsing }
ObjectiveContext >> parse: aJson [

	^NeoJSONObject fromString: aJson
]
