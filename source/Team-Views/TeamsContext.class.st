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

	^ self session applicationContext basePath
]

{ #category : #Accessing }
TeamsContext >> domainPath [

	self flag: 'no hardcodear'.
	^ 'teams'
]

{ #category : #converting }
TeamsContext >> entityFrom: aTeam [

	| json |

	json := NeoJSONWriter
		toString:
			( Dictionary new
				at: #name put: aTeam name;
				at: #members put: aTeam members;
				yourself ).
	^ ZnStringEntity json: json
]

{ #category : #'api actions' }
TeamsContext >> handleOrSignalFor: response [

	^ response isSuccess
		ifTrue: [ NeoJSONObject fromString: response contents  ]
		ifFalse: [ HttpRequestDidNotSucceed signal ]
]

{ #category : #initialization }
TeamsContext >> initializeQueryUsing: anHttpClient [

	httpClient := anHttpClient
	


]

{ #category : #'external api actions' }
TeamsContext >> members [

	| httpRequest response |

	self flag: 'Esto va a cambiar despues, pero por ahora se necesita asi'.
	httpRequest := HttpRequest get: self membersPath.

	response := httpRequest applyOn: httpClient.

	^ self handleOrSignalFor: response
]

{ #category : #Accessing }
TeamsContext >> membersPath [

	^ '<1s>/<2s>' expandMacrosWith: self basePath with: 'members'
]

{ #category : #'api actions' }
TeamsContext >> removeTeam: aTeam [

	HttpRequestDidNotSucceed signal: 'Borrado de equipo no definido en la API'
]

{ #category : #Accessing }
TeamsContext >> requestContext [

	"Answer the current WARequestContext instance."

	^ WACurrentRequestContext value
]

{ #category : #Accessing }
TeamsContext >> session [

	^ self requestContext session
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
