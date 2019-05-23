Class {
	#name : #TeamContextTest,
	#superclass : #TestCase,
	#category : #'Team-Views-Tests'
}

{ #category : #'Test Support' }
TeamContextTest >> entityFrom: aTeam [

	| json |

	json := NeoJSONWriter
		toString:
			( Dictionary new
				at: #name put: aTeam name;
				at: #members put: aTeam members;
				yourself ).
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
TeamContextTest >> teamByIdEntity [

	^ '{
    "detail": {
      "name": "I+D",
      "members": [
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

{ #category : #Mocking }
TeamContextTest >> teamEntity [

	^ '{"name":"I+D","members":[]}'
]

{ #category : #Mocking }
TeamContextTest >> teamWithMembersEntity [

	^ '{"name":"I+D","members":[{"name":"Pehuén"},{"name":"Pablo"}]}'
]

{ #category : #Mocking }
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

	| teamsContext simpleTeam  response |

	
	
	simpleTeam  := Team named: 'I+D'.
	teamsContext := TeamsContext queryUsing: (self httpMockClientAddTeam: simpleTeam ).
	response := teamsContext addTeam: simpleTeam .
	self
		assert: response contents equals: self teamEntity
]

{ #category : #Tests }
TeamContextTest >> testGetTeamByIdRequest [

	| teamsContext response |

	teamsContext := TeamsContext queryUsing: self httpMockClientGetTeamById.
	response := teamsContext teamOfId: 1.

	self assert: response contents equals: self teamByIdEntity
]

{ #category : #Tests }
TeamContextTest >> testGetTeamsRequest [

	| teamsContext response |

	teamsContext := TeamsContext queryUsing: self httpMockClientGetTeams.
	response := teamsContext teams.
	
	self assert: response contents equals: self teamsEntity
]

{ #category : #Tests }
TeamContextTest >> testUpdateTeamRequest [

	| teamsContext simpleTeam response firstMockedPerson secondMockedPerson |

	simpleTeam := Team named: 'I+D'.
	simpleTeam id: 1.
	
	firstMockedPerson := NeoJSONObject fromString: '{ "name": "Pehuén"}'.
	secondMockedPerson := NeoJSONObject fromString: '{ "name": "Pablo"}'.
	simpleTeam
		addMember: firstMockedPerson;
		addMember: secondMockedPerson.
	
	teamsContext := TeamsContext queryUsing: ( self httpMockClientUpdateTeam: simpleTeam ).
	response := teamsContext updateTeam: simpleTeam.
	
	self assert: response contents equals: self teamWithMembersEntity
]
