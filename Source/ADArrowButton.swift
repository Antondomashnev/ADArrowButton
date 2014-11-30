//
//  ADArrowButton.swift
//  ADArrowButton
//
//  Created by Anton Domashnev on 11/29/14.
//  Copyright (c) 2014 adomashnev. All rights reserved.
//

import UIKit
import QuartzCore;

enum ArrowDirection: String {
    case Left = "Left"
    case Right = "Right"
    case Top = "Top"
    case Bottom = "Bottom"
    
    static var allValues: [String] {
        return [ArrowDirection.Left.rawValue, ArrowDirection.Right.rawValue, ArrowDirection.Bottom.rawValue, ArrowDirection.Top.rawValue]
    }
    
    static func arrowDirectionFromString(string: String) -> ArrowDirection
    {
        switch(string){
        case "Left":
            return .Left
        case "Right":
            return .Right
        case "Top":
            return .Top
        case "Bottom":
            return .Bottom
        default:
            return .Left
        }
    }
}

@IBDesignable public class ADArrowButton: UIControl {
    
    private var topLineLayer: CAShapeLayer?
    private var bottomLineLayer: CAShapeLayer?
    private var startLineLayerPoint: CGPoint! = CGPointZero
    private var endTopLineLayerPoint: CGPoint! = CGPointZero
    private var endBottomLineLayerPoint: CGPoint! = CGPointZero
    
    private var arrowDirectionEnumValue: ArrowDirection = ArrowDirection.Left
    @IBInspectable var ADArrowDirection: String = "Left" {
        willSet(newValue) {
            assert(newValue == ArrowDirection.Left.rawValue || newValue == ArrowDirection.Right.rawValue || newValue == ArrowDirection.Bottom.rawValue || newValue == ArrowDirection.Top.rawValue, "Invalid arrow direction. Possible values: \(ArrowDirection.allValues)")
            self.arrowDirectionEnumValue = ArrowDirection.arrowDirectionFromString(newValue)
        }
        didSet {
            self.recalculateLineLayersPoints()
            self.render()
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blackColor() {
        didSet {
            self.render()
        }
    }
    
    @IBInspectable var highlightedBackgroundColor: UIColor = UIColor.blackColor() {
        didSet {
            self.render()
        }
    }
    
    @IBInspectable var normalBackgroundColor: UIColor = UIColor.blackColor() {
        didSet {
            self.render()
        }
    }
    
    @IBInspectable var highlightedLineColor: UIColor = UIColor.blackColor() {
        didSet {
            self.render()
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 2 {
        didSet {
            self.render()
        }
    }
    
    @IBInspectable var insetTop: CGFloat = 2 {
        didSet {
            self.recalculateLineLayersPoints()
            self.render()
        }
    }
    
    @IBInspectable var insetLeft: CGFloat = 2 {
        didSet {
            self.recalculateLineLayersPoints()
            self.render()
        }
    }
    
    @IBInspectable var insetBottom: CGFloat = 2 {
        didSet {
            self.recalculateLineLayersPoints()
            self.render()
        }
    }
    
    @IBInspectable var insetRight: CGFloat = 2 {
        didSet {
            self.recalculateLineLayersPoints()
            self.render()
        }
    }
    
    @IBInspectable override public var enabled: Bool {
        didSet {
            self.recalculateLineLayersPoints()
            self.render()
        }
    }
    
    required public override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setUp()
    }
    
    //MARK: - Interface
    
    public func setEnabled(enabled: Bool, animated: Bool)
    {
        if(animated){
            super.enabled = enabled
            self.startLineLayerPoint = self.lineLayersStartPointForCurrentState()
            self.animateEnableChange()
        }
        else{
            self.enabled = enabled
        }
    }
    
    //MARK: - NSCoding
    
    required public init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    //MARK: - UI
    
    private func addTopLineLayer()
    {
        let topLine = CAShapeLayer()
        self.layer.addSublayer(topLine)
        self.topLineLayer = topLine
    }
    
    private func addBottomLineLayer()
    {
        let bottomLine = CAShapeLayer()
        self.layer.addSublayer(bottomLine)
        self.bottomLineLayer = bottomLine
    }
    
    //MARK: - Helpers
    
    private func setUp()
    {
        self.addTopLineLayer()
        self.addBottomLineLayer()
    }
    
    private func recalculateLineLayersPoints()
    {
        self.startLineLayerPoint = self.lineLayersStartPointForCurrentState()
        self.endTopLineLayerPoint = self.topLineLayersEndPointForCurrentState()
        self.endBottomLineLayerPoint = self.bottomLineLayersEndPointForCurrentState()
    }
    
    private func lineLayersStartPointForCurrentState() -> CGPoint
    {
        switch(self.arrowDirectionEnumValue){
        case .Left:
            return CGPoint(x: self.insetLeft, y: self.bounds.height / 2)
        case .Right:
            return CGPoint(x: self.bounds.width - self.insetRight, y: self.bounds.height / 2)
        case .Top:
            return CGPoint(x: self.bounds.width / 2, y: self.insetTop)
        case .Bottom:
            return CGPoint(x: self.bounds.width / 2, y: self.bounds.height - self.insetBottom)
        }
    }
    
    private func topLineLayersEndPointForCurrentState() -> CGPoint
    {
        if(self.enabled){
            switch(self.arrowDirectionEnumValue){
            case .Left:
                let pointY = self.insetTop
                let pointX = self.bounds.size.width - self.insetRight
                return CGPoint(x: pointX, y: pointY)
            case .Right:
                let pointY = self.insetTop
                let pointX = self.insetLeft
                return CGPoint(x: pointX, y: pointY)
            case .Top:
                let pointY = self.bounds.height - self.insetBottom
                let pointX = self.insetLeft
                return CGPoint(x: pointX, y: pointY)
            case .Bottom:
                let pointY = self.insetTop
                let pointX = self.insetLeft
                return CGPoint(x: pointX, y: pointY)
            }
        }
        else{
            switch(self.arrowDirectionEnumValue){
            case .Left:
                let pointY = self.bounds.size.height / 2
                let pointX = self.bounds.size.width - self.insetRight
                return CGPoint(x: pointX, y: pointY)
            case .Right:
                let pointY = self.bounds.size.height / 2
                let pointX = self.insetLeft
                return CGPoint(x: pointX, y: pointY)
            case .Top:
                let pointY = self.bounds.height - self.insetBottom
                let pointX = self.bounds.size.width / 2
                return CGPoint(x: pointX, y: pointY)
            case .Bottom:
                let pointY = self.insetTop
                let pointX = self.bounds.size.width / 2
                return CGPoint(x: pointX, y: pointY)
            }
        }
    }
    
    private func bottomLineLayersEndPointForCurrentState() -> CGPoint
    {
        if(self.enabled){
            switch(self.arrowDirectionEnumValue){
            case .Left:
                let pointY = self.bounds.height - self.insetBottom
                let pointX = self.bounds.size.width - self.insetRight
                return CGPoint(x: pointX, y: pointY)
            case .Right:
                let pointY = self.bounds.height - self.insetBottom
                let pointX = self.insetLeft
                return CGPoint(x: pointX, y: pointY)
            case .Top:
                let pointY = self.bounds.height - self.insetBottom
                let pointX = self.bounds.size.width - self.insetRight
                return CGPoint(x: pointX, y: pointY)
            case .Bottom:
                let pointY = self.insetTop
                let pointX = self.bounds.size.width - self.insetRight
                return CGPoint(x: pointX, y: pointY)
            }
        }
        else{
            switch(self.arrowDirectionEnumValue){
            case .Left:
                let pointY = self.bounds.size.height / 2
                let pointX = self.bounds.size.width - self.insetRight
                return CGPoint(x: pointX, y: pointY)
            case .Right:
                let pointY = self.bounds.size.height / 2
                let pointX = self.insetLeft
                return CGPoint(x: pointX, y: pointY)
            case .Top:
                let pointY = self.bounds.height - self.insetBottom
                let pointX = self.bounds.size.width / 2
                return CGPoint(x: pointX, y: pointY)
            case .Bottom:
                let pointY = self.insetTop
                let pointX = self.bounds.size.width / 2
                return CGPoint(x: pointX, y: pointY)
            }
        }
    }
    
    private func lineLayerPath(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        let path: UIBezierPath = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        return path
    }
    
    private func render()
    {
        self.backgroundColor = self.highlighted ? self.highlightedBackgroundColor : self.normalBackgroundColor
        self.topLineLayer?.strokeColor = self.highlighted ? self.highlightedLineColor.CGColor : self.lineColor.CGColor
        self.bottomLineLayer?.strokeColor = self.highlighted ? self.highlightedLineColor.CGColor : self.lineColor.CGColor
        self.topLineLayer?.lineWidth = self.lineWidth
        self.bottomLineLayer?.lineWidth = self.lineWidth
        self.topLineLayer?.path = self.lineLayerPath(self.startLineLayerPoint, endPoint: self.endTopLineLayerPoint).CGPath
        self.bottomLineLayer?.path = self.lineLayerPath(self.startLineLayerPoint, endPoint: self.endBottomLineLayerPoint).CGPath
    }
    
    private func animateEnableChange()
    {
        var topLineLayerAnimation: POPSpringAnimation = POPSpringAnimation()
        topLineLayerAnimation.toValue = NSValue(CGPoint: self.topLineLayersEndPointForCurrentState())
        topLineLayerAnimation.property = self.topLayerLinePathAnimationProperty()
        topLineLayerAnimation.springBounciness = self.enabled ? 12 : 0
        self.pop_addAnimation(topLineLayerAnimation, forKey: "topLineLayerAnimation")
        
        var bottomLineLayerAnimation: POPSpringAnimation = POPSpringAnimation()
        bottomLineLayerAnimation.toValue = NSValue(CGPoint: self.bottomLineLayersEndPointForCurrentState())
        bottomLineLayerAnimation.property = self.bottomLayerLinePathAnimationProperty()
        bottomLineLayerAnimation.springBounciness = self.enabled ? 12 : 0
        self.pop_addAnimation(bottomLineLayerAnimation, forKey: "bottomLineLayerAnimation")
    }
    
    private func topLayerLinePathAnimationProperty() -> POPAnimatableProperty
    {
        let animatableProperty: POPAnimatableProperty = POPAnimatableProperty.propertyWithName("topLayerLinePathAnimationProperty", initializer: { (prop :POPMutableAnimatableProperty!) -> Void in
            prop.readBlock = {(button: AnyObject!, values: UnsafeMutablePointer<CGFloat>) -> Void in
                let arrowButton: ADArrowButton = button as ADArrowButton!
                values[0] = arrowButton.endTopLineLayerPoint.x
                values[1] = arrowButton.endTopLineLayerPoint.y
            }
            prop.writeBlock = {(button: AnyObject!, values: UnsafePointer<CGFloat>) -> Void in
                let arrowButton: ADArrowButton = button as ADArrowButton!
                arrowButton.endTopLineLayerPoint = CGPoint(x: values[0], y: values[1])
                arrowButton.topLineLayer?.path = arrowButton.lineLayerPath(arrowButton.startLineLayerPoint, endPoint: arrowButton.endTopLineLayerPoint).CGPath
            }
        }) as POPAnimatableProperty
        return animatableProperty
    }
    
    private func bottomLayerLinePathAnimationProperty() -> POPAnimatableProperty
    {
        let animatableProperty: POPAnimatableProperty = POPAnimatableProperty.propertyWithName("bottomLayerLinePathAnimationProperty", initializer: { (prop :POPMutableAnimatableProperty!) -> Void in
            prop.readBlock = {(button: AnyObject!, values: UnsafeMutablePointer<CGFloat>) -> Void in
                let arrowButton: ADArrowButton = button as ADArrowButton!
                values[0] = arrowButton.endBottomLineLayerPoint.x
                values[1] = arrowButton.endBottomLineLayerPoint.y
            }
            prop.writeBlock = {(button: AnyObject!, values: UnsafePointer<CGFloat>) -> Void in
                let arrowButton: ADArrowButton = button as ADArrowButton!
                arrowButton.endBottomLineLayerPoint = CGPoint(x: values[0], y: values[1])
                arrowButton.bottomLineLayer?.path = arrowButton.lineLayerPath(arrowButton.startLineLayerPoint, endPoint: arrowButton.endBottomLineLayerPoint).CGPath
            }
        }) as POPAnimatableProperty
        return animatableProperty
    }
    
    //MARK: - UIControl
    
    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        self.highlighted = true
        self.sendActionsForControlEvents(UIControlEvents.TouchDown)
        return true
    }
    
    public override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        return true
    }
    
    public override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        self.highlighted = false
    }
    
    public override func cancelTrackingWithEvent(event: UIEvent?) {
        self.sendActionsForControlEvents(UIControlEvents.TouchUpOutside)
        self.highlighted = false
    }
    
}
