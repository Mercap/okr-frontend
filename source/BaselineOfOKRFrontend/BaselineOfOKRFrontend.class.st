Class {
	#name : #BaselineOfOKRFrontend,
	#superclass : #BaselineOf,
	#category : #BaselineOfOKRFrontend
}

{ #category : #baselines }
BaselineOfOKRFrontend >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self
				setUpDependencies: spec;
				baselineOKRFrontend: spec.
			spec
				group: 'CI' with: 'Tests';
				group: 'Development' with: #('Tests')
			]
]

{ #category : #baselines }
BaselineOfOKRFrontend >> baselineOKRFrontend: spec [
	spec
		package: 'OKR-Frontend'
			with: [ spec requires: #('WillowBootstrap-Deployment' 'Superluminal') ];
		group: 'Deployment' with: 'OKR-Frontend';
		package: 'HttpClientTestResource';
		package: 'OKR-Frontend-Tests'
			with: [ spec
				requires: #('OKR-Frontend' 'WillowBootstrap-SUnit' 'HttpClientTestResource') ];
		group: 'Tests' with: 'OKR-Frontend-Tests'
]

{ #category : #baselines }
BaselineOfOKRFrontend >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfOKRFrontend >> setUpDependencies: spec [
	spec
		baseline: 'WillowBootstrap'
			with: [ spec repository: 'github://ba-st/Willow-Bootstrap:v11/source' ];
		project: 'WillowBootstrap-Deployment'
			copyFrom: 'WillowBootstrap'
			with: [ spec loads: 'Deployment' ];
		project: 'WillowBootstrap-SUnit'
			copyFrom: 'WillowBootstrap'
			with: [ spec loads: 'Dependent-SUnit-Extensions' ];
		baseline: 'Superluminal'
			with: [ spec
				repository: 'github://ba-st/Superluminal:v1.0.0/source';
				loads: 'Deployment'
			];
		baseline: 'Teapot'
			with: [ spec
				repository: 'github://zeroflag/Teapot:v2.6.0/source';
				loads: #('Deployment')
			];
		import: 'Teapot'
]
