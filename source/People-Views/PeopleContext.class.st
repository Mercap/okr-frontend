Class {
	#name : #PeopleContext,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'People-Views'
}

{ #category : #'instance creation' }
PeopleContext class >> queryUsing: aClient [

	^ self new initializeQueryUsing: aClient
]

{ #category : #initialization }
PeopleContext >> initializeQueryUsing: aClient [

	client := aClient
]

{ #category : #acccessing }
PeopleContext >> people [
	^ (HttpRequest get: 'http://sarasa/something' asUrl) applyOn: client
]
