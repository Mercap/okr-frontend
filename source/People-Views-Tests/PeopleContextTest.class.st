Class {
	#name : #PeopleContextTest,
	#superclass : #TestCase,
	#category : #'People-Views-Tests'
}

{ #category : #'test support' }
PeopleContextTest >> getPeopleByIDJSONResponse [

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
PeopleContextTest >> getPeopleJSONResponse [

	^ '{
  "items": [
    {
      "name": "nahuel",
      "lastname": "Gotelli",
      "email": "n.gotelli@gmail.com",
      "links": {
        "update": "https://DOMAIN/people/<uuid>",
        "self": "https://DOMAIN/people/<uuid>"
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

{ #category : #'test support' }
PeopleContextTest >> jsonFor: aPerson [

	^ NeoJSONWriter
		toString:
			( Dictionary new
				at: 'name' put: aPerson name;
				at: 'lastname' put: aPerson lastname;
				at: 'email' put: aPerson email;
				yourself )
]

{ #category : #accessing }
PeopleContextTest >> person [

	^ Person namedFirst: 'Ezequiel' last: 'Bálsamo' availableAt: 'e.balsamo@mercapsoftware.com'
]

{ #category : #accessing }
PeopleContextTest >> postPeopleJSONResponse [

	^ '{
  "name": "Nahuel",
  "lastname": "Gotelli",
 "email": "n.gotelli@gmail.com",
  "id_RRHH": "15"
}'
]

{ #category : #tests }
PeopleContextTest >> responseWithText: aPeopleJsonText [

	^ ZnResponse ok: ( ZnEntity text: aPeopleJsonText )
]

{ #category : #tests }
PeopleContextTest >> testGetPeople [

	| context client |

	client := MockHttpClient responding: ( self responseWithText: self getPeopleJSONResponse ).
	context := PeopleContext queryUsing: client.
	self assert: context people equals: ( NeoJSONObject fromString: self getPeopleJSONResponse )
]

{ #category : #tests }
PeopleContextTest >> testGetPersonByID [

	| context client person |

	client := MockHttpClient responding: ( self responseWithText: self getPeopleByIDJSONResponse ).
	context := PeopleContext queryUsing: client.
	person := context personFilteredByID: 1.
	self assert: person equals: ( NeoJSONObject fromString: self getPeopleByIDJSONResponse )
]

{ #category : #tests }
PeopleContextTest >> testPostPerson [

	| context client |

	client := MockHttpClient responding: ( self responseWithText: self postPeopleJSONResponse ).
	context := PeopleContext queryUsing: client.
	self
		assert: ( context addPerson: self person )
		equals: ( NeoJSONObject fromString: self postPeopleJSONResponse )
]

{ #category : #tests }
PeopleContextTest >> testUpdatePerson [

	| person context client |

	person := self person.
	person id: 1.

	person name: 'Alexander'.

	client := MockHttpClient responding: ( self responseWithText: ( self jsonFor: person ) ).
	context := PeopleContext queryUsing: client.
	self
		assert: ( context updatePerson: person )
		equals: ( NeoJSONObject fromString: ( self jsonFor: person ) )
]
