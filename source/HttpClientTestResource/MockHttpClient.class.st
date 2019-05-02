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

{ #category : #Accessing }
MockHttpClient >> response [
	^ response
]

{ #category : #accessing }
MockHttpClient >> url: aZnUrl [
]
