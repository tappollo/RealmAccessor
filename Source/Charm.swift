//
//  Charm.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/23.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

typealias Async<T> = (@escaping (Result<T>)->Void)->Void

func unit<T>(_ x: T) -> Async<T> {
    return {$0(.success(x))}
}

precedencegroup Runes {
    associativity: left
    higherThan: TernaryPrecedence
}

// pipe
infix operator |> : Runes

// bind
infix operator >>- : Runes

// fmap
infix operator <^> : Runes

func |><T, U>(x: T, f: (T) throws->U) throws->U {
    return try f(x)
}

func >>-<T, U>(async: @escaping Async<T>, transform: @escaping (T) throws-> Async<U>) -> Async<U> {
    return { (callback: @escaping (Result<U>) -> Void) in
        async{result in
            switch result{
            case .success(let value):
                do{
                    try transform(value)(callback)
                }catch{
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

func <^><T, U>(async: @escaping Async<T>, transform: @escaping (T) throws-> (U)) -> Async<U> {
    return async >>- {unit(try transform($0))}
}


