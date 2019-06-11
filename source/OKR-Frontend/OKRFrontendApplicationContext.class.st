Class {
	#name : #OKRFrontendApplicationContext,
	#superclass : #Object,
	#instVars : [
		'application'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
OKRFrontendApplicationContext class >> on: anOKRFrontendApplication [
	^ self new initializeOn: anOKRFrontendApplication
]

{ #category : #accessing }
OKRFrontendApplicationContext >> availableUsers [
	^ #(pedro mariano)
]

{ #category : #initialization }
OKRFrontendApplicationContext >> basePath [

	^ 'http://localhost:10000'
]

{ #category : #accessing }
OKRFrontendApplicationContext >> currenUser [
	^application currentUser
]

{ #category : #accessing }
OKRFrontendApplicationContext >> httpClient [

	^ ZnClient new 
]

{ #category : #initialization }
OKRFrontendApplicationContext >> initializeOn: anOKRFrontendApplication [
	application := anOKRFrontendApplication
]

{ #category : #workflow }
OKRFrontendApplicationContext >> logout [
	application logout
]

{ #category : #accessing }
OKRFrontendApplicationContext >> mainContentView [
	^application contentView
]

{ #category : #accessing }
OKRFrontendApplicationContext >> objectivesJson [
	^ '[
   {
      "description":"Mejora de Producto",
      "key-results":[
         {
            "keyresult":1,
            "description":"Modularizar Siopel",
            "weight":0.4
         },
         {
            "keyresult":2,
            "description":"Llevar Unitrade al Core",
            "weight":0.4
         },
         {
            "keyresult":3,
            "description":"Hacer que pasen todos los tests",
            "weight":0.2
         }
      ]
   },
   {
      "description":"Satisfaccion del Cliente",
      "key-results":[
         {
            "keyresult":4,
            "description":"Documentacion",
            "weight":0.7
         },
         {
            "keyresult":5,
            "description":"Entregas en fecha",
            "weight":0.3
         }
      ]
   },
{
      "description":"Algo que todavia no se bien",
      "key-results":[]
   }
]'
]

{ #category : #accessing }
OKRFrontendApplicationContext >> peopleJson [

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

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> renderObjectivesView [
	application
		switchContentViewTo:
			(ObjectivesWebView
				workingWith:
					(ObjectiveContext using: self httpClient workingWith: self))
]

{ #category : #'user identification' }
OKRFrontendApplicationContext >> userIdentifiedAs: aUser [ 
	application userIdentifiedAs: aUser
]
