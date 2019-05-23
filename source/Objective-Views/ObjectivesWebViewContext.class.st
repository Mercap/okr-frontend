Class {
	#name : #ObjectivesWebViewContext,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance Creation' }
ObjectivesWebViewContext class >> within: aContext [

	^self new initializeWithin: aContext
]

{ #category : #initialization }
ObjectivesWebViewContext >> initializeWithin: aContext [

	context := aContext.
]
