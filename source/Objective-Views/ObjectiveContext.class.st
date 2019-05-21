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
	^ NeoJSONObject
		fromString:
			'[
   {
      "description":"Mejora de Producto",
      "key-results":[
         {
            "keyresult":1,
            "description":"Modularizar Siopel",
            "weight":0.4
         },
         {
            "keyresult":2,
            "description":"Llevar Unitrade al Core",
            "weight":0.4
         },
         {
            "keyresult":3,
            "description":"Hacer que pasen todos los tests",
            "weight":0.2
         }
      ]
   },
   {
      "description":"Satisfaccion del Cliente",
      "key-results":[
         {
            "keyresult":4,
            "description":"Documentacion",
            "weight":0.7
         },
         {
            "keyresult":5,
            "description":"Entregas en fecha",
            "weight":0.3
         }
      ]
   }
]'
]

{ #category : #accessing }
ObjectiveContext >> objectivesPath [
	
	^'http://okr-api.mercap.net/objectives' asUrl
]

{ #category : #parsing }
ObjectiveContext >> parse: aResponse [

	^NeoJSONObject fromString: aResponse contents
]
