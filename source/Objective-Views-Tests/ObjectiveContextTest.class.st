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
    "description": "Mejora de producto",
    "keyResults": [
        {
            "description": "Deploy Abbaco backend APIs",
            "weight": 0.7
        },
        {
            "description": "Improve coverage",
            "weight": 0.3
        }
    ],
    "links": {
        "self": "http://localhost:10000/objectives/e18a8435-5646-0d00-aa42-01880f0e4409"
    }
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
	^ '[
    {
        "description": "Ship Abbaco v3",
        "keyResults": [
            {
                "description": "Deploy Abbaco backend APIs",
                "weight": 0.3
            },
            {
                "description": "Deploy Abbaco frontend using APIs",
                "weight": 0.5
            }
        ],
        "links": {
            "self": "http://localhost:10000/objectives/e18a8435-5646-0d00-aa42-01880f0e4409"
        }
    }
]'
]

{ #category : #Accessing }
ObjectiveContextTest >> objectivesUnsuccessfulGetResponse [
	^ZnResponse notFound: 'sarasa'
]

{ #category : #Mocking }
ObjectiveContextTest >> requestContext [

	^ MockRequestContext respondingBasepathWith: 'http://localhost:1710'
]

{ #category : #Accessing }
ObjectiveContextTest >> successfulResponseContaining: aString [
	^ ZnResponse ok: (ZnStringEntity json: aString)
]

{ #category : #tests }
ObjectiveContextTest >> testGetAllObjectives [

	| context objectives |

	context := ObjectiveContext using: ( MockHttpClient responding: self objectivesGetResponse ).

	WACurrentRequestContext use: self requestContext during: [ objectives := context objectives ].

	self assert: objectives size equals: 1.
	self
		assert: objectives first description equals: 'Ship Abbaco v3';
		assert: objectives first keyResults size equals: 2
]

{ #category : #tests }
ObjectiveContextTest >> testPostObjective [

	| context|

	context := ObjectiveContext using: ( MockHttpClient responding: self objectivePostResponse ).

	context addKeyResultNamed: 'Deploy Abbaco backend APIs' weighing: 70.
	context addKeyResultNamed: 'Improve coverage' weighing: 30.

	self
		shouldnt: [ WACurrentRequestContext
				use: self requestContext
				during: [ context usingDefinedKeyResultsAddObjectiveNamed: 'Mejora de producto' ]
			]
		raise: HttpRequestDidNotSucceed
]

{ #category : #tests }
ObjectiveContextTest >> testUnsuccessfulGetAllObjectives [

	| context|

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectivesUnsuccessfulGetResponse ).

	self
		should:
			[ WACurrentRequestContext use: self requestContext during: [ context objectives ] ]
		raise: HttpRequestDidNotSucceed
		withMessageText: 'Error al consultar objetivos'
]

{ #category : #tests }
ObjectiveContextTest >> testUnsuccessfulPostObjective [

	| context|

	context := ObjectiveContext
		using: ( MockHttpClient responding: self objectiveUnsuccesfulPostResponse ).

	context addKeyResultNamed: 'Deploy Abbaco backend APIs' weighing: 70.
	context addKeyResultNamed: 'Improve coverage' weighing: 30.

	self
		should: [ WACurrentRequestContext
				use: self requestContext
				during: [ context usingDefinedKeyResultsAddObjectiveNamed: 'Mejora de producto' ]
			]
		raise: HttpRequestDidNotSucceed
		withMessageText: 'Error al agregar el objetivo'
]
