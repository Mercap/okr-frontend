Class {
	#name : #ObjectiveContextTest,
	#superclass : #HttpRequestTest,
	#category : #'Objective-Views-Tests'
}

{ #category : #Accessing }
ObjectiveContextTest >> objective [
	
	^(NeoJSONObject new)
	at: #keyresult put: 'Deploy Abbaco backend APIs';
	at: #weight put: 0.3;
	yourself. 
	

]

{ #category : #'as yet unclassified' }
ObjectiveContextTest >> objectivePostResponse [

	^'{
  	      "status" : 201,		
			"body" : "Created sarasa"
		}'
]

{ #category : #tests }
ObjectiveContextTest >> objectivesResponse [

	^'[{
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

{ #category : #tests }
ObjectiveContextTest >> testGetAllObjectives [

	| context objectives |

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectivesResponse ).

	objectives := context objectives.
	
	self assert: objectives size equals: 1.
	self assert: objectives first description equals: 'Ship Abbaco v2';
	assert: (objectives first at: #'key-results') size equals: 4
]

{ #category : #tests }
ObjectiveContextTest >> testPostObjective [

	| context objective postResponse |

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectivePostResponse ).
	
	objective := self objective.
	postResponse := context addObjective: objective.
	
	self assert: postResponse status equals: 201.
	self assert: postResponse body equals: 'Created sarasa'
]
