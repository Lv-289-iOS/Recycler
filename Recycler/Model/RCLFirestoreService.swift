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
        
        // todo remove bellow
        
//        let email = "testmail@mail.com"
//        let password = "111111"
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            // ...
//            print(error)
//            print(user)
//        }
//
//
//        Auth.auth().
    }
    
    private func reference(to collectionReference: RCLCollectionReference) -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func create<T: Codable>(for encodableObject: T, in collectionReference: RCLCollectionReference) {
        do{
            let json = try encodableObject.toJson()
            reference(to: collectionReference).addDocument(data: json)
            
        } catch{
            print(error)
        }

    }
    
    func read<T: Decodable>(from collectionReference: RCLCollectionReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
      reference(to: collectionReference).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("\(error.debugDescription)")
                return
            }
            do {
                var objects = [T]()
                for document in snapshot.documents{
                    
                    print(try document.decode(as: objectType))
                    let object = try document.decode(as: objectType)
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
            guard let id = encodableObject.id else { throw MyEncodingError.encodingError}
            reference(to: collectionReference).document(id).setData(json)
        } catch {
            print(error)
        }
        
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, in collectionReference: RCLCollectionReference) {
        do {
            guard let id = identifiableObject.id else {throw MyEncodingError.encodingError}
            reference(to: collectionReference).document(id).delete()
        } catch {
            print(error)
        }
        
    }
    
}
