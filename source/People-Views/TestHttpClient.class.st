Class {
	#name : #TestHttpClient,
	#superclass : #Object,
	#instVars : [
		'response'
	],
	#category : #'People-Views'
}

{ #category : #accesing }
TestHttpClient >> addExpectedResponse: anApiResponse [ 
 	
	response add: anApiResponse 
]

{ #category : #executing }
TestHttpClient >> execute [
	
	^response 
]

{ #category : #initialization }
TestHttpClient >> initialize [ 
	
	response := OrderedCollection new
]
