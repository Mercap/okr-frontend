Class {
	#name : #TeamContextTest,
	#superclass : #TestCase,
	#category : #'Team-Views-Tests'
}

{ #category : #tests }
TeamContextTest >> encodedFullName [

	^ NeoJSONWriter
		toString:
			(Dictionary new
				at: 'name' put: 'teamName'
				yourself)
]

{ #category : #mocking }
TeamContextTest >> entity: aZnStringEntity [ 
	
]

{ #category : #mocking }
TeamContextTest >> execute [
	
]

{ #category : #tests }
TeamContextTest >> fullNameVersion1dot0dot0MediaType [

	^ 'application/vnd.nap.full_name+json;version=1.0.0' asMIMEType 
]

{ #category : #mocking }
TeamContextTest >> method: aString [ 
	
]

{ #category : #mocking }
TeamContextTest >> response [
	| json |
	json := NeoJSONWriter
		toString:
			(Dictionary new
				at: 'response' put: 'OK';
				yourself).
	^ ZnResponse ok: (ZnStringEntity json: json)
]

{ #category : #tests }
TeamContextTest >> teamEntity [

	^ ZnEntity
		with: self encodedFullName
		type: self fullNameVersion1dot0dot0MediaType
]

{ #category : #tests }
TeamContextTest >> testAddTeamRequest [
	| httpRequest response |
	httpRequest := HttpRequest
		post: 'http://teamapi.org/teams'
		configuredUsing: [ :request | request body contents: self teamEntity ].
	response := httpRequest applyOn: self.
	self
		withJsonFromContentsIn: response
		do: [ :json | self assert: json response equals: 'OK' ]
]

{ #category : #mocking }
TeamContextTest >> url: aString [ 
	
]

{ #category : #tests }
TeamContextTest >> withJsonFromContentsIn: httpResponse do: aBlock [

	aBlock value: (NeoJSONObject fromString: httpResponse contents)
]
