Class {
	#name : #PeopleContext,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'People-Views'
}

{ #category : #'instance creation' }
PeopleContext class >> queryUsing: aClient [

	^ self new initializeQueryUsing: aClient
]

{ #category : #'API actions' }
PeopleContext >> addPerson: aPerson [

	^ self post: self peopleUrl containing: aPerson
]

{ #category : #accessing }
PeopleContext >> baseUrl [
	
	^'http://example.com'
]

{ #category : #'API actions' }
PeopleContext >> handlingErrorsIn: aHttpRequest whenSuccessfulDo: aBlock [

	| response |

	response := aHttpRequest applyOn: client.

	^response isSuccess
		ifTrue: [ aBlock value: response ]
		ifFalse: [ HttpRequestDidNotSucceed signal: 'hubo un problema con la conexión' ]
]

{ #category : #'initialization - private' }
PeopleContext >> initializeQueryUsing: aClient [

	client := aClient
]

{ #category : #accessing }
PeopleContext >> jsonFor: aPerson [

	^ NeoJSONWriter
		toString:
			( Dictionary new
				at: 'name' put: aPerson name;
				at: 'lastname' put: aPerson lastname;
				at: 'email' put: aPerson email;
				yourself )
]

{ #category : #'API actions' }
PeopleContext >> people [

	| httpRequest |

	httpRequest := HttpRequest get: self peopleUrl.

	^ self
		handlingErrorsIn: httpRequest
		whenSuccessfulDo: [ :response | NeoJSONObject fromString: response contents ]
]

{ #category : #accessing }
PeopleContext >> peopleEndpoint [
	
	^'people'
]

{ #category : #accessing }
PeopleContext >> peopleUrl [
	
	^'<1s>/<2s>' expandMacrosWith: self baseUrl with: self peopleEndpoint
]

{ #category : #'API actions' }
PeopleContext >> personFilteredByID: anID [

	| httpRequest |

	httpRequest := HttpRequest
		get: self peopleUrl
		configuredUsing: [ :request | request queryString: [ :queryString | queryString fieldNamed: #uuid pairedTo: anID ] ].

	^ self
		handlingErrorsIn: httpRequest
		whenSuccessfulDo: [ :response | NeoJSONObject fromString: response contents ]
]

{ #category : #'API actions' }
PeopleContext >> post: anUrl containing: aPerson [

	| httpRequest |

	httpRequest := HttpRequest
		post: self peopleUrl
		configuredUsing: [ :request | request body json: ( self jsonFor: aPerson ) ].

	^ self
		handlingErrorsIn: httpRequest
		whenSuccessfulDo: [ :response | NeoJSONObject fromString: response contents ]
]

{ #category : #'API actions' }
PeopleContext >> updatePerson: aPerson [

	| httpRequest |

	httpRequest := HttpRequest
		performing: #PUT
		on: self peopleUrl
		configuredUsing: [ :request | 
			request queryString: [ :queryString | queryString fieldNamed: #uuid pairedTo: aPerson id ].
			request body json: ( self jsonFor: aPerson )
			].

	^ self
		handlingErrorsIn: httpRequest
		whenSuccessfulDo: [ :response | NeoJSONObject fromString: response contents ]
]
