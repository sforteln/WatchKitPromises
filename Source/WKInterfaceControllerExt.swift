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
    func animate(duration:TimeInterval, animations: @escaping () -> Void) -> Promise<Bool> {
        return Promise { fulfill, reject in
            self.animateWithCompletion(duration: duration, animations: animations, completion:{ fulfill(true) })
        }
    }
    
    func hide(duration:TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Bool> {
        return self.hide(duration: duration, interfaceObjects: [interfaceObject])
    }
    
    func hide(duration:TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Bool> {
        return Promise { fulfill, reject in
            self.animateWithCompletion(duration: duration,
                                       animations: {
                                            interfaceObjects.forEach { $0.setAlpha(0) }
                                        },
                                       completion:{
                                            interfaceObjects.forEach { $0.setHidden(true) }
                                            fulfill(true)
                                        })
        }
    }
    
    func show(duration:TimeInterval, interfaceObject: WKInterfaceObject) -> Promise<Bool> {
        return self.show(duration: duration, interfaceObjects: [interfaceObject])
    }
    
    func show(duration:TimeInterval, interfaceObjects: [WKInterfaceObject]) -> Promise<Bool> {
        return Promise { fulfill, reject in
            interfaceObjects.forEach { $0.setHidden(false) }
            self.animateWithCompletion(duration: duration,
                                       animations: {
                                        interfaceObjects.forEach { $0.setAlpha(1) }
                                        },
                                       completion:{
                                        fulfill(true)
                                        })
        }
    }
    
    fileprivate func animateWithCompletion(duration: TimeInterval, animations: @escaping () -> Void, completion: @escaping () -> Void) {
        self.animate(withDuration: duration, animations: animations)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: {
            completion()
        })
    }
}

extension Promise {
    func animate(in vc: WKInterfaceController, duration:TimeInterval, animations: @escaping () -> Void) -> Promise<Bool> {
        return vc.animate(duration: duration, animations: animations)
    }
    
    
}
