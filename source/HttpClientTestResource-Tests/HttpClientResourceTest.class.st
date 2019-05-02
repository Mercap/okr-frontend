Class {
	#name : #HttpClientResourceTest,
	#superclass : #HttpRequestTest,
	#category : #'HttpClientTestResource-Tests'
}

{ #category : #tests }
HttpClientResourceTest >> testAccessing [

	| httpClientResource httpContents |

	httpContents := '{"url": "http://sarasa/objectives", "method": "GET"}'.
	httpClientResource := MockHttpClient responding: httpContents.
	
	self 	assert: httpClientResource isSuccess;
			assert: httpClientResource contents equals: httpContents
]
