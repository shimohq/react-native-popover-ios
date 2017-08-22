# react-native-popover-ios

A native popover component for react-native, iOS only.


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [react-native-popover-ios](#react-native-popover-ios)
	* [Install](#install)
	* [Usage](#usage)
	* [properties](#properties)
		* [visible](#visible)
		* [animated](#animated)
		* [cancelable](#cancelable)
		* [popoverBackgroundColor](#popoverbackgroundcolor)
		* [sourceView](#sourceview)
		* [sourceRect](#sourcerect)
		* [permittedArrowDirections](#permittedarrowdirections)
		* [preferredContentSize](#preferredcontentsize)
		* [onShow](#onshow)
		* [onHide](#onhide)
	* [How to use the Example Project](#how-to-use-the-example-project)

<!-- /code_chunk_output -->

## Install

npm version < 5.0

```sh
npm i react-native-popover-ios --save
```

or npm version >= 5.0

```sh
npm i react-native-popover-ios
```

link

```sh
react-native link react-native-popover-ios
```

## Usage

```js
import Popover from 'react-native-popover-ios';

<Popover
  sourceView={6}
  onShow={this._onShow}
  onHide={this._onHide}
  preferredContentSize={[200, 200]}
  permittedArrowDirections={[0, 2]}>
  {content}
</Popover>
```

## properties

### visible

> determines whether your popover is visible.

default: true

### animated

> determines whether present or dismiss popover use animation.

default: true

### cancelable

> determines whether dismiss popover when clicking the out space.

default: true

### popoverBackgroundColor

the back ground color of popover.

default: 'white'

### sourceView

> the react tag of The view which containing the anchor rectangle for the popover.

example: 6

### sourceRect

> the rectangle in the specified view in which to anchor the popover.

default: the frame of the sourceView

example: [0, 0, 200, 200]

### permittedArrowDirections

> The arrow directions that you prefer for the popover.

* 0: up
* 1: down
* 2: left
* 3: right

default: [0, 1, 2, 3]

### preferredContentSize

> The preferred size for the view controller’s view.

example: [200, 400], 200 is the width and 400 is the height

### onShow

> a function that will be called once the popover has been shown.

### onHide

> a function that will be called once the popover has been hidden.

## How to use the Example Project

npm >= 5.0

install dependences

```sh
cd <react-native-popover-ios>/Example
npm i
```

fix the error: `Unable to resolve module react`

```sh
cd <react-native-popover-ios>
npm i --no-save react@16.0.0-alpha.12
```

start the local server

```sh
cd <react-native-popover-ios>/Example
react-native start
```

open example project

```sh
open open <react-native-popover-ios>/Example/ios/Example.xcodeproj/
```
