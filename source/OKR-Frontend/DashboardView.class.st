Class {
	#name : #DashboardView,
	#superclass : #WAPainter,
	#instVars : [
		'context',
		'topMenu',
		'contentView',
		'identifiedContentView'
	],
	#category : #'OKR-Frontend'
}

{ #category : #'instance creation' }
DashboardView class >> workingWith: aWorkingContext [ 
	^self new initializeWorkingWith: aWorkingContext 
]

{ #category : #initialization }
DashboardView >> addActionLabeled: aLabel to: aMenuBuilder toSwitchTo: aWebView [
	aMenuBuilder
		addActionLabeled: aLabel
		executing: [ :button | self configureTriggerFor: button toSwitchTo: aWebView ]
]

{ #category : #initialization }
DashboardView >> configureTriggerFor: aComponent toSwitchTo: aWebView [
	aComponent onTrigger
		evaluate: [ self switchContentViewTo: aWebView ];
		render: identifiedContentView
]

{ #category : #views }
DashboardView >> dashboardSummaryView [
	^ DashboardSummaryView workingWith: context
]

{ #category : #initialization }
DashboardView >> initializeIdentifiedContentView [
	identifiedContentView := IdentifiedWebView
		forDivNamed: 'content'
		containing: [ :canvas | canvas render: contentView ]
]

{ #category : #initialization }
DashboardView >> initializeTopMenu [
	topMenu := [ :canvas | 
	| list logo menuBuilder menu logoutButton |
	list := canvas unorderedList.
	logo := self componentSupplier
		asynchronicLinkLabeled: '[Logo]'
		applying: [ :anchor :constants | anchor addClass bootstrap columnMedium: 1 ].
	self configureTriggerFor: logo toSwitchTo: self dashboardSummaryView.
	menuBuilder := self componentSupplier dropdownMenuBuilder
		beNavigationMenuIn: list;
		labeled: 'Objetivos';
		yourself.
	self
		addActionLabeled: 'Individuales'
		to: menuBuilder
		toSwitchTo: self manageObjectivesView.
	menu := menuBuilder
		beNavigationMenuIn: list;
		labeled: 'Objetivos';
		build.
	logoutButton := self componentSupplier
		asynchronicButtonLabeled: 'Logout'
		applying: [ :anchor | anchor addClass bootstrap buttonPrimary ].
	logoutButton onTrigger
		evaluate: [ context logout ];
		render: context mainContentView.
	list
		apply: [ :theList | 
			theList addClass bootstrap nav
				+ theList addClass bootstrap navbarNavigation
				+ (theList addClass bootstrap columnMedium: 12) ].
	list
		with: [ canvas render: logo.
			canvas render: menu.
			canvas render: logoutButton ] ]
]

{ #category : #initialization }
DashboardView >> initializeWorkingWith: aWorkingContext [
	context := aWorkingContext.
	self initializeTopMenu.
	self switchContentViewTo: self dashboardSummaryView.
	self initializeIdentifiedContentView
]

{ #category : #views }
DashboardView >> manageObjectivesView [
	^ ObjectivesWebView
		workingWith: (ObjectiveContext using: context httpClient)
]

{ #category : #rendering }
DashboardView >> renderContentOn: aCanvas [
	aCanvas
		render: ('Bienvenido <1s>' expandMacrosWith: context currenUser).
	aCanvas div with: [ :canvas | canvas render: topMenu ].
	aCanvas render: identifiedContentView
]

{ #category : #rendering }
DashboardView >> switchContentViewTo: aContentView [ 
	contentView := aContentView
]
