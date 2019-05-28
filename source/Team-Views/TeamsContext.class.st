Class {
	#name : #TeamsContext,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'parentContext'
	],
	#category : #'Team-Views'
}

{ #category : #'Instance Creation' }
TeamsContext class >> queryUsing: anHttpClient workingWith: aParentContext [

	^ self new initializeQueryUsing: anHttpClient workingWith: aParentContext
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
	^ 'localhost:9000'
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
		ifTrue: [ NeoJSONObject fromString: response contents ]
		ifFalse: [ HttpRequestDidNotSucceed signal ]
]

{ #category : #initialization }
TeamsContext >> initializeQueryUsing: anHttpClient workingWith: aParentContext [

	httpClient := anHttpClient.
	parentContext := aParentContext 
	


]

{ #category : #'external api actions' }
TeamsContext >> members [

	^ OrderedCollection
		with:
			( NeoJSONObject
				fromString:
					'{"name": "Pehuen",
	"lastname":"Gotelli",
	"email":"n.gotelli@gmail.com"}' )
]

{ #category : #'api actions' }
TeamsContext >> teamOfId: anID [

	| httpRequest response |

	httpRequest := HttpRequest
		get: self teamsPath
		configuredUsing: [ :request | request queryString: [ :builder | builder fieldNamed: #uuid pairedTo: anID ] ].
	
	response := httpRequest applyOn: httpClient.
	
	^ self handleOrSignalFor: response
]

{ #category : #'api actions' }
TeamsContext >> teams [

	| httpRequest response |

	httpRequest := HttpRequest get: self teamsPath.

	response := httpRequest applyOn: httpClient.
	
	^ self handleOrSignalFor: response
]

{ #category : #Accessing }
TeamsContext >> teamsPath [

	^ '<1s>/<2s>' expandMacrosWith: self basePath with: self domainPath
]

{ #category : #'api actions' }
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
