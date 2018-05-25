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
    
}
