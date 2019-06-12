Class {
	#name : #PeriodContextTest,
	#superclass : #TestCase,
	#category : #'OKR-Period-Views-Tests'
}

{ #category : #accessing }
PeriodContextTest >> deletePeriodNotFoundResponse [
	^ ZnResponse
		notFound:
			'http://localhost:10000/periods/7103cc3a-5646-0d00-aa43-8e790f0e4409'
				asUrl
]

{ #category : #accessing }
PeriodContextTest >> deletePeriodSuccessfulResponse [
	^ ZnResponse ok: ZnStringEntity new
]

{ #category : #accessing }
PeriodContextTest >> getPeriodsResponse [
	^ self successfulResponseContaining: self getPeriodsResponseJson
]

{ #category : #accessing }
PeriodContextTest >> getPeriodsResponseJson [
	^ '[
    {
        "name": "2019Q1",
        "startDate": "2019-01-01",
        "endDate": "2019-03-31",
        "links": {
            "self": "http://localhost:10000/periods/7103cc3a-5646-0d00-aa43-8e790f0e4409"
        }
    },
    {
        "name": "2019Q2",
        "startDate": "2019-04-01",
        "endDate": "2019-06-31",
        "links": {
            "self": "http://localhost:10000/periods/xxx"
        }
    }
]'
]

{ #category : #'as yet unclassified' }
PeriodContextTest >> patchPeriodResponse [
	self shouldBeImplemented.
]

{ #category : #'test supporting' }
PeriodContextTest >> period [

	^(NeoJSONObject new)
	at: #name put: 'Deploy Abbaco backend APIs';
	at: #startDate put: '2019-01-01';
	at: #endDate put: '2019-03-31';
	yourself

]

{ #category : #accessing }
PeriodContextTest >> periodToAdd [
	^ NeoJSONObject new
		at: #name put: 'Deploy Abbaco backend APIs';
		at: #startDate put: '2019-01-01';
		at: #endDate put: '2019-03-31';
		yourself
]

{ #category : #accessing }
PeriodContextTest >> periodToRemove [
	^ NeoJSONObject new
		at: #name put: 'Deploy Abbaco backend APIs';
		at: #startDate put: '2019-01-01';
		at: #endDate put: '2019-03-31';
		at: #link
			put:
			'http://192.164.1.205:10000/periods/7103cc3a-5646-0^C0-aa43-8e790f0e4409';
		yourself
]

{ #category : #'test supporting' }
PeriodContextTest >> postPeriodResponse [
	^ self successfulResponseContaining: self postPeriodResponseJson
]

{ #category : #'test supporting' }
PeriodContextTest >> postPeriodResponseJson [
	^ '{
  	  "status" : 201,		
			"body" : "Created sarasa"
		}'
]

{ #category : #'test supporting' }
PeriodContextTest >> successfulResponseContaining: aString [
	^ ZnResponse ok: (ZnStringEntity json: aString)
]

{ #category : #tests }
PeriodContextTest >> testDeletePeriodFailsDueToPeriodNotFound [
	| context |
	context := PeriodContext
		using: (MockHttpClient responding: self deletePeriodNotFoundResponse).
	self
		should: [ context removePeriod: self periodToRemove ]
		raise: Error
		withMessageText: 'Error al borrar el periodo'
]

{ #category : #tests }
PeriodContextTest >> testDeletePeriodSuccessfully [
	| context period |
	context := PeriodContext
		using: (MockHttpClient responding: self deletePeriodSuccessfulResponse).
	period := self periodToRemove.
	self assert: (context removePeriod: period) equals: period
]

{ #category : #tests }
PeriodContextTest >> testGetPeriods [
	| context periods |
	context := PeriodContext
		using: (MockHttpClient responding: self getPeriodsResponse).
	periods := context periods.
	self assert: periods size equals: 2.
	self
		assert: (periods at: 1) name equals: '2019Q1';
		assert: (periods at: 1) startDate equals: '2019-01-01';
		assert: (periods at: 1) endDate equals: '2019-03-31'.
	self
		assert: (periods at: 2) name equals: '2019Q2';
		assert: (periods at: 2) startDate equals: '2019-04-01';
		assert: (periods at: 2) endDate equals: '2019-06-31'
]

{ #category : #tests }
PeriodContextTest >> testPatchPeriod [
	self
		shouldFix: [ | context period |
			context := PeriodContext
				using: (MockHttpClient responding: self patchPeriodResponse).
			period := self periodToUpdate.
			self
				assert:
					(context
						updatePeriod: period
						with:
							(self periodToUpdate
								at: #name put: 'Primer Quarter 2020';
								at: #startDate put: '2020-01-01';
								at: #endDate put: '2020-03-31';
								yourself))
				equals: period.
			self assert: period name equals: 'Primer Quarter 2019'.
			self assert: period startDate equals: '2020-01-01'.
			self assert: period endDate equals: '2020-03-31' ]
]

{ #category : #tests }
PeriodContextTest >> testPostPeriod [
	| context period |
	context := PeriodContext
		using: (MockHttpClient responding: self postPeriodResponse).
	period := self periodToAdd.
	self assert: (context addPeriod: period) equals: period
]
