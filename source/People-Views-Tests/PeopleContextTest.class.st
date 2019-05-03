Class {
	#name : #PeopleContextTest,
	#superclass : #TestCase,
	#category : #'People-Views-Tests'
}

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
	| context client |
	client := MockHttpClient responding: self peopleApiResponse.
	context := PeopleContext queryUsing: client.
	self assert: context people equals: self peopleApiResponse
]
