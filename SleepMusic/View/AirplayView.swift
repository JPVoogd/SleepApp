//
//  AirplayView.swift
//  SleepMusic
//
//  Created by Jeroen Voogd on 11/05/2023.
//

import SwiftUI
import AVKit

struct AirplayView: View {

    var body: some View {
        AirPlayView()
    }
}

struct AirplayView_Previews: PreviewProvider {
    static var previews: some View {
        AirplayView()
    }
}

struct AirPlayView: UIViewRepresentable {
    @EnvironmentObject var dataSource: ThemeModel
    func makeUIView(context: Context) -> UIView {

        let routePickerView = AVRoutePickerView()
        routePickerView.backgroundColor = UIColor.clear
        routePickerView.activeTintColor = dataSource.selectedTheme.textColor
        routePickerView.tintColor = UIColor.white

        return routePickerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}
