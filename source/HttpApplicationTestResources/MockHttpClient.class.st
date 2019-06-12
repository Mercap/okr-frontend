Class {
	#name : #MockHttpClient,
	#superclass : #Object,
	#instVars : [
		'response'
	],
	#category : #HttpApplicationTestResources
}

{ #category : #'instance creation' }
MockHttpClient class >> responding: aResponse [

^self new initializeResponding: aResponse
]

{ #category : #Accessing }
MockHttpClient >> contentType: aZnMimeType [
]

{ #category : #Accessing }
MockHttpClient >> entity: aString [
]

{ #category : #executing }
MockHttpClient >> execute [


]

{ #category : #initialization }
MockHttpClient >> initializeResponding: aResponse [

	response := aResponse


]

{ #category : #Accessing }
MockHttpClient >> method: aString [

]

{ #category : #Accessing }
MockHttpClient >> queryAt: aFieldName put: aValue [

]

{ #category : #Accessing }
MockHttpClient >> response [
	^ response
]

{ #category : #Accessing }
MockHttpClient >> url: aZnUrl [
]
