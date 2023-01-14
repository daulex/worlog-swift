//
//  ContentViewModel.swift
//  Worlog
//
//  Created by Kirills Galenko on 12/01/2023.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
   
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
    
    @Published var roundDuration: Int = 60
    @Published var labelRoundDuration: String = "seconds in a round"
    @Published var restDuration: Int = 30
    @Published var labelRestDuration: String = "seconds between rounds"
    @Published var breakDuration: Int = 5
    @Published var labelBreakDuration: String = "minutes between sets"
    @Published var workoutDuration: Int = 0

    @Published var combination: [Int] = []
    @Published var reps: [[Int]] = []
    @Published var rounds: [[[Int]]] = []
    
    let leftArm = [1,3,5]
    let rightArm = [2,4,6]
// Todo? rework arms to sets instead of arrays?
//    let leftArm: Set<Int> = [1,3,5]
//    let rightArm: Set<Int> = [2,4,6]
    func calculateWorkoutDuration(){
        let WorkoutTime: Int = roundsInSet * sets * roundDuration
        let RestTime: Int = (roundsInSet - 1) * sets * restDuration
        let Breaks: Int = (sets - 1) * ( breakDuration * 60 )
        self.workoutDuration = ( WorkoutTime + RestTime + Breaks ) / 60
    }
    
    func initWorkoutGeneration(){
        generateRounds()
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
    
}
