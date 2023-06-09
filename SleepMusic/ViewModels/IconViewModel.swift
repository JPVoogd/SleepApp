//
//  IconManager.swift
//  SleepMusic
//
//  Created by Jeroen Voogd on 17/05/2023.
//

import Foundation
import UIKit



final class ChangeAppIconViewModel: ObservableObject {

    @Published private(set) var selectedAppIcon: AppIcon

    init() {
        if let iconName = UIApplication.shared.alternateIconName, let appIcon = AppIcon(rawValue: iconName) {
            selectedAppIcon = appIcon
        } else {
            selectedAppIcon = .primary
        }
    }

    enum AppIcon: String, CaseIterable, Identifiable {
        case primary = "AppIcon"
        case blue = "AppIcon-Blue"
        case darkBlue = "AppIcon-DBlue"
        case green = "AppIcon-Green"
        case yellow = "AppIcon-Yellow"
        case red = "AppIcon-Red"

        var id: String { rawValue }
        var iconName: String? {
            switch self {
                case .primary:
                    /// `nil` is used to reset the app icon back to its primary icon.
                    return nil
                case .blue:
                    return "AppIcon-Blue"
                case .darkBlue:
                    return "AppIcon-DBlue"
                case .green:
                    return "AppIcon-Green"
                case .yellow:
                    return "AppIcon-Yellow"
                case .red:
                    return "AppIcon-Red"
            }
        }

        var description: String {
            switch self {
                case .primary:
                    return "Default"
                case .blue:
                    return "Blue"
                case .darkBlue:
                    return "Dark Blue"
                case .green:
                    return "Green"
                case .yellow:
                    return "Yellow"
                case .red:
                    return "Red"
            }
        }

        var preview: UIImage {
            UIImage(named: rawValue + "-Preview") ?? UIImage()
        }
    }

    func updateAppIcon(to icon: AppIcon) {
        let previousAppIcon = selectedAppIcon
        selectedAppIcon = icon

        Task { @MainActor in
            guard UIApplication.shared.alternateIconName != icon.iconName else {
                /// No need to update since we're already using this icon.
                return
            }

            do {
                try await UIApplication.shared.setAlternateIconName(icon.iconName)
            } catch {
                /// We're only logging the error here and not actively handling the app icon failure
                /// since it's very unlikely to fail.
                print("Updating icon to \(String(describing: icon.iconName)) failed.")

                /// Restore previous app icon
                selectedAppIcon = previousAppIcon
            }
        }
    }
}
