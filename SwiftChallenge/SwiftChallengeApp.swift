//
//  SwiftChallengeApp.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

@main
struct SwiftChallengeApp: App {
    var members = MemberStore()
    
    var body: some Scene {
        WindowGroup {
            MemberCardView()
                .environmentObject(members)
        }
    }
}
