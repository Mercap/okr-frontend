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
			with: [ spec
				requires: #('WillowBootstrap-Deployment' 'Superluminal' 'NeoJSON') ];
		package: 'OKR-Frontend-Tests'
			with: [ spec
				requires:
					#('OKR-Frontend' 'WillowBootstrap-SUnit' 'HttpApplicationTestResources') ];
		package: 'HttpApplicationTestResources';
		package: 'HttpApplicationTestResources-Tests'
			with: [ spec requires: #('HttpApplicationTestResources') ];
		package: 'API-Errors' with: [ spec requires: #() ];
		package: 'Team-Views'
			with: [ spec requires: #('WillowBootstrap-Deployment' 'Superluminal') ];
		package: 'Team-Views-Tests'
			with: [ spec
				requires: #('Team-Views' 'HttpApplicationTestResources' 'WillowBootstrap-SUnit') ];
		package: 'People-Views'
			with: [ spec requires: #('WillowBootstrap-Deployment' 'Superluminal') ];
		package: 'People-Views-Tests'
			with: [ spec
				requires:
					#('People-Views' 'HttpApplicationTestResources' 'WillowBootstrap-SUnit') ];
		package: 'Objective-Views'
			with: [ spec requires: #('WillowBootstrap-Deployment' 'Superluminal') ];
		package: 'Objective-Views-Tests'
			with: [ spec
				requires:
					#('Objective-Views' 'HttpApplicationTestResources' 'WillowBootstrap-SUnit') ];
		group: 'Deployment'
			with: #('OKR-Frontend' 'Team-Views' 'Objective-Views');
		group: 'Tests'
			with: #('OKR-Frontend-Tests' 'Team-Views-Tests' 'Objective-Views-Tests')
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
				repository: 'github://ba-st/Superluminal:release-candidate/source';
				loads: 'Deployment'
			];
		baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
		baseline: 'Teapot'
			with: [ spec
				repository: 'github://zeroflag/Teapot:v2.6.0/source';
				loads: #('Deployment')
			];
		import: 'Teapot'
]
