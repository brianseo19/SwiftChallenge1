//
//  Member.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

class MemberStore: ObservableObject {
    @Published var members = [Member]()
    
    func addMember(firstName: String, lastName: String, email: String, zipCode: String, age: Double, pushNotif: Bool) -> Void {
        let newMember = Member(firstName: firstName, lastName: lastName, email: email, zipCode: zipCode, age: age, pushNotif: pushNotif)
        members.append(newMember)
    }
}

class Member: Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var zipCode: String
    var age: Double
    var pushNotif: Bool
    
    init(firstName: String, lastName: String, email: String, zipCode: String, age: Double, pushNotif: Bool)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.zipCode = zipCode
        self.age = age
        self.pushNotif = pushNotif
        self.id = UUID()
    }
    
}

