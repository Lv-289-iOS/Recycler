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
    
    func getUserBy(id: String, completion: @escaping (User) -> Void){
        reference(to: .users).document(id).getDocument { (document, error) in
            guard let document = document else {print(error.debugDescription)
                return}
            do {
                let user = try document.decode(as: User.self)
                completion(user)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getUserBy(email: String, completion: @escaping (User) -> Void){
        reference(to: .users).whereField("email", isEqualTo: email).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {return print(error.debugDescription)}
            for document in snapshot.documents{
                do {
                    let user = try document.decode(as: User.self)
                    completion(user)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }

    }
    
    func getTrashCanBy(id: String, completion: @escaping (TrashCan) -> Void) {
        reference(to: .trashCan).document(id).getDocument { (document, error) in
            guard let document = document else {print(error.debugDescription)
                return
            }
            do {
                let trashCan = try document.decode(as: TrashCan.self)
                completion(trashCan)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    func getLatestTrashBy(trashCanId: String, completion: @escaping (Trash) -> Void) {
//        reference(to: .trash).whereField("trashCanId", isEqualTo: trashCanId).whereField("dateReportedFull", isLessThanOrEqualTo: ).addSnapshotListener { (snapshot, error) in
//            guard let snapshot = snapshot else {print(error.debugDescription)
//                return
//            }
//            for document in snapshot.documents {
//                do {
//                    let trash = try document.decode(as: Trash.self)
//                    completion(trash)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
    
    
    
    
}
