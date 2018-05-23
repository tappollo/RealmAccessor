//
//  Result.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/24.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

public enum Result<Value> {
    
    case success(Value)
    case failure(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
    @discardableResult
    public func withValue(_ closure: (Value) -> Void) -> Result {
        if case let .success(value) = self { closure(value) }
        
        return self
    }
    
    @discardableResult
    public func withError(_ closure: (Error) -> Void) -> Result {
        if case let .failure(error) = self { closure(error) }
        
        return self
    }
    
}
