//
//  GameSettings.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

final class GameSettings: ObservableObject {
    
    @Published var isRunning: Bool = false
    @Published var currentStage: Int = 0
    
    @Published var startingPunches: Int = 2
    @Published var labelStartingPunches = "Starting punches"
    
    @Published var roundsInSet: Int = 5
    @Published var labelRoundsInSet = "Rounds in set"
    
    @Published var sets: Int = 4
    @Published var labelSets = "Sets"
    
    @Published var noDoubles: Bool = false
    @Published var labelNoDoubles = "Force no double punches"
    
    @Published var alternateArms: Bool = true
    @Published var labelAlternateArms = "Alternate arms"
    
    @Published var increasePunches: Bool = true
    @Published var labelIncreasePunches = "Each round increases punches"
    
    @Published var durationRound: Int = 60
    @Published var labelRoundDuration: String = "seconds in a round"
    @Published var durationShortRest: Int = 30
    @Published var labelShortRest: String = "seconds between rounds"
    @Published var durationLongRest: Int = 5
    @Published var labelLongRest: String = "minutes between sets"
    @Published var duration: Int = 0

    @Published var combination: [Int] = []
    @Published var reps: [[Int]] = []
    @Published var rounds: [[[Int]]] = []
    
    @Published var stageTypes: [WorkoutStages] = []
    @Published var stagePunches: [String] = []
    
    let leftArm = [1,3,5]
    let rightArm = [2,4,6]
    
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
                    if leftArm.contains(newNumber) && leftArm.contains(lastPunch) {
                        newNumber = rightArm.randomElement() ?? 1
                    } else if rightArm.contains(newNumber) && rightArm.contains(lastPunch) {
                        newNumber = leftArm.randomElement() ?? 1
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
            return durationShortRest
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
