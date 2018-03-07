//
//  FirestoreService.swift
//  Recycler
//
//  Created by Roman Shveda on 3/2/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore


class FirestoreService {
    
    private init(){}
    static let shared = FirestoreService()
    
    
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to collectionReference: RCLCollectionReference) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func add<T: Codable>(for encodableObject: T, in collectionReference: RCLCollectionReference) {
        do{
            let json = try encodableObject.toJson(excluding: ["id"])
            print(json)
            reference(to: collectionReference).addDocument(data: json)
        } catch{
            print(error)
        }

    }
    
    func get<T: Decodable>(from collectionReference: RCLCollectionReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
      reference(to: collectionReference).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("\(error.debugDescription)")
                return
            }
            do {
                var objects = [T]()
                for document in snapshot.documents {
//                    try document.decode(as: objectType.self)

//                    let dict = document.data()
//                    dict["lastName"]
                    print(try document.decode(as: objectType.self))
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            } catch {
                print(error)
            }
        }
        
    }
    
    func update<T: Encodable & Identifiable>(for encodableObject: T, in collectionReference: RCLCollectionReference) {
        do {
            let json = try encodableObject.toJson()
            guard let id = encodableObject.id else { throw myEncodingError.encodingError}
            reference(to: collectionReference).document(id).setData(json)
        } catch {
            print(error)
        }
        
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, in collectionReference: RCLCollectionReference) {
        do {
            guard let id = identifiableObject.id else {throw myEncodingError.encodingError}
            reference(to: collectionReference).document(id).delete()
        } catch {
            print(error)
        }
        
    }
    
    /*--------------------------------Queries----------------------------------------------*/
    
//    func getUserBy(email: String, password: String) -> User {
//
//        let query = reference(to: .users).whereField("email", isEqualTo: email).whereField("password", isEqualTo: password)
//
//        reference(to: .users).document()
//    }
    
}
