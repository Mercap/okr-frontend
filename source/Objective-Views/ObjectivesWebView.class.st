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

{ #category : #buttons }
ObjectivesWebView >> actionButtons [

	| buttonStyle |

	buttonStyle := [ :button | button addClass bootstrap buttonSmall ].

	^ OrderedCollection new
		add: ( self modifyActionButtonApplying: buttonStyle );
		add: ( self deleteActionButtonApplying: buttonStyle );
		yourself
]

{ #category : #buttons }
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
		open: self addObjectiveDialog.
		
	^addButton 
]

{ #category : #buttons }
ObjectivesWebView >> addObjectiveDialog [

	| addObjectiveView |

	addObjectiveView := AddObjectiveWebView displayedIn: workingContext.

	^ self
		dialogTitled: #'Agregar objetivo'
		displaying: [ :canvas | canvas render: addObjectiveView ]
		withFooterButtonNamed: #Agregar
		toExecute: [ workingContext addObjective: addObjectiveView jsonObject.
			objectivesTableView
				changeContentsTo: workingContext objectives ]
]

{ #category : #buttons }
ObjectivesWebView >> deleteActionButtonApplying: buttonStyle [
	| button |
	button := self componentSupplier
		asynchronicButtonLabeled: 'Eliminar'
		applying: buttonStyle.
	button onTrigger
		open:
			(self
				dialogTitled: '¿Desea eliminar el objetivo?'
				displaying: ConfirmationDialogWebView
				withFooterButtonNamed: 'Aceptar'
				toExecute: [ :objective | 
					objectivesTableView
						changeContentsTo:
							(objectivesTableView view contents asOrderedCollection
								remove: objective;
								yourself)
				
					"Avisarle al contexto que elimine ']' expected -> el objetivo.- isosa" ]
			applying: [ :modal | modal addClass bootstrap modalSmall ]).
	^ button
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock [

	^ self
		dialogTitled: aTitle
		displaying: aView
		withFooterButtonNamed: aButtonName
		toExecute: anActionBlock
		applying: [ :document | document addClass bootstrap modalLarge ]
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> dialogTitled: aTitle displaying: aView withFooterButtonNamed: aButtonName toExecute: anActionBlock applying: aComponentCommand [

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
				render: workingContext applicationContext mainContentView ].

	^ self
		dialogTitled: aTitle
		wrapping: dialog
		withFooterContaining: footerButton
		applying: aComponentCommand
]

{ #category : #'as yet unclassified' }
ObjectivesWebView >> dialogTitled: aTitle wrapping: aDialog withFooterContaining: modalButton applying: aComponentCommand [

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
		addColumn:[:column| 
			column 
			rendering: [:objective | self actionButtons]];
		build.
	objectivesTableView changeContentsTo: workingContext objectives
]

{ #category : #initialization }
ObjectivesWebView >> initializeWorkingWith: aContext [

	workingContext := aContext.

	self initializeObjectivesTableView
]

{ #category : #buttons }
ObjectivesWebView >> modifyActionButtonApplying: buttonStyle [

	^ self componentSupplier asynchronicButtonLabeled: 'Modificar' applying: buttonStyle
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
