Class {
	#name : #TeamContextTest,
	#superclass : #TestCase,
	#category : #'Team-Views-Tests'
}

{ #category : #'Test Support' }
TeamContextTest >> entityFrom: aTeam [

	| json dictionary |

	dictionary := Dictionary new
		at: #name put: aTeam name;
		at: #members put: aTeam members;
		yourself.
	aTeam id ifNil: [  ] ifNotNil: [ dictionary at: #id put: aTeam id ].
	json := NeoJSONWriter toString: dictionary.
	^ json
]

{ #category : #Mocking }
TeamContextTest >> httpMockClientAddTeam: aTeam [

	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: (self entityFrom: aTeam) ) )
]

{ #category : #Mocking }
TeamContextTest >> httpMockClientGetTeamById [

	| json |

	json := self teamByIdEntity .
	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: json ) )
]

{ #category : #Mocking }
TeamContextTest >> httpMockClientGetTeams [

	| json |

	json := self teamsEntity .
	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: json ) )
]

{ #category : #Mocking }
TeamContextTest >> httpMockClientUpdateTeam: aTeam [

	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: ( self entityFrom: aTeam ) ) )
]

{ #category : #Mocking }
TeamContextTest >> requestContext [

	^ MockRequestContext respondingBasepathWith: 'http://localhost:1710'
]

{ #category : #'Test Support' }
TeamContextTest >> teamByIdEntity [

	^ '{
      		"name": "I+D",
      		"members": [
    			{"name": "Nahuel"},
    			{"name": "Pablo"}
      		]
      }'
]

{ #category : #'Test Support' }
TeamContextTest >> teamEntity [

	^ '{"name":"I+D","members":[]}'
]

{ #category : #'Test Support' }
TeamContextTest >> teams [

	^ NeoJSONObject fromString: self teamsEntity
]

{ #category : #'Test Support' }
TeamContextTest >> teamsById [

	^ NeoJSONObject fromString: self teamByIdEntity
]

{ #category : #'Test Support' }
TeamContextTest >> teamsEntity [

	^ '{
  "items": [
    {
      "name": "I+D",
      "links": {
        "update": "https://DOMAIN/teams/1",
        "self": "https://DOMAIN/teams/1"
      }
    }
],
  "links": {
    "next": "https://DOMAIN/teams?limit=10&start=11",
    "self": "https://DOMAIN/teams",
    "last": "https://DOMAIN/teams?limit=10&start=371"
  }
}
'

]

{ #category : #Tests }
TeamContextTest >> testAddTeamRequest [

	| teamsContext simpleTeam response |

	simpleTeam := NeoJSONObject
		fromString:
			'
    {"name": "I+D",
     "members": []}'.
	teamsContext := TeamsContext queryUsing: ( self httpMockClientAddTeam: simpleTeam ).
	WACurrentRequestContext
		use: self requestContext
		during: [ response := teamsContext addTeam: simpleTeam ].

	self assert: response contents equals: simpleTeam
]

{ #category : #Tests }
TeamContextTest >> testGetTeamByIdRequest [

	| teamsContext response |

	teamsContext := TeamsContext queryUsing: self httpMockClientGetTeamById.
	WACurrentRequestContext use: self requestContext during: [ response := teamsContext teamOfId: 1 ].


	self assert: response contents equals: self teamsById
]

{ #category : #Tests }
TeamContextTest >> testGetTeamsRequest [

	| teamsContext response |

	teamsContext := TeamsContext queryUsing: self httpMockClientGetTeams.

	WACurrentRequestContext use: self requestContext during: [ response := teamsContext teams ].

	self assert: response contents equals: self teams
]

{ #category : #Tests }
TeamContextTest >> testUpdateTeamRequest [

	| teamsContext simpleTeam response |

	simpleTeam := NeoJSONObject
		fromString:
			'
    {
"id": 1,
"name": "I+D",
     "members": [
	{ "name": "Pehuén"},
	{ "name": "Pablo"}
	]}'.

	teamsContext := TeamsContext queryUsing: ( self httpMockClientUpdateTeam: simpleTeam ).

	WACurrentRequestContext
		use: self requestContext
		during: [ response := teamsContext updateTeam: simpleTeam ].


	self assert: response contents equals: simpleTeam
]
