//
//  ContentView.swift
//  SleepMusic
//
//  Created by Jeroen Voogd on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSettings = false
    @EnvironmentObject var theme: ThemeModel

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(0 ..< Sounds.sounds.count, id: \.self) { index in
                        if index == 0 {
                            Text("Meditation Sounds")
                                .font(Font.custom("MedievalSharp", size: 35))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, -10)
                                .padding(.top, 10)
                        } else if index == 3 {
                            Text("Nature Sounds")
                                .font(Font.custom("MedievalSharp", size: 35))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, -10)
                                .padding(.top, 10)
                        } else if index == 10 {
                            Text("Baby Sounds")
                                .font(Font.custom("MedievalSharp", size: 35))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, -10)
                                .padding(.top, 10)
                        } else if index == 12 {
                            Text("Urban Sounds")
                                .font(Font.custom("MedievalSharp", size: 35))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, -10)
                                .padding(.top, 10)
                        }
                        ButtonsView(index: index)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Hypnos")
            .navigationBarTitleDisplayMode(.automatic)
            .background(Color(red: 24/255, green: 23/255, blue: 22/255))
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Text(Image(systemName: "gearshape"))
                            .accentColor(theme.selectedTheme.accentColor)
                    }
                    .sheet(isPresented: $showingSettings) {
                        NavigationView {
                            SettingsView()
                                .toolbar {
                                    ToolbarItem(placement: .navigation) {
                                        Button(action: {
                                            showingSettings = false
                                        }) {
                                            Text("Done").fontWeight(.semibold)
                                        }
                                    }
                                }
                                .navigationTitle("Settings")
                        }
                        .accentColor(theme.selectedTheme.accentColor)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioManager())
            .environmentObject(ThemeModel())
    }
}
