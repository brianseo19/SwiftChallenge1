//
//  ListView.swift
//  SwiftChallenge
//
//  Created by Brian Seo on 4/19/21.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var memberStore: MemberStore
    var body: some View {
        NavigationView {
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(MemberStore())
        
    }
}

