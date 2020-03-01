"
LOGame
ゲームを表すクラスです.

BorderedMorph 境界線を扱う親クラス
"
Class {
	#name : #LOGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells'
	],
	#category : #'PBE-LightOut'
}

{ #category : #'as yet unclassified' }
LOGame >> cellsPerSide [
	"ゲーム盤の辺にならぶセルの数"
	^10
]

{ #category : #initialization }
LOGame >> initialize [ 
	| sampleCell width height n |
	super initialize .
	n := self cellsPerSide.
	sampleCell := LOCell new.
	width := sampleCell width.
	height := sampleCell height.
	self bounds: (5@5 extent: ((width*n) @(height*n)) + (2 * self borderWidth)).
	cells := Matrix new: n tabulate: [ :i :j | self newCellAt: i at: j ].
]

{ #category : #'event handling' }
LOGame >> mouseMove: anEvent [
]

{ #category : #'instance creation' }
LOGame >> newCellAt: i at: j [
	"位置(i, j)にセルを作成し，適切な画面の位置に追加. 新しいセルを返す"
	| c origin |
	c := LOCell new.
	origin := self innerBounds origin.
	self addMorph: c.
	c position: ((i - 1) * c width)@((j - 1) * c height) + origin.
	c mouseAction: [ self toggleNeighboursOfCellAt: i at: j ].
	^c
]

{ #category : #'game logic' }
LOGame >> toggleNeighboursOfCellAt: i at: j [
	(i > 1) ifTrue: [ (cells at: i - 1 at: j) toggleState ].
	(i < self cellsPerSide ) ifTrue: [ (cells at: i + 1 at: j) toggleState].
	(j > 1) ifTrue: [ (cells at: i at: j - 1) toggleState ].
	(j < self cellsPerSide ) ifTrue: [ (cells at: i at: j + 1) toggleState].
]
