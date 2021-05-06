//
//  Member.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

class MemberStore: ObservableObject {
    @Published var members = [Member]()
    
    init() {
        self.members = []
        let brian = Member(firstName: "Brian", lastName: "Seo", email: "wseo7@asu.edu", zipCode: "85286", age: 21, pushNotif: true, profilePic: UIImage(named: "portrait2")!)
        members.append(brian)
    }
}

struct Member: Identifiable{
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var zipCode: String
    var age: Double
    var pushNotif: Bool
    var profilePic: UIImage
    
    init(firstName: String, lastName: String, email: String, zipCode: String, age: Double, pushNotif: Bool, profilePic: UIImage)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.zipCode = zipCode
        self.age = age
        self.pushNotif = pushNotif
        self.id = UUID()
        self.profilePic = profilePic
    }
    
}

