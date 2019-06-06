Class {
	#name : #MockRequestContextTest,
	#superclass : #TestCase,
	#category : #'HttpApplicationTestResources-Tests'
}

{ #category : #tests }
MockRequestContextTest >> testAccessing [

	| basePath requestContext |

	basePath := 'base'.
	requestContext := MockRequestContext respondingBasepathWith: basePath.
	self assert: requestContext basePath equals: basePath
]

{ #category : #tests }
MockRequestContextTest >> testExecutionUsage [

	| basePath requestContext |

	basePath := 'base'.
	requestContext := MockRequestContext respondingBasepathWith: basePath.
	self assert: requestContext session applicationContext basePath equals: basePath
]
