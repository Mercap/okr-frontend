Class {
	#name : #OKRFrontendApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'currentUser',
		'identifiedMainContentView',
		'mainContentView'
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
OKRFrontendApplication >> basePath [

	^ 'http://localhost:1710'
]

{ #category : #accessing }
OKRFrontendApplication >> componentSupplierForApplication [

	^ BootstrapComponentSupplier
		withBootstrapLibrary: ( self deploymentMode libraryFor: Bootstrap3MetadataLibrary ) withoutOptionalTheme
		selectLibrary: ( ( self deploymentMode libraryFor: BootstrapSelectLibrary ) using: self language )
		datepickerLibrary: ( ( self deploymentMode libraryFor: BootstrapDatepickerLibrary ) using: self language )
		typeaheadLibrary: ( self deploymentMode libraryFor: BootstrapTypeaheadLibrary ) new
]

{ #category : #accessing }
OKRFrontendApplication >> contentView [

	^ identifiedMainContentView
]

{ #category : #accessing }
OKRFrontendApplication >> currentUser [

	^ currentUser content
]

{ #category : #views }
OKRFrontendApplication >> dashboardView [

  ^DashboardView workingWith: (OKRFrontendApplicationContext on: self).
]

{ #category : #initalization }
OKRFrontendApplication >> initialRequest: request [

	super initialRequest: request.
	self initializeIdentifiedMainContentView.
	self switchMainContentViewTo: self userIdentificationView.
	self initializeCurrentUser
]

{ #category : #initalization }
OKRFrontendApplication >> initializeCurrentUser [

	currentUser := Binding undefinedExplainedBy: 'Not logged in'
]

{ #category : #initalization }
OKRFrontendApplication >> initializeIdentifiedMainContentView [

	identifiedMainContentView := IdentifiedWebView
		forDivNamed: 'main-content'
		containing: [ :canvas | canvas render: mainContentView ]
]

{ #category : #accessing }
OKRFrontendApplication >> jQueryLibrary [

	^(self deploymentMode libraryFor: JQuery3MetadataLibrary) default
]

{ #category : #workflow }
OKRFrontendApplication >> logout [

	self initializeCurrentUser.
	self switchMainContentViewTo: self userIdentificationView
]

{ #category : #'view switching' }
OKRFrontendApplication >> switchContentViewTo: aDashboardView [

	contentView := aDashboardView
]

{ #category : #'user identification' }
OKRFrontendApplication >> switchCurrentUserTo: aUser [

	currentUser := DefinedBinding connectedTo: aUser
]

{ #category : #'view switching' }
OKRFrontendApplication >> switchMainContentViewTo: aDashboardView [

	mainContentView := aDashboardView
]

{ #category : #views }
OKRFrontendApplication >> userIdentificationView [

  ^UserIdentificationView workingWith: (OKRFrontendApplicationContext on: self).
]

{ #category : #workflow }
OKRFrontendApplication >> userIdentifiedAs: aUser [

	self switchCurrentUserTo: aUser.
	self switchMainContentViewTo: self dashboardView
]
