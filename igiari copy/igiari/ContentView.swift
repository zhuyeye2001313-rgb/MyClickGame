import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showFirst = true
    @State private var player: AVAudioPlayer?
    @State private var playCount = 0
    @State private var currentPartnerIndex = 0
    
    private let partnerImages = ["who", "Mia Fey", "Maya Fey", "Miles Edgeworth", "Pearl Fey", "Keisuke Itonokogiri", "Mei Karuma"]

    private func playSwitchSound() {
        guard let url = Bundle.main.url(forResource: "igiari", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            playCount += 1
            
            if playCount % 10 == 0 {
                currentPartnerIndex = (currentPartnerIndex + 1) % partnerImages.count
            }
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
            
            Spacer()
            
            VStack {
                Text("As Phoenix Wright continued to handle cases,")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Text("\(partnerImages[currentPartnerIndex]) became his partner.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Image(partnerImages[currentPartnerIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
