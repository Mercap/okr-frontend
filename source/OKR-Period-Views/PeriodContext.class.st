Class {
	#name : #PeriodContext,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'applicationContext'
	],
	#category : #'OKR-Period-Views'
}

{ #category : #'as yet unclassified' }
PeriodContext class >> using: anHttpClient [ 
	^self new initializeUsing: anHttpClient 
]

{ #category : #accessing }
PeriodContext >> addPeriod: aPeriod [
	| request |
	request := HttpRequest
		post: self periodsPath
		configuredUsing: [ :req | req body json: aPeriod asString ].
	^ (request applyOn: httpClient) isSuccess
		ifTrue: [ aPeriod ]
		ifFalse: [ Error signal: 'Error al agregar el periodo' ]
]

{ #category : #initalization }
PeriodContext >> initializeUsing: anHttpClient [ 

	httpClient := anHttpClient
]

{ #category : #parsing }
PeriodContext >> parse: aResponse [
	^ NeoJSONObject fromString: aResponse contents
]

{ #category : #accessing }
PeriodContext >> periods [
	| request response |
	request := HttpRequest get: self periodsPath.
	response := request applyOn: httpClient.
	^ response isSuccess
		ifTrue: [ self parse: response ]
		ifFalse: [ Error signal: 'Error al consultar periodos' ]

]

{ #category : #accessing }
PeriodContext >> periodsPath [
	^ 'http://okr-api.mercap.net/periods' asUrl
]

{ #category : #accessing }
PeriodContext >> removePeriod: aPeriod [
	| request |
	request := HttpRequest
		performing: #DELETE
		on: aPeriod link asUrl
		configuredUsing: [ :req |  ].
	^ (request applyOn: httpClient) isSuccess
		ifTrue: [ aPeriod ]
		ifFalse: [ Error signal: 'Error al borrar el periodo' ]
]
