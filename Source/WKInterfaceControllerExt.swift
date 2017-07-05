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
            self.animate(withDuration: duration, animations: animations)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: {
                fulfill(true)
            })
        }
    }
}

extension Promise {
    func thenAnimate(in vc: WKInterfaceController, duration:TimeInterval, animations: @escaping () -> Void) -> Promise<Bool> {
        return Promise<Bool> { fulfill, reject in
            vc.animate(withDuration: duration, animations: animations)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: {
                fulfill(true)
            })
        }
    }
}
