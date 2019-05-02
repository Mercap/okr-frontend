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
MockHttpClient >> contents [
	^response
]

{ #category : #accessing }
MockHttpClient >> execute [
]

{ #category : #initialization }
MockHttpClient >> initializeResponding: aResponse [
 
	response := aResponse 
]

{ #category : #testing }
MockHttpClient >> isSuccess [
	 ^true 
]

{ #category : #accessing }
MockHttpClient >> method: aString [
]

{ #category : #accessing }
MockHttpClient >> readStream [
	^self
]

{ #category : #accessing }
MockHttpClient >> response [

 ^self
]

{ #category : #accessing }
MockHttpClient >> url: aZnUrl [
]
