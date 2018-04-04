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
        reference(to: .trashCan).whereField("userId", isEqualTo: userId).addSnapshotListener { (snapshot, error) in
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
    

    func getTrashBy(oneMonth: Date, completion: @escaping ([Trash]) -> Void) {
        var components = DateComponents()
        let calendar = Calendar.current
        components.year = calendar.component(.year, from: oneMonth)
        components.month = calendar.component(.month, from: oneMonth) + 1
        let dateLess = calendar.date(from: components)
        guard let secondDate = dateLess else {return}
        let first = oneMonth.timeIntervalSinceReferenceDate as Double
        let second = secondDate.timeIntervalSinceReferenceDate as Double
        reference(to: .trash)
        .whereField("dateReportedFull", isGreaterThan: first)
            .whereField("dateReportedFull", isLessThan: second).addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {return}
                var trashList = [Trash]()
                for document in snapshot.documents{
                    let trash = try? document.decode(as: Trash.self)
                    if let obj = trash{
                        trashList.append(obj)
                    }
                }
                completion(trashList)
        }
    }
    
    func getTrashBy(oneYear: Date, completion: @escaping ([Trash]) -> Void) {
        var components = DateComponents()
        let calendar = Calendar.current
        components.year = calendar.component(.year, from: oneYear) + 1
        let dateLess = calendar.date(from: components)
        guard let secondDate = dateLess else {return}
        let first = oneYear.timeIntervalSinceReferenceDate as Double
        let second = secondDate.timeIntervalSinceReferenceDate as Double
        reference(to: .trash)
            .whereField("dateReportedFull", isGreaterThan: first)
            .whereField("dateReportedFull", isLessThan: second).addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {return}
                var trashList = [Trash]()
                for document in snapshot.documents{
                    let trash = try? document.decode(as: Trash.self)
                    if let obj = trash{
                        trashList.append(obj)
                    }
                }
                completion(trashList)
        }
    }
    
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

    func getTrashbyStatus(status: RCLTrashStatus, completion: @escaping ([Trash]) -> Void) {
        reference(to: .trash).whereField("status", isEqualTo: status.rawValue).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            do {
                var trashList = [Trash]()
                for document in snapshot.documents {
                    let object = try document.decode(as: Trash.self)
                    trashList.append(object)
                }
                completion(trashList)
            } catch {
                print(error)
            }
        }
    }
    
    func getDataForEmployer(status: RCLTrashStatus, userId: String? = nil, completion: @escaping ([(Trash,TrashCan,User)]) -> Void) {
        let query: Query?
        if let id = userId {
             query = reference(to: .trash).whereField("status", isEqualTo: status.rawValue).whereField("userIdReportedEmpty", isEqualTo: id)
        }else {
           query = reference(to: .trash).whereField("status", isEqualTo: status.rawValue)
        }
        query?.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            let group = DispatchGroup()
            var data = [(Trash,TrashCan,User)]()
            for document in snapshot.documents {
                group.enter()
                let trash = try? document.decode(as: Trash.self)
                guard let unTrash = trash else{
                    group.leave()
                    return
                }
                self.reference(to: .trashCan).document(unTrash.trashCanId).getDocument(completion: { (snapshot, error) in
                guard let snapshot = snapshot else {return}
                let trashCan = try? snapshot.decode(as: TrashCan.self)
                    guard let unTrashCan = trashCan else {
                        group.leave()
                        return
                    }
                    self.reference(to: .users).document(unTrash.userIdReportedFull).getDocument(completion: { (snapshot, error) in
                        guard let snapshot = snapshot else {return}
                        let user = try? snapshot.decode(as: User.self)
                        guard let unUser = user else {
                            group.leave()
                            return
                        }
                        data.append((unTrash,unTrashCan,unUser))
                        group.leave()
                    })
                })
            }
            group.notify(queue: .main, execute: {
                completion(data)
            })
        }
    }
    
}
