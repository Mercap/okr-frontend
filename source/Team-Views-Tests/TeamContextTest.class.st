Class {
	#name : #TeamContextTest,
	#superclass : #TestCase,
	#category : #'Team-Views-Tests'
}

{ #category : #mocking }
TeamContextTest >> httpMockClientAddTeam [

	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: self teamEntity ) )
]

{ #category : #mocking }
TeamContextTest >> httpMockClientGetTeamById [

	| json |

	json := self teamByIdEntity .
	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: json ) )
]

{ #category : #mocking }
TeamContextTest >> httpMockClientGetTeams [

	| json |

	json := self teamsEntity .
	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: json ) )
]

{ #category : #mocking }
TeamContextTest >> httpMockClientGetTeamsById [

	| json |

	json := self teamByIdEntity .
	^ MockHttpClient responding: ( ZnResponse ok: ( ZnStringEntity json: json ) )
]

{ #category : #mocking }
TeamContextTest >> teamByIdEntity [

	^ '{
    “detail”: {
      "name": "I+D",
      “members”: [
    {
    "name": "Nahuel",
          "links": {
                "self": "https://DOMAIN/people/1"
}
    },
    {
    "name": "Pablo",
          "links": {
                "self": "https://DOMAIN/people/1"
}
    }
      ]
      "links": {
        "update": "https://DOMAIN/teams/1",
        "self": "https://DOMAIN/teams/1"
      }
    }
}
'
]

{ #category : #mocking }
TeamContextTest >> teamEntity [

	^ '{
  "name": "I+D",
  "members": []
}'
]

{ #category : #mocking }
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

{ #category : #tests }
TeamContextTest >> testAddTeamRequest [

	| httpRequest response |

	httpRequest := HttpRequest
		post: 'localhost/teams'
		configuredUsing: [ :request | request body contents: self teamEntity ].
	response := httpRequest applyOn: self httpMockClientAddTeam.
	self
		assert: response isSuccess;
		assert: response contents equals: self teamEntity
]

{ #category : #tests }
TeamContextTest >> testGetTeamByIdRequest [

	| httpRequest response |

	httpRequest := HttpRequest get: 'localhost/teams'
	configuredUsing: [:request | request queryString: [ :builder | builder fieldNamed: #uuid pairedTo: 1 ]  ].
	response := httpRequest applyOn: self httpMockClientGetTeam.

	self
		assert: response isSuccess;
		assert: response contents equals: self teamByIdEntity 
]

{ #category : #tests }
TeamContextTest >> testGetTeamsRequest [

	| httpRequest response |

	httpRequest := HttpRequest get: 'localhost/teams'.
	response := httpRequest applyOn: self httpMockClientGetTeams.

	self
		assert: response isSuccess;
		assert: response contents equals: self teamsEntity
]