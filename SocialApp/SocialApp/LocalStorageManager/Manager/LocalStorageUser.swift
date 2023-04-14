//
//  LocalStorageUser.swift
//  SocialApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 13/04/23.
//

import Foundation
import CoreData

final class LocalStorageUser: LocalStorageProtocol {
    
    private let container: NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "Social")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores() { (desc, error) in
            if let error = error {
                print("Error loading store - \(error)")
                return
            }
            print("Database loaded successfully")
        }
    }
    
    func createUser(users: [UserUseCase.Response], completion: @escaping (Result<Data?, Error>) -> Void) {
        let context = container.viewContext
        
        for user in users {
            let userDB = UserDB(context: context)
            userDB.id = Int16(user.id ?? .zero)
            userDB.name = user.name
            userDB.phone = user.phone
            userDB.email = user.email
            
            do {
                try context.save()
            } catch {
                completion(.failure(error))
                print("Error saving user in local storage")
            }
        }
        completion(.success(nil))
    }
    
    func fetchUsers(completion: @escaping (Result<[UserDB], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<UserDB> = UserDB.fetchRequest()
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
