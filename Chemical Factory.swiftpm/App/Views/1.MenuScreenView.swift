//
//  File.swift
//  Chemical Factory
//
//  Created by Daniella Onishi on 23/04/22.
//

import Foundation
import SwiftUI
import SpriteKit

struct MenuScreenView: View {
    @State var navigated = false
    
    var body: some View {
        
        VStack {
            NavigationLink(isActive: $navigated, destination: {
                WelcomeScreenView()
            }) {
                EmptyView()
            }
            SpriteView(scene: MenuScreen.buildScene(performNavigation: {
                navigated = true
            }))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
