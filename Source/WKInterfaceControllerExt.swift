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
    public func animate(duration: TimeInterval, animations: @escaping () -> Void) -> Promise<Void> {
        return Promise { fulfill, reject in
            self.animateWithCompletion(duration: duration, animations: animations, completion: { fulfill() })
        }
    }
    
    public func hide(duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return self.hide(duration: duration, interfaceObjects: [interfaceObject])
    }
    
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
    
    public func show(duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return self.show(duration: duration, interfaceObjects: [interfaceObject])
    }
    
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
    
    fileprivate func animateWithCompletion(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void) {
        self.animate(withDuration: duration, animations: animations)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            completion()
        }
    }
}

extension Promise {
    public func animate(in vc: WKInterfaceController, duration: TimeInterval, animations: @escaping () -> Void) -> Promise<Void> {
        return vc.animate(duration: duration, animations: animations)
    }
    
    public func hide(in vc: WKInterfaceController, duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return vc.hide(duration: duration, interfaceObjects: interfaceObject)
    }
    
    public func hide(in vc: WKInterfaceController, duration: TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Void> {
        return vc.hide(duration: duration, interfaceObjects: [interfaceObject])    }
    
    public func show(in vc: WKInterfaceController, duration: TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Void> {
        return vc.show(duration: duration, interfaceObjects: [interfaceObject])
    }
    
    public func show(in vc: WKInterfaceController, duration: TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Void> {
        return vc.show(duration: duration, interfaceObjects: interfaceObjecs)
    }
    
    public func wait(_ duration:TimeInterval) -> Promise<Void> {
        return Promise<Void> { fulfill, reject in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                fulfill()
            }
        }
    }
}
