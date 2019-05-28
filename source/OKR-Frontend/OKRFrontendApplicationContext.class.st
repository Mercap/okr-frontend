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

{ #category : #accessing }
OKRFrontendApplicationContext >> contentView [
	^application contentView
]

{ #category : #accessing }
OKRFrontendApplicationContext >> currenUser [
	^application currentUser
]

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> httpClient [
	"Cambiar por (ZnClient new) cuando este lista la api -mdicroce"

	^ MockHttpClient
		responding: (ZnResponse ok: (ZnStringEntity json: self teamsEntity))
]

{ #category : #initialization }
OKRFrontendApplicationContext >> initializeOn: anOKRFrontendApplication [
	application := anOKRFrontendApplication
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> peopleContext [

	self flag: 'Cambiar'.
	^ nil
]

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> renderObjectivesView [
	application
		switchContentViewTo:
			(ObjectivesWebView
				workingWith:
					(ObjectiveContext using: self httpClient))
]

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> renderTeamsView [

	application
		switchContentViewTo: ( TeamsWebView workingWith: ( TeamsContext queryUsing: self httpClient workingWith: self peopleContext) )
]

{ #category : #'as yet unclassified' }
OKRFrontendApplicationContext >> teamsEntity [

	^ '[
    {
      "name": "I+D",
      "members": []
    }
]
'
]

{ #category : #'user identification' }
OKRFrontendApplicationContext >> userIdentifiedAs: aUser [ 
	application userIdentifiedAs: aUser
]
