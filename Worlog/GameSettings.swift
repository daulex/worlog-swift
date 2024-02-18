//
//  GameSettings.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

final class GameState: ObservableObject {
    @Published var isRunning: Bool = false
    @Published var currentStage: Int = 0
}

final class GameSettings: ObservableObject {
    
    // Game settings
    @Published var startingPunches: Int = 2 {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var roundsInSet: Int = 5 {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var sets: Int = 4 {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var noDoubles: Bool = false {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var alternateArms: Bool = true {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var increasePunches: Bool = true {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var durationRound: Int = 60 {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var durationShortRest: Int = 30 {
        didSet {
            initWorkoutGeneration()
        }
    }
    @Published var durationLongRest: Int = 5 {
        didSet {
            initWorkoutGeneration()
        }
    }

    @Published var combination: [Int] = []
    @Published var reps: [[Int]] = []
    @Published var rounds: [[[Int]]] = []
    
    @Published var stageTypes: [WorkoutStages] = []
    @Published var stagePunches: [String] = []
    
    @Published var duration: Int = 0

    
    func initWorkoutGeneration(){
        generateRounds()
        calculateDuration()
    }
    
    func calculateDuration(){
        let WorkoutTime: Int = roundsInSet * sets * durationRound
        let RestTime: Int = (roundsInSet - 1) * sets * durationShortRest
        let Breaks: Int = (sets - 1) * ( durationLongRest * 60 )
        self.duration = ( WorkoutTime + RestTime + Breaks ) / 60
    }
    
    func generateRound(increaseBy: Int = 0) {
        var punchesInternal = startingPunches
        if increaseBy != 0 {
            punchesInternal += increaseBy
        }
        
        combination.removeAll()
        for _ in 0..<punchesInternal {
            var newNumber = Int.random(in: 1...6)
            if let lastPunch = combination.last {
                if alternateArms {
                    // next punch must use different arm from previous punch
                    if GameConstants.leftArm.contains(newNumber) && GameConstants.leftArm.contains(lastPunch) {
                        newNumber = GameConstants.rightArm.randomElement() ?? 1
                    } else if GameConstants.rightArm.contains(newNumber) && GameConstants.rightArm.contains(lastPunch) {
                        newNumber = GameConstants.leftArm.randomElement() ?? 1
                    }
                } else if noDoubles && newNumber == lastPunch {
                    newNumber = newNumber == 6 ? 1 : newNumber + 1
                }
            }
            combination.append(newNumber)
        }
    }

    func generateReps(increase: Int = 0) -> [[Int]] {
        reps.removeAll()
        for _ in 0..<roundsInSet {
            if increasePunches {
                generateRound(increaseBy: increase)
            } else {
                generateRound()
            }
            reps.append(combination)
        }
        return reps
    }

    func generateRounds() {
        rounds.removeAll()
        for i in 0..<sets {
            let increase = increasePunches ? i : 0
            rounds.append(generateReps(increase: increase))
        }
    }
    
    func getStagesCount() -> Int {
        return 1 + ( roundsInSet + roundsInSet - 1 ) * sets
    }
    
    func buildStageTypesArray() {
        stageTypes.removeAll()
        stagePunches.removeAll()
        
        let stagesInSet: Int = roundsInSet + roundsInSet - 1
        var tmpPunches: [[Int]] = [[0]]
        
        stageTypes.append(.warmup)
        stagePunches.append("w")
        
        
        for i in 0..<sets {
            tmpPunches = rounds[i]
            for j in 0..<stagesInSet {
                stageTypes.append(j % 2 == 0 ? .round : .shortRest)
                stagePunches.append(j % 2 == 0 ? tmpPunches.removeFirst().map { String($0) }.joined(separator: " ") : "SR")
            }
            
            if i < sets-1 {
                stageTypes.append(.longRest)
                stagePunches.append("LR")
            }
        }
        
        stageTypes.append(.finished)
        stagePunches.append("f")
    }
    
    func getDurationForStage(_ stageType: WorkoutStages) -> Int {
        switch stageType {
        case .warmup:
            return durationShortRest / 2
        case .round:
            return durationRound
        case .shortRest:
            return durationShortRest
        case .longRest:
            return durationLongRest * 60
        case .finished:
            return 0
        }
    }

}

enum WorkoutStages {
    case warmup
    case round
    case shortRest
    case longRest
    case finished
}

struct GameConstants {
    static let leftArm = [1, 3, 5]
    static let rightArm = [2, 4, 6]
}
