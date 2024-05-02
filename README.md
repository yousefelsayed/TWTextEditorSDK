# TWTextEditorSDK


<p align="row">
<img src= "https://media.giphy.com/media/8126LNcT9QCSmVX2z4/giphy.gif" width="400" >
</p>

## Features

- [x] Count the number of characters based on twitter criteria 


## Requirements

- iOS 13.0+


## Installation

### Add TWTextEditorSDK framework to your project

Add the following lines to your `Package.swift` or use Xcode “Add Package Dependency…” menu.

```swift
// In your `Package.swift`

dependencies: [
    .package(name: "TWTextEditorSDK", url: "https://github.com/yousefelsayed/TWTextEditorSDK", ...),
    ...
],
targets: [
    .target(
        name: ...,
        dependencies: [
            .product(name: "TWTextEditorSDK", package: "TWTextEditorSDK"),
            ...
        ]
    ),
    ...
]
```


To get the full benefits import `TWTextEditorSDK` wherever you import UIKit

``` swift
import UIKit
import TWTextEditorSDK
```

```
github "github.com/yousefelsayed/TWTextEditorSDK"
```

## Usage example

```swift
import TWTextEditorSDK
```



