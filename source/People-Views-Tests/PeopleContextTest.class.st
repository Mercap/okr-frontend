Class {
	#name : #PeopleContextTest,
	#superclass : #TestCase,
	#category : #'People-Views-Tests'
}

{ #category : #'JSON Response' }
PeopleContextTest >> deletePersonJSONResponse [
	
	^'[]'
]

{ #category : #'JSON Response' }
PeopleContextTest >> getPeopleJSONResponse [

	^ '{
  "items": [
    {
      "name": "nahuel",
      "lastname": "Gotelli",
      "email": "n.gotelli@gmail.com",
      "links": {
        "update": "https://DOMAIN/people/<1>",
        "self": "https://DOMAIN/people/<1>"
      }
    },
    {
      "name": "Ezequiel",
      "lastname": "Bálsamo",
      "email": "e.balsamo@mercapsoftware.com",
      "links": {
        "update": "https://DOMAIN/people/<2>",
        "self": "https://DOMAIN/people/<2>"
      }
    }
],
  "links": {
    "next": "https://DOMAIN/people?limit=10&start=11",
    "self": "https://DOMAIN/people",
    "last": "https://DOMAIN/people?limit=10&start=371"
  }
}'
]

{ #category : #'JSON Response' }
PeopleContextTest >> getPersonByIDJSONResponse [

	^ '{
	"name": "Pehuén",
	"lastname": "Gotelli",
	"email": "n.gotelli@gmail.com",
      "links": {
		"update": "https://DOMAIN/people/1",
		"self": "https://DOMAIN/people/1"
		}
}'
]

{ #category : #'test support' }
PeopleContextTest >> jsonFromString: aString [

	^NeoJSONObject fromString: aString
]

{ #category : #'test support' }
PeopleContextTest >> jsonStringRepresentationForPerson: aPerson [

	^ NeoJSONWriter
		toString:
			( Dictionary new
				at: 'name' put: aPerson name;
				at: 'lastname' put: aPerson lastname;
				at: 'email' put: aPerson email;
				yourself )
]

{ #category : #'JSON Response' }
PeopleContextTest >> peopleJSONResponse [

	^ '{
  "items": [
    {
      "name": "nahuel",
      "lastname": "Gotelli",
      "email": "n.gotelli@gmail.com",
      "links": {
        "update": "https://DOMAIN/people/<1>",
        "self": "https://DOMAIN/people/<1>"
      }
    },
    {
      "name": "Ezequiel",
      "lastname": "Bálsamo",
      "email": "e.balsamo@mercapsoftware.com",
      "links": {
        "update": "https://DOMAIN/people/<2>",
        "self": "https://DOMAIN/people/<2>"
      }
}'
]

{ #category : #'JSON Response' }
PeopleContextTest >> postPersonJSONResponse [

	^ '{
  "name": "Nahuel",
  "lastname": "Gotelli",
 "email": "n.gotelli@gmail.com",
  "id_RRHH": "15"
}'
]

{ #category : #'test support' }
PeopleContextTest >> responseWithText: aPeopleJsonText [

	^ ZnResponse ok: ( ZnEntity text: aPeopleJsonText )
]

{ #category : #tests }
PeopleContextTest >> testDeletePerson [

	| context client contextResponse expectedResponse |

	client := MockHttpClient responding: ( self responseWithText: self deletePersonJSONResponse ).
	context := PeopleContext queryUsing: client.

	contextResponse := context removePerson: '15'.
	expectedResponse := self jsonFromString: self deletePersonJSONResponse.

	self assert: contextResponse equals: expectedResponse
]

{ #category : #tests }
PeopleContextTest >> testGetPeople [

	| client context contextResponse expectedResponse |

	client := MockHttpClient responding: ( self responseWithText: self getPeopleJSONResponse ).
	context := PeopleContext queryUsing: client.

	contextResponse := context people.
	expectedResponse := ( self jsonFromString: self getPeopleJSONResponse ) at: #items.

	self assert: contextResponse equals: expectedResponse
]

{ #category : #tests }
PeopleContextTest >> testGetPersonByID [

	| client context contextResponse expectedResponse |

	client := MockHttpClient responding: ( self responseWithText: self getPersonByIDJSONResponse ).
	context := PeopleContext queryUsing: client.

	contextResponse := context personFilteredByID: 1.
	expectedResponse := self jsonFromString: self getPersonByIDJSONResponse.

	self assert: contextResponse equals: expectedResponse
]

{ #category : #tests }
PeopleContextTest >> testPostPerson [

	| person client context contextResponse expectedResponse |

	person := Person namedFirst: 'Ezequiel' last: 'Bálsamo' availableAt: 'e.balsamo@mercapsoftware.com'.
	client := MockHttpClient responding: ( self responseWithText: self postPersonJSONResponse ).
	context := PeopleContext queryUsing: client.

	contextResponse := context addPerson: person.
	expectedResponse := self jsonFromString: self postPersonJSONResponse.

	self assert: contextResponse equals: expectedResponse
]

{ #category : #tests }
PeopleContextTest >> testUpdatePerson [

	| person personAsJSONString context client contextResponse expectedResponse |

	person := Person namedFirst: 'Ezequiel' last: 'Bálsamo' availableAt: 'e.balsamo@mercapsoftware.com'.
	person id: 1.
	person name: 'Alexander'.

	personAsJSONString := self jsonStringRepresentationForPerson: person.

	client := MockHttpClient responding: ( self responseWithText: personAsJSONString ).
	context := PeopleContext queryUsing: client.

	contextResponse := context updatePerson: person.
	expectedResponse := self jsonFromString: personAsJSONString.
	self assert: contextResponse equals: expectedResponse
]
