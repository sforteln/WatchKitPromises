//
//  WKInterfaceControllerExt.swift
//  WatchAnimationPromises
//
//  Created by Simon Fortelny on 7/5/17.
//  Copyright © 2017 Simon Fortelny. All rights reserved.
//

import WatchKit
import PromiseKit

extension WKInterfaceController {
    
    /// Animate WKInterfaceObjects contained in this InterfaceController.
    ///
    /// - Parameters:
    ///   - duration: Duration of animation(s)
    ///   - animations: Standard closure containing animations
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func animate(duration: TimeInterval, animations: @escaping () -> Void) -> Promise<Void> {
        return Promise { fulfill, reject in
            self.animateWithCompletion(duration: duration, animations: animations, completion: { fulfill() })
        }
    }
    
    /// Hide the interface object. First its alpha will be animated to zero then it will be hidden
    ///
    /// - Parameters:
    ///   - duration: duration of animation(s)
    ///   - interfaceObject: interface object that will be hidden
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func hide(duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return self.hide(duration: duration, interfaceObjects: [interfaceObject])
    }
    
    /// Hide the interface objects. First its alpha will be animated to zero then it will be hidden
    ///
    /// - Parameters:
    ///   - duration: duration of animation(s)
    ///   - interfaceObjects: an array of interface objects that will be hidden
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func hide(duration: TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Void> {
        return Promise { fulfill, reject in
            self.animateWithCompletion(duration: duration, animations: {
                                            interfaceObjects.forEach { $0.setAlpha(0) }
                                        }, completion:{
                                            interfaceObjects.forEach { $0.setHidden(true) }
                                            fulfill()
                                        })
        }
    }
    
    /// Show the interface objects. First its hidden property will be set to true then its alpha will be animated to one
    ///
    /// - Parameters:
    ///   - duration: duration of animation(s)
    ///   - interfaceObject: interface object that will be made visible
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func show(duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return self.show(duration: duration, interfaceObjects: [interfaceObject])
    }
    
    /// Show the interface objects. First its hidden property will be set to true then its alpha will be animated to one
    ///
    /// - Parameters:
    ///   - duration: duration of animation(s)
    ///   - interfaceObjects: an array of interface objects that will be made visible
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func show(duration: TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Void> {
        return Promise { fulfill, reject in
            interfaceObjects.forEach { $0.setHidden(false) }
            self.animateWithCompletion(duration: duration, animations: {
                                            interfaceObjects.forEach { $0.setAlpha(1) }
                                        }, completion:{
                                            fulfill()
                                        })
        }
    }
    
    /// Add an animation with 'completion closure' function to WKInterfaceController
    ///
    /// - Parameters:
    ///   - duration: duration of animation(s)
    ///   - animations: animation closure
    ///   - completion: completion closure
    /// - Returns: Void
    fileprivate func animateWithCompletion(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void) {
        self.animate(withDuration: duration, animations: animations)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            completion()
        }
    }
}

extension Promise {
    /// Animate WKInterfaceObjects contained in the InterfaceController.
    ///
    /// - Parameters:
    ///   - in: WKInterfaceController that contains the WKInterfaceObjects that will be animated.
    ///   - duration: Duration of animation(s)
    ///   - animations: Standard closure containing animations
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func animate(in vc: WKInterfaceController, duration: TimeInterval, animations: @escaping () -> Void) -> Promise<Void> {
        return vc.animate(duration: duration, animations: animations)
    }
    
    /// Hide the interface object. First its alpha will be animated to zero then it will be hidden
    ///
    /// - Parameters:
    ///   - in: WKInterfaceController that contains the WKInterfaceObjects that will be animated.
    ///   - duration: duration of animation(s)
    ///   - interfaceObject: interface object that will be hidden
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func hide(in vc: WKInterfaceController, duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return vc.hide(duration: duration, interfaceObject: interfaceObject)
    }
    /// Hide the interface objects. First its alpha will be animated to zero then it will be hidden
    ///
    /// - Parameters:
    ///   - in: WKInterfaceController that contains the WKInterfaceObjects that will be animated.
    ///   - duration: duration of animation(s)
    ///   - interfaceObjects: an array of interface objects that will be hidden
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func hide(in vc: WKInterfaceController, duration: TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Void> {
        return vc.hide(duration: duration, interfaceObjects: interfaceObjects)    }
    /// Show the interface objects. First its hidden property will be set to true then its alpha will be animated to one
    ///
    /// - Parameters:
    ///   - in: WKInterfaceController that contains the WKInterfaceObjects that will be animated.
    ///   - duration: duration of animation(s)
    ///   - interfaceObject: interface object that will be made visible
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func show(in vc: WKInterfaceController, duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return vc.show(duration: duration, interfaceObject: interfaceObject)
    }
    /// Show the interface objects. First its hidden property will be set to true then its alpha will be animated to one
    ///
    /// - Parameters:
    ///   - duration: duration of animation(s)
    ///   - interfaceObjects: an array of interface objects that will be made visible
    /// - Returns: Promise that will be fullfilled when the animation is complete
    public func show(in vc: WKInterfaceController, duration: TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Void> {
        return vc.show(duration: duration, interfaceObjects: interfaceObjects)
    }
    /// Wait the specified time and then fullfill the returned Promise.
    ///
    /// - Parameters:
    ///   - duration: duration to wait in seconds
    /// - Returns: Promise that will be fullfilled when specified time has elapsed.
    public func wait(_ duration:TimeInterval) -> Promise<Void> {
        return Promise<Void> { fulfill, reject in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                fulfill()
            }
        }
    }
}
