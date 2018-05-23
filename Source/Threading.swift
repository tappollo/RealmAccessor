//
//  Threading.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/23.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

import Foundation


private class ThreadOperation: Operation {
    
    let payload: () -> Void
    let thread: Thread
    
    init(thread: Thread, payload: @escaping ()->Void) {
        self.thread = thread
        self.payload = payload
        super.init()
    }
    
    override func main() {
        perform(#selector(runPayload), on: thread, with: nil, waitUntilDone: true)
    }
    
    @objc func runPayload() {
        payload()
    }
}

class ThreadRunner {
    
    let thread: Thread
    let queue: OperationQueue
    
    static let shared = ThreadRunner(name: "Shared")
    static let main = ThreadRunner(thread: Thread.main)

    init(name: String) {
        thread = Thread(block: {
            while true{
                RunLoop.current.run(
                    mode: RunLoopMode.defaultRunLoopMode,
                    before: Date.distantFuture)
            }
        })
        queue = OperationQueue()
        queue.name = name + " Queue"
        thread.name = name + " Thread"
        thread.start()
    }
    
    init(thread: Thread) {
        self.thread = thread
        self.queue = OperationQueue()
    }
    
    func async<T>(_ x: T) -> Async<T> {
        return {cb in self.perform{cb(.success(x))}}
    }

    func perform(_ payload: @escaping ()->Void) {
        let op = ThreadOperation(thread: thread, payload: payload)
        queue.addOperation(op)
    }

}
