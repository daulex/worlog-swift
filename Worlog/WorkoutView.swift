//
//  WorkoutView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI
import AVFoundation

struct WorkoutView: View {
    @EnvironmentObject var settings: GameSettings
    @State var remainingTime: Int = 0
    @State private var isPaused = false
    let soundPrepareURL = Bundle.main.url(forResource: "beep-prepare", withExtension: "wav")
    let soundGoURL = Bundle.main.url(forResource: "beep-go", withExtension: "wav")
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var audioPlayer: AVAudioPlayer?
    
    var currentStage: WorkoutStages {
        settings.stageTypes[settings.currentStage]
    }
    
    var durationForCurrentStage: Int {
        settings.getDurationForStage(currentStage)
    }
    
    var isLastStage: Bool {
        settings.currentStage == settings.stageTypes.count - 1
    }
    init() {
        // Configure audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            WorkoutContentView(for: currentStage)
            Spacer()
            HStack {
                if !isLastStage {
                    Text("\(remainingTime)")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                
                if isLastStage {
                    Button(action: {
                        attemptStageChange(0)
                    }) {
                        Image(systemName: "restart")
                    }.padding()
                }
                
                Button(action: {
                    attemptStageChange(-1)
                }) {
                    Image(systemName: "backward.fill")
                }.padding()
                
                if !isLastStage {
                    Button(action: {
                        attemptStageChange(1)
                    }) {
                        Image(systemName: "forward.fill")
                    }.padding()
                    
                    Button(action: {
                        isPaused.toggle()
                    }) {
                        Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                    }.padding()
                }
            }
            .onReceive(timer) { _ in
                if !isPaused {
                    if remainingTime != 0 {
                        if remainingTime == 1 {
                            if let url = soundGoURL {
                                playSound(url: url)
                            }
                        }
                        if [4, 3, 2].contains(remainingTime) {
                            if let url = soundPrepareURL {
                                playSound(url: url)
                            }
                        }
                        remainingTime -= 1
                        
                    } else {
                        attemptStageChange(1)
                    }
                }
            }
            .padding()
            
            Text("\(settings.currentStage + 1) of \(settings.stageTypes.count - 1)")
            
        }
        .onAppear {
            attemptStageChange(0)
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
    
    func attemptStageChange(_ direction: Int) {
        if direction == 0 {
            settings.currentStage = 0
        } else {
            let nextStage = settings.currentStage + direction
            if nextStage >= 0 && nextStage < settings.stageTypes.count {
                settings.currentStage = nextStage
            }
        }
        remainingTime = settings.getDurationForStage(settings.stageTypes[settings.currentStage])
    }
    
    func playSound(url: URL) {
        
        // Play sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 1.0 // Adjust the volume as needed
            audioPlayer?.numberOfLoops = 0 // Play the sound only once
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }



}
