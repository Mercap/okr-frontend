Class {
	#name : #ObjectiveContextTest,
	#superclass : #TestCase,
	#category : #'Objective-Views-Tests'
}

{ #category : #Accessing }
ObjectiveContextTest >> objective [
	
	^(NeoJSONObject new)
	at: #keyresult put: 'Deploy Abbaco backend APIs';
	at: #weight put: 0.3;
	yourself. 
	

]

{ #category : #Accessing }
ObjectiveContextTest >> objectivePostResponse [
	^ self successfulResponseContaining: self objectivePostResponseJson
]

{ #category : #Accessing }
ObjectiveContextTest >> objectivePostResponseJson [
	^ '{
  	  "status" : 201,		
			"body" : "Created sarasa"
		}'
]

{ #category : #Accessing }
ObjectiveContextTest >> objectiveUnsuccesfulPostResponse [
	^ZnResponse notFound: 'sarasa'
]

{ #category : #Accessing }
ObjectiveContextTest >> objectivesGetResponse [
	^ self successfulResponseContaining: self objectivesGetResponseJson
]

{ #category : #Accessing }
ObjectiveContextTest >> objectivesGetResponseJson [
	^ '[{
  "description": "Ship Abbaco v2",
  "key-results": [
    {
      "keyresult": "KR1",
      "description": "Deploy Abbaco backend APIs",
      "weight": 0.3
    },{
      "keyresult": "KR2",
      "description": "Deploy Abbaco frontend using APIs",
      "weight": 0.3
    },{
      "keyresult": "KR3",
      "description": "Migrate Abbaco backend APIs to GemStone/64",
      "weight": 0.2
    },{
      "keyresult": "KR4",
      "description": "Migrate Abbaco frontend to Pharo",
      "weight": 0.2
    }
  ]
}
]'
]

{ #category : #Accessing }
ObjectiveContextTest >> objectivesUnsuccessfulGetResponse [
	^ZnResponse notFound: 'sarasa'
]

{ #category : #Accessing }
ObjectiveContextTest >> successfulResponseContaining: aString [
	^ ZnResponse ok: (ZnStringEntity json: aString)
]

{ #category : #tests }
ObjectiveContextTest >> testGetAllObjectives [

	| context objectives |

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectivesGetResponse ) workingWith: (OKRFrontendApplicationContext on: OKRFrontendApplication).

	objectives := context objectives.
	
	self assert: objectives size equals: 1.
	self assert: objectives first description equals: 'Ship Abbaco v2';
	assert: (objectives first at: #'key-results') size equals: 4
]

{ #category : #tests }
ObjectiveContextTest >> testPostObjective [

	| context objective postResponse |

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectivePostResponse ) workingWith: (OKRFrontendApplicationContext on: OKRFrontendApplication).
	
	objective := self objective.

	self shouldnt: [context addObjective: objective] raise: Error
]

{ #category : #tests }
ObjectiveContextTest >> testUnsuccessfulGetAllObjectives [

	| context objectives |

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectivesUnsuccessfulGetResponse ) workingWith: (OKRFrontendApplicationContext on: OKRFrontendApplication).

	self should: [context objectives] raise: Error withMessageText: 'Error al consultar objetivos'
]

{ #category : #tests }
ObjectiveContextTest >> testUnsuccessfulPostObjective [
	| context objective postResponse |
	context := ObjectiveContext
		using: (MockHttpClient responding: self objectiveUnsuccesfulPostResponse) workingWith: (OKRFrontendApplicationContext on: OKRFrontendApplication).
	objective := self objective.
	self
		should: [ context addObjective: objective ]
		raise: Error
		withMessageText: 'Error al agregar el objetivo'.

]
