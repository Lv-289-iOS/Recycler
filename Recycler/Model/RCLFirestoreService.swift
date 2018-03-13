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
            let json = try encodableObject.toJson(excluding: ["id"])
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
    
    func getDocumentById<T: Decodable & Identifiable>(from collectionReference: RCLCollectionReference, returning objectType: T.Type, id: String, completion: @escaping (T?) -> Void){
        reference(to: collectionReference).document(id).getDocument { (document, error) in
            guard let document = document else {print(error.debugDescription)
                return
            }
            let object = try? document.decode(as: objectType.self)
            completion(object)
            return
        }
        completion(nil)
    }

    func getUserBy(email: String, completion: @escaping (User?) -> Void){
        reference(to: .users)
            .whereField("email", isEqualTo: email)
            .limit(to: 1)
            .addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {return print(error.debugDescription)}
                for document in snapshot.documents{
                    let user = try? document.decode(as: User.self)
                    completion(user)
                }
                completion(nil)
        }
    }
    
    func getTrashCansBy(userId: String, completion: @escaping ([TrashCan]) -> Void) {
        reference(to: .trash).whereField("userId", isEqualTo: userId).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {return print(error.debugDescription)}
            var trashCanList = [TrashCan]()
            for document in snapshot.documents{
                let trashCan = try? document.decode(as: TrashCan.self)
                if let obj = trashCan{
                trashCanList.append(obj)
                }
            }
            completion(trashCanList)
        }
    }
    
    func getTrashBy(trashCanId: String, completion: @escaping ([Trash]) -> Void) {
        reference(to: .trash).whereField("trashCanId", isEqualTo: trashCanId).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {print(error.debugDescription)
                return}
            var trashList = [Trash]()
            for document in snapshot.documents {
                let trash = try? document.decode(as: Trash.self)
                if let obj = trash{
                    trashList.append(obj)
                }
            }
            completion(trashList)
        }
    }
    
    func getTrashBy(userIdReportedFull: String, completion: @escaping ([Trash]) -> Void) {
        reference(to: .trash).whereField("userIdReportedFull", isEqualTo: userIdReportedFull).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {print(error.debugDescription)
                return}
            var trashList = [Trash]()
            for document in snapshot.documents {
                let trash = try? document.decode(as: Trash.self)
                if let obj = trash{
                    trashList.append(obj)
                }
            }
            completion(trashList)
        }
    }
    
//    func getTrashBy(day: Date, completion: @escaping ([Trash]) -> Void) {
//        reference(to: .trash).whereField(<#T##field: String##String#>, isEqualTo: <#T##Any#>)
//    }
    
    func getLatestTrashBy(trashCanId: String, completion: @escaping (Trash?) -> Void) {
        reference(to: .trash)
            .whereField("trashCanId", isEqualTo: trashCanId)
            .order(by: "dateReportedFull", descending: true)
            .limit(to: 1)
            .addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {print(error.debugDescription)
                return
            }
            for document in snapshot.documents {
                let trash = try? document.decode(as: Trash.self)
                completion(trash)
                return
            }
            completion(nil)
        }
    }
    
    
    
    
}
