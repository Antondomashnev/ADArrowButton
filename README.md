# ADArrowButton

ADArrowButton is a Swift UIControl component like an "arrow flat style" UIButton. It could be enabled or disabled with nice spring animation.

![Animation](https://dl.dropboxusercontent.com/u/25847340/ADArrowButton/ADArrowButtonAnimation.gif)

## Requirements

- iOS 7.0+
- [Facebook POP](https://github.com/facebook/pop) - smooth animation provider =)

## Adding ADArrowButton to your project

1. Add the ADArrowButton.swift file to your project.
2. Install [Facebook POP](https://github.com/facebook/pop)

## Usage

ADArrowButton is ```@IBDesignable``` and has ```@IBInspectable``` properties listed below:
- ```arrowDirection``` - it could be Left, Right, Top, Bottom arrow
- ```lineColor```
- ```highlightedBackgroundColor```
- ```normalBackgroundColor```
- ```highlightedLineColor```
- ```lineWidth```
- ```insetTop```
- ```insetLeft```
- ```insetRight```
- ```insetBottom```
- ```enabled```

To animatedly enable or disable it just call this method
``` swift
    @IBOutlet var arrowButton: ADArrowButton!
    ...
    self.arrowButton.setEnabled(!self.arrowButton.enabled, animated: true)
  ``` 

## License

This code is distributed under the terms and conditions of the MIT license.
