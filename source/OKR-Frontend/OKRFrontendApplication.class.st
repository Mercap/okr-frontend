Class {
	#name : #OKRFrontendApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'contentView'
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
OKRFrontendApplication >> componentSupplierForApplication [
	^ BootstrapComponentSupplier
		withBootstrapLibrary: (self deploymentMode libraryFor: Bootstrap3MetadataLibrary) withoutOptionalTheme
		selectLibrary: ((self deploymentMode libraryFor: BootstrapSelectLibrary) using: self language)
		datepickerLibrary: ((self deploymentMode libraryFor: BootstrapDatepickerLibrary) using: self language)
		typeaheadLibrary: (self deploymentMode libraryFor: BootstrapTypeaheadLibrary) new
]

{ #category : #accessing }
OKRFrontendApplication >> contentView [
	^ contentView
]

{ #category : #accessing }
OKRFrontendApplication >> initialRequest: request [

	super initialRequest: request.
	contentView := UserIdentificationView workingWith: (OKRFrontendApplicationContext on: self)
]

{ #category : #accessing }
OKRFrontendApplication >> jQueryLibrary [

	^(self deploymentMode libraryFor: JQuery3MetadataLibrary) default
]
