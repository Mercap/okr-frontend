Class {
	#name : #HttpClientResourceTest,
	#superclass : #HttpRequestTest,
	#category : #'HttpClientTestResource-Tests'
}

{ #category : #tests }
HttpClientResourceTest >> testAccessing [

	| client httpContents |

	httpContents := '{"url": "http://sarasa/objectives", "method": "GET"}'.
	client := MockHttpClient responding: httpContents.
	
	self assert: client response equals: httpContents
]

{ #category : #tests }
HttpClientResourceTest >> testExecuting [

	| expectedResponse httpRequest response |

	expectedResponse := '{"something" : "true"}'.
	httpRequest := HttpRequest 
		get: 'http://sarasa/something' asUrl.

	response := httpRequest applyOn: (MockHttpClient responding: expectedResponse).
	
	self assert: response equals: expectedResponse. 
]
