Class {
	#name : #KeyResultsWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'addKeyResultButton',
		'keyResultsTableView'
	],
	#category : #'Objective-Views'
}

{ #category : #'as yet unclassified' }
KeyResultsWebView class >> workingWith: aWorkingContext [
	
	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #'Initialization views' }
KeyResultsWebView >> addKeyResultDialog [

	^ self
		dialogTitled: 'Agregar Key Result'
		displaying: workingContext createKeyResultsView
		withFooterButtonNamed: 'Agregar'
		toExecute: [ :keyResultsView | 
			keyResultsTableView
				changeContentsTo:
					(keyResultsTableView tableContents asOrderedCollection
						add: keyResultsView model;
						yourself) ]
]

{ #category : #'Initialization views' }
KeyResultsWebView >> buttonLabeled: aButtonLabel configuredToOpenDialogCreatedBy: aDialogCreationBlock [

	| button |

	button :=
		self componentSupplier
			asynchronicButtonLabeled: [:canvas |
				canvas
					render: (BootstrapIconWebView representing: Glyphicons plus);
					space;
					render: aButtonLabel]
			applying: [:theButton |
				theButton addClass bootstrap buttonDefault + theButton addClass bootstrap buttonSmall].

	button onTrigger open: aDialogCreationBlock value.

	^button
]

{ #category : #'as yet unclassified' }
KeyResultsWebView >> createKeyResultsTableView [

	| tableBuilder |

	tableBuilder := self componentSupplier tableBuilder.

	^ tableBuilder
		addColumn: [ :column | 
			column
				titled: 'Descripción';
				rendering: [ :description | description ] ];
		addColumn: [ :column | 
			column
				titled: 'Peso';
				rendering: [ :weight | (weight * 100) percent ] ];
		build
]

{ #category : #'as yet unclassified' }
KeyResultsWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock [

	^ self
		dialogTitled: aTitle
		displaying: aView
		withFooterButtonNamed: aButtonName
		toExecute: anActionBlock
		applying: [ :document |  ]
]

{ #category : #'as yet unclassified' }
KeyResultsWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock applying: aComponentCommand [

	| dialog footerButton |

	footerButton := self componentSupplier
		asynchronicButtonLabeled: aButtonName
		applying: [ :button | button addClass bootstrap buttonDefault ].

	dialog := IdentifiedWebView
		forFormNamed: #'management-dialog' asString
		containing: [ :canvas | canvas render: aView ]
		applying: [ :identified | identified addClass bootstrap formHorizontal ].

	footerButton onTrigger
		serializeForm: dialog;
		determineBehaviorByEvaluating: [ :response | 
			anActionBlock value.
			response onReturn
				closeLastDialog;
				render: 'Test - KR Table' "keyResultsTableView" ].

	^ self
		dialogTitled: aTitle
		wrapping: dialog
		withFooterContaining: footerButton
		applying: aComponentCommand
]

{ #category : #'as yet unclassified' }
KeyResultsWebView >> dialogTitled: aTitle wrapping: aDialog withFooterContaining: modalButton applying: aComponentCommand [

	^self componentSupplier dialogBuilder
		beSelfCleaning;
		dismissableHeaderTitled: aTitle;
		wrapping: aDialog;
		closeButtonLabeled: #Cancelar
			applying: [:closeButton | closeButton addClass bootstrap buttonLink];
		addFooterButton: modalButton;
		buildApplying: aComponentCommand
]

{ #category : #'Initialization views' }
KeyResultsWebView >> initializeKeyResultsViews [

	addKeyResultButton :=
		self
			buttonLabeled: 'Key Results'
			configuredToOpenDialogCreatedBy: [self addKeyResultDialog]. 
			
	keyResultsTableView := IdentifiedWebView
			forDivNamed: 'keyResults'
			containing: self createKeyResultsTableView
			applying: [:identifier | ] 
]

{ #category : #'as yet unclassified' }
KeyResultsWebView >> initializeWorkingWith: aWorkingContext [

	workingContext := aWorkingContext.
	
	self initializeKeyResultsViews
]

{ #category : #rendering }
KeyResultsWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			(self componentSupplier gridBuilder
				columnsWidths: #(10 2);
				addContent: keyResultsTableView;
				addContent: addKeyResultButton;
				build)
]
