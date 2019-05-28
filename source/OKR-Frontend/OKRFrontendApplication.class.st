Class {
	#name : #OKRFrontendApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'contentView',
		'currentUser',
		'identifiedContentView'
	],
	#category : #'OKR-Frontend'
}

{ #category : #accessing }
OKRFrontendApplication class >> applicationTitle [
	
	^'OKR Frontend'
]

{ #category : #accessing }
OKRFrontendApplication class >> errorHandlerFactory [
	 ^WADebugErrorHandler
]

{ #category : #accessing }
OKRFrontendApplication class >> handlerName [

	^'okr-frontend'
]

{ #category : #accessing }
OKRFrontendApplication class >> sessionClass [

	^ OKRFrontendSession
]

{ #category : #accessing }
OKRFrontendApplication >> componentSupplierForApplication [
	^ BootstrapComponentSupplier
		withBootstrapLibrary: (self deploymentMode libraryFor: Bootstrap3MetadataLibrary) withoutOptionalTheme
		selectLibrary: ((self deploymentMode libraryFor: BootstrapSelectLibrary) using: self language)
		datepickerLibrary: ((self deploymentMode libraryFor: BootstrapDatepickerLibrary) using: self language)
		typeaheadLibrary: (self deploymentMode libraryFor: BootstrapTypeaheadLibrary) new
]

{ #category : #accessing }
OKRFrontendApplication >> contentView [
	^ identifiedContentView
]

{ #category : #accessing }
OKRFrontendApplication >> currentUser [
	^ currentUser content
]

{ #category : #views }
OKRFrontendApplication >> dashboardView [

  ^DashboardView workingWith: (OKRFrontendApplicationContext on: self).
]

{ #category : #accessing }
OKRFrontendApplication >> initialRequest: request [

	super initialRequest: request.
	identifiedContentView := IdentifiedWebView forDivNamed: 'content' containing: [:canvas | canvas render: contentView ].
	contentView := UserIdentificationView workingWith: (OKRFrontendApplicationContext on: self).
	currentUser := Binding undefinedExplainedBy: 'Not logged in'.
]

{ #category : #accessing }
OKRFrontendApplication >> jQueryLibrary [

	^(self deploymentMode libraryFor: JQuery3MetadataLibrary) default
]

{ #category : #'view switching' }
OKRFrontendApplication >> switchContentViewTo: aDashboardView [ 
	contentView := aDashboardView
]

{ #category : #'user identification' }
OKRFrontendApplication >> switchCurrentUserTo: aUser [ 
	currentUser := DefinedBinding connectedTo: aUser
]

{ #category : #views }
OKRFrontendApplication >> userIdentificationView [

  ^UserIdentificationView workingWith: (OKRFrontendApplicationContext on: self).
]

{ #category : #workflow }
OKRFrontendApplication >> userIdentifiedAs: aUser [ 
	self switchCurrentUserTo: aUser.
	self switchContentViewTo: self dashboardView
]
