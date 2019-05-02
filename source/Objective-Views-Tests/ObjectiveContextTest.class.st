Class {
	#name : #ObjectiveContextTest,
	#superclass : #HttpRequestTest,
	#category : #'Objective-Views-Tests'
}

{ #category : #tests }
ObjectiveContextTest >> objectivesResponse [

	^'[{
  "description": "Ship Abbaco v2",
  "key-results": [
    {
      "keyresult": <uuid>,
      "description": "Deploy Abbaco backend APIs",
      "weight": 0.3
    },{
      "keyresult": <uuid>,
      "description": "Deploy Abbaco frontend using APIs",
      "weight": 0.3
    },{
      "keyresult": <uuid>,
      "description": "Migrate Abbaco backend APIs to GemStone/64",
      "weight": 0.2
    },{
      "keyresult": <uuid>,
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
	assert: objectives first keyResults size equals: 4
]
