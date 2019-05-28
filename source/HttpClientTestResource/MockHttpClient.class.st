Class {
	#name : #MockHttpClient,
	#superclass : #Object,
	#instVars : [
		'response'
	],
	#category : #HttpClientTestResource
}

{ #category : #'instance creation' }
MockHttpClient class >> responding: aResponse [

^self new initializeResponding: aResponse
]

{ #category : #accessing }
MockHttpClient >> entity: anEntity [ 
	
	"Cargar el código que resuelve esto y mergearlo"
]

{ #category : #executing }
MockHttpClient >> execute [


]

{ #category : #initialization }
MockHttpClient >> initializeResponding: aResponse [

	response := aResponse

	
]

{ #category : #accessing }
MockHttpClient >> method: aString [ 

]

{ #category : #accessing }
MockHttpClient >> queryAt: aFieldName put: aValue [
]

{ #category : #Accessing }
MockHttpClient >> response [
	^ response
]

{ #category : #accessing }
MockHttpClient >> url: aZnUrl [
]
