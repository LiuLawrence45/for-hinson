//
//  HomeView.swift
//  WillowMac
//
//  Created by Lawrence Liu on 2/3/25.
//

import Foundation
import SwiftUI


struct HomeView: View {
    @State var appUser: AppUser
    
    var body: some View {
        VStack {
            Text(appUser.uid)
            
            Text(appUser.email ?? "No email")
        }
    }
}
