import Foundation
protocol GameProtocol {
    var score : Int { get } // количество очков заработанных пользователем за все завершенные раунды игры
    var currentSecretValue: Int { get } // содержит текущее загаданное программой число
    var isGameEnded: Bool { get } // флаг следящий за окончанием игры
    
    func restartGame()          //перезапускает игру
    func startNewRound()         //начать новый раунд
    func calculateScore(with value: Int) //подсчитывает количество очков
}

class Game: GameProtocol {
   private var minSecretValue: Int
   private var maxSecretValue: Int
    var score: Int = 0
    var currentSecretValue: Int = 0
    private var lastRound: Int
    private var currentRound: Int = 1
    
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
            
        }
    }
    init?(startValue: Int, endValue: Int, rounds: Int) {
        guard startValue <= endValue else { return nil }
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = endValue
        currentRound = self.getNewValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentSecretValue = self.getNewValue()
        currentRound += 1
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
    private func getNewValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
    
}
