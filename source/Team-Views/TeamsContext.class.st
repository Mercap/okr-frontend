Class {
	#name : #TeamsContext,
	#superclass : #Object,
	#instVars : [
		'httpClient'
	],
	#category : #'Team-Views'
}

{ #category : #'Instance Creation' }
TeamsContext class >> queryUsing: anHttpClient [

	^ self new initializeQueryUsing: anHttpClient
]

{ #category : #'api actions' }
TeamsContext >> addTeam: aTeam [

	| httpRequest response |

	httpRequest := HttpRequest
		post: ( '<1s>/<2s>' expandMacrosWith: self basePath with: self domainPath )
		configuredUsing: [ :request | request body contents: ( self entityFrom: aTeam ) ].
	response := httpRequest applyOn: httpClient.

	^ response isSuccess
		ifTrue: [ response contents ]
		ifFalse: [ HttpRequestDidNotSucceed signal ]
]

{ #category : #Accessing }
TeamsContext >> basePath [

	self flag: 'no hardcodear'.
	^ 'localhost'
]

{ #category : #Accessing }
TeamsContext >> domainPath [

	self flag: 'no hardcodear'.
	^ 'teams'
]

{ #category : #converting }
TeamsContext >> entityFrom: aTeam [

	| writer |

	writer := NeoJSONWriter on: String new writeStream.
	writer
		writeMap:
			( Dictionary new
				at: #name put: aTeam name;
				yourself ).
	aTeam members neoJsonOn: writer.
	^ writer
]

{ #category : #initialization }
TeamsContext >> initializeQueryUsing: anHttpClient [ 

	httpClient := anHttpClient
	


]
