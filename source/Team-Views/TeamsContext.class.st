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
		post: self teamsPath
		configuredUsing: [ :request | request body contents: ( self entityFrom: aTeam ) ].
	
	response := httpRequest applyOn: httpClient.

	^ self handleOrSignalFor: response
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

{ #category : #'api actions' }
TeamsContext >> handleOrSignalFor: response [

	^ response isSuccess
		ifTrue: [ response contents ]
		ifFalse: [ HttpRequestDidNotSucceed signal ]
]

{ #category : #initialization }
TeamsContext >> initializeQueryUsing: anHttpClient [ 

	httpClient := anHttpClient
	


]

{ #category : #API }
TeamsContext >> teamOfId: anID [

	| httpRequest response |

	httpRequest := HttpRequest
		get: self teamsPath
		configuredUsing: [ :request | request queryString: [ :builder | builder fieldNamed: #uuid pairedTo: anID ] ].
	
	response := httpRequest applyOn: httpClient.
	
	^ self handleOrSignalFor: response
]

{ #category : #API }
TeamsContext >> teams [

	| httpRequest response |

	httpRequest := HttpRequest get: self teamsPath.

	response := httpRequest applyOn: httpClient.
	
	^ self handleOrSignalFor: response
]

{ #category : #'api actions' }
TeamsContext >> teamsPath [

	^ '<1s>/<2s>' expandMacrosWith: self basePath with: self domainPath
]

{ #category : #API }
TeamsContext >> updateTeam: aTeam [

	| httpRequest response |

	httpRequest := HttpRequest
		performing: #PUT
		on: self teamsPath
		configuredUsing: [ :request | 
			request queryString: [ :builder | builder fieldNamed: #uuid pairedTo: aTeam id ].
			request body contents: ( self entityFrom: aTeam )
			].
		
	response := httpRequest applyOn: httpClient.
	
	^ self handleOrSignalFor: response
]
