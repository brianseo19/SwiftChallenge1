//
//  SwiftChallengeApp.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 3/19/21.
//

import SwiftUI

@main
struct SwiftChallengeApp: App {
    @StateObject var memberStore = MemberStore()
    
    var body: some Scene {
        WindowGroup {
            MemberCardView()
                .environmentObject(memberStore)
        }
    }
}
