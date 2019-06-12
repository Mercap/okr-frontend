Class {
	#name : #PeopleWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'peopleTableWebView'
	],
	#category : #'People-Views'
}

{ #category : #'instance creation' }
PeopleWebView class >> workingWith: aWorkingContext [

	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #rendering }
PeopleWebView >> addButton [

	| addButton |

	addButton := self componentSupplier
		asynchronicButtonLabeled: [ :canvas | 
			canvas
				render: ( BootstrapIconWebView representing: Glyphicons plus );
				space;
				render: #Agregar
			]
		applying: [ :button | button addClass bootstrap buttonDefault + button addClass bootstrap pullRight ].

	addButton onTrigger open: self addPersonDialog.

	^ addButton
]

{ #category : #rendering }
PeopleWebView >> addPersonDialog [

	self shouldBeImplemented
]

{ #category : #initialization }
PeopleWebView >> initializePeopleTableWebView [

	peopleTableWebView := self componentSupplier tableBuilder
		addColumn: [ :column | 
			column
				titled: 'Nombre';
				rendering: [ :person | person name ]
			];
		addColumn: [ :column | 
			column
				titled: 'Apellido';
				rendering: [ :person | person lastname ]
			];
		addColumn: [ :column | 
			column
				titled: 'Email';
				rendering: [ :person | person email ]
			];
		build.

	peopleTableWebView changeContentsTo: workingContext people
]

{ #category : #initialization }
PeopleWebView >> initializeWorkingWith: aWorkingContext [

	workingContext := aWorkingContext.

	self initializePeopleTableWebView
]

{ #category : #rendering }
PeopleWebView >> renderContentOn: aCanvas [

	aCanvas
		render: [ :canvas | 
			canvas fieldSet
				legend: 'Personas';
				with: self addButton.
			canvas render: peopleTableWebView
			]
]
