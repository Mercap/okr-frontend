Class {
	#name : #PeopleContextTest,
	#superclass : #TestCase,
	#category : #'People-Views-Tests'
}

{ #category : #'test support' }
PeopleContextTest >> deletePersonJSONText [
	
	^'[]'
]

{ #category : #'test support' }
PeopleContextTest >> getPeopleJSONText [

	^ '{
  "items": [
    {
      "name": "nahuel",
      "lastname": "Gotelli",
      "email": "n.gotelli@gmail.com",
      "links": {
        "update": "https://DOMAIN/people/15",
        "self": "https://DOMAIN/people/15"
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

{ #category : #accessing }
PeopleContextTest >> person [

	^ Person namedFirst: 'Nahuel' last: 'Gotelli' availableAt: 'n.gotelli@gmail.com'
]

{ #category : #accessing }
PeopleContextTest >> postPersonJSONText [

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
PeopleContextTest >> testDeletePerson [

	| context client |

	client := MockHttpClient responding: ( self responseWithText: self deletePersonJSONText ).
	context := PeopleContext queryUsing: client.
	self
		assert: ( context removePerson: '15' )
		equals: ( NeoJSONObject fromString: self deletePersonJSONText )
]

{ #category : #tests }
PeopleContextTest >> testGetPeople [

	| context client |

	client := MockHttpClient responding: ( self responseWithText: self getPeopleJSONText ).
	context := PeopleContext queryUsing: client.
	self assert: context people equals: ( NeoJSONObject fromString: self getPeopleJSONText )
]

{ #category : #tests }
PeopleContextTest >> testPostPerson [

	| context client |

	client := MockHttpClient responding: ( self responseWithText: self postPersonJSONText ).
	context := PeopleContext queryUsing: client.
	self
		assert: ( context addPerson: self person )
		equals: ( NeoJSONObject fromString: self postPersonJSONText )
]
