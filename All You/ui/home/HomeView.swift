//
//  HomeView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import SwiftUI
import AnimatedTabBar

struct HomeView: View {
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex){
                FrontView()
                    .tag(0)
                ChatView()
                    .tag(1)
                AlterView()
                    .tag(2)
                SettingsView()
                    .tag(3)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            AnimatedTabBar(selectedIndex: $selectedIndex) {
                VStack {
                    Image(systemName: "person.fill")
                    Text("Front")
                }
                VStack {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
                VStack {
                    Image(systemName: "person.2.fill")
                    Text("Alters")
                }
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
            .barColor(Color.tertiaryContainer)
            .selectedColor(Color.onTertiaryContainer)
            .ballColor(Color.onTertiaryContainer)
            .unselectedColor(Color.secondaryColor)
        }
        .background(Color.tertiaryContainer)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeView()
                .preferredColorScheme($0)
        }
    }
}
