//
//  SettingsView.swift
//  SleepMusic
//
//  Created by Jeroen Voogd on 11/05/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataSource: ThemeModel
    @Environment(\.openURL) var openURL

    func mailto(_ email: String, _ subject: String) {
        let mailto = "mailto:\(email)?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(mailto ?? "")
        if let url = URL(string: mailto!) {
            openURL(url)
        }
    }

    var body: some View {
        VStack {
            List {
                Section {
                    NavigationLink(destination: ThemeView()) {
                        Label("Accent Color", systemImage: "theatermask.and.paintbrush")
                    }
                    NavigationLink(destination: AppIconView()) {
                        Label("App Icons", systemImage: "app")
                    }
                } header: {
                    Text("Appearance")
                }

                Section {

                    ShareLink(item: URL(string: "https://apps.apple.com/us/app/hypnos-relax-and-sleep/id6449865547")!) {
                        Label {
                            Text("Share Hypnos")
                                .foregroundColor(.white)
                            Spacer()
                                Image(systemName: "arrow.up.forward")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        } icon: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }

                    Button {
                        openURL(URL(string: "https://apps.apple.com/us/app/hypnos-relax-and-sleep/id6449865547")!)
                    } label: {
                        Label {
                            Text("Rate in App store")
                                .foregroundColor(.white)
                            Spacer()
                                Image(systemName: "arrow.up.forward")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        } icon: {
                            Image(systemName: "star.bubble")
                        }
                    }

                    NavigationLink(destination: TipView()) {
                        Label("Tip Jar", systemImage: "hands.clap")
                    }

                    Button {
                        mailto("jpvoogd@icloud.com", "Support Hypnos")
                    } label: {
                        Label {
                            Text("Contact")
                                .foregroundColor(.white)
                            Spacer()
                                Image(systemName: "arrow.up.forward")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        } icon: {
                            Image(systemName: "envelope")
                        }
                    }

                    NavigationLink(destination: Privacyview()) {
                        Label("Privacy Policy", systemImage: "doc.plaintext")
                    }

                    Button {
                        openURL(URL(string: "https://www.jpvoogd.nl")!)
                    } label: {
                        Label {
                            Text("Website")
                                .foregroundColor(.white)
                            Spacer()
                                Image(systemName: "arrow.up.forward")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        } icon: {
                            Image(systemName: "safari")
                        }
                    }

                    NavigationLink(destination: AboutView()) {
                        Label("About", systemImage: "person.crop.circle")
                    }

                } header: {
                    Text("Support")
                }
            } .listStyle(InsetGroupedListStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ThemeModel())
    }
}
