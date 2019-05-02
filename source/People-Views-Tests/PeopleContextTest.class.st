Class {
	#name : #PeopleContextTest,
	#superclass : #TestCase,
	#category : #'People-Views-Tests'
}

{ #category : #accesing }
PeopleContextTest >> people [

	^ Person named: 'Pepe' lastName: 'Gonzales' mail: 'pepe@test.com'
]

{ #category : #'test support' }
PeopleContextTest >> peopleApiResponse [

	^ '[{
	name: "Pepe",
	lastName: "Gonzalez",
	mail: "pepe@test.com"
}]'
]

{ #category : #tests }
PeopleContextTest >> testQueryPeople [

	| context testClient |

	testClient := TestHttpClient new addExpectedResponse: self peopleApiResponse.
	context := PeopleContext queryUsing: testClient.

	self assert: context people equals: self people
]
