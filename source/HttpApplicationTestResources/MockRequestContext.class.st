"
I represent a mock of WARequestContext
"
Class {
	#name : #MockRequestContext,
	#superclass : #Object,
	#instVars : [
		'basePath'
	],
	#category : #HttpApplicationTestResources
}

{ #category : #'Instance Creation' }
MockRequestContext class >> respondingBasepathWith: aString [

	^ self new initializeRespondingBasepathWith: aString
]

{ #category : #Accessing }
MockRequestContext >> applicationContext [
	
]

{ #category : #Accessing }
MockRequestContext >> basePath [

	^ basePath
]

{ #category : #initialization }
MockRequestContext >> initializeRespondingBasepathWith: aString [

	basePath := aString
]

{ #category : #Accessing }
MockRequestContext >> session [
	
]
