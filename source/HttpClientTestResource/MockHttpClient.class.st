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
MockHttpClient >> entity: aString [ 
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

{ #category : #'as yet unclassified' }
MockHttpClient >> queryAt: aString put: anInteger [ 
	
]

{ #category : #Accessing }
MockHttpClient >> response [
	^ response
]

{ #category : #accessing }
MockHttpClient >> url: aZnUrl [
]
