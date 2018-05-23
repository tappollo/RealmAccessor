//
//  DBAccess.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/23.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

import RealmSwift

let DBRunner = ThreadRunner(name: "Database")

func getRealm(_ callback: @escaping (Result<Realm>) -> Void) -> Void {
    DBRunner.perform {
        do{
            callback(.success(try Realm()))
        }catch{
            callback(.failure(error))
        }
    }
}

