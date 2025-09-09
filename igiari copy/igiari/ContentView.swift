import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showFirst = true
    @State private var player: AVAudioPlayer?
    @State private var playCount = 0

    private func playSwitchSound() {
        guard let url = Bundle.main.url(forResource: "igiari", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            playCount += 1
        } catch {
            print("Sound error:", error)
        }
    }

    var body: some View {
        VStack {
            Text("Phoenix Wright has already objected \(playCount) time(s).")
                .font(.headline)
                .padding()
            
            Image(showFirst ? "chengbutang" : "igiari")
                .resizable()
                .scaledToFit()
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if showFirst {
                                showFirst = false
                                playSwitchSound()
                            }
                        }
                        .onEnded { _ in
                            showFirst = true
                        }
                )
        }
    }
}

#Preview {
    ContentView()
}
