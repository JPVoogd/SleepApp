//
//  AudioManager.swift
//  SleepMusic
//
//  Created by Jeroen Voogd on 23/04/2023.
//

import Foundation
import AVKit
import SwiftUI
final class AudioManager: ObservableObject {
    static let shared = AudioManager()


    var player: AVAudioPlayer?
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            print("isPLaying", isPlaying)
        }
    }
    @Published var isLooping: Bool = false

    func startPlayer(track: String, isPreview: Bool = false) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("Resource not found: \(track)")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)


            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
            }

        } catch {
            print("Fail to initialize player", error)
        }
    }

    func playPause() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }

        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    func stop() {
        guard let player = player else { return }

        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }

    func fadeOut() {
        guard let player = player else { return }

        if player.isPlaying {
            player.setVolume(0, fadeDuration: 10)
            _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { Timer in
                player.stop()
                self.isPlaying = false
            }

        }
    }

    func toggleLoop() {
        guard let player = player else { return }
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0

        isLooping = player.numberOfLoops != 0
        print("isLoop", isLooping)
        print(player.numberOfLoops)
    }
}


