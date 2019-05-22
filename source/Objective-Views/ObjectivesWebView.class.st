Class {
	#name : #ObjectivesWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'headerView',
		'objectivesTableView'
	],
	#category : #'Objective-Views'
}

{ #category : #'Instance Creation' }
ObjectivesWebView class >> workingWith: aContext [

	^self new initializeWorkingWith: aContext
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> addButton [
	
	|addButton|
	addButton := self componentSupplier
		asynchronicButtonLabeled: [ :innerCanvas | 
			innerCanvas
				render: (BootstrapIconWebView representing: Glyphicons plus);
				space;
				render: #Agregar ]
		applying: [ :button | 
			button addClass bootstrap buttonDefault
				+ button addClass bootstrap pullRight ].
			
	addButton onTrigger
		render: self addObjectiveWebView.
		
	^addButton 
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> addObjectiveWebView [

	"^AddObjectiveWebView displayedIn: workingContext "
]

{ #category : #'Initialization views' }
ObjectivesWebView >> initializeHeaderView [
	
	headerView := 'Objetivos'
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> initializeObjectivesTableView [

	objectivesTableView := self componentSupplier tableBuilder
		addColumn: [ :column | 
			column
				titled: 'Descripción';
				rendering: [ :objective | objective description ] ];
		addColumn: [ :column | 
			column
				titled: 'Key Results';
				rendering: [ :objective | self renderKeyResults: (objective at: #'key-results') ] ];
		build.
	objectivesTableView changeContentsTo: workingContext objectives
]

{ #category : #initialization }
ObjectivesWebView >> initializeWorkingWith: aContext [

	workingContext := aContext.

	self initializeObjectivesTableView
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> objectivesBreadcumb [

	^ HeadingWebView
		displaying: [ :canvas | 
			canvas
				strong: #Objetivos;
				render: self addButton ]
		withLevel: 2
]

{ #category : #rendering }
ObjectivesWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			(GenericContainerWebView
				wrapping: [ :canvas | 
					self renderHeaderOn: canvas.
					canvas render: objectivesTableView ]
				applying: [ :container | container addClass bootstrap containerFluid ])
]

{ #category : #'Initialization views' }
ObjectivesWebView >> renderHeaderOn: aCanvas [
	aCanvas
		render:
			(GenericContainerWebView
				wrapping: self objectivesBreadcumb
				applying: [ :container | 
					(container addClass bootstrap columnMedium: 12)
						+ container addClass bootstrap row ])
]

{ #category : #rendering }
ObjectivesWebView >> renderKeyResult: aKeyResult [
	^ aKeyResult description , ' (' , aKeyResult weight asString , ')'
]

{ #category : #rendering }
ObjectivesWebView >> renderKeyResults: aCollection [
	^ (CollectionFormatter separatingWith: ', ')
		format:
			(aCollection collect:
				[ :keyResult | self renderKeyResult: keyResult ])
]
