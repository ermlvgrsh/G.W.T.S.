import Foundation
//создаем протокол через который свяжем VC с SS
protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}

final class StatisticServiceImplementation: StatisticService {
    
    
    //создаем энум для удобной работы с userDefaults
   private enum Keys: String {
        case gamesCount, correct, total, bestGame
    }
    
    var totalAccuracy: Double {
        get {
            return (Double(self.correct)/Double(self.total) * 100)
        }
    }
    
    //создаем переменную для хранения данных на устройстве
    private let userDefaults = UserDefaults.standard
    
    private(set) var correct: Int {
        get {
            let correctAnswers = userDefaults.integer(forKey: Keys.correct.rawValue)
            return correctAnswers
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    private(set) var total: Int {
        get {
            let totalCorrectAnswers = userDefaults.integer(forKey: Keys.total.rawValue)
                return totalCorrectAnswers
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    private(set) var gamesCount: Int {
        get {
            let gamesCount = userDefaults.integer(forKey: Keys.gamesCount.rawValue)
            return gamesCount
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    private(set) var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Impossible to upload data")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    func store(correct count: Int, total amount: Int) {
        self.correct += 1
        self.total += 1
        self.gamesCount += 1
        let counter = GameRecord(correct: count, total: amount, date: Date())
        if bestGame.compare(count: counter) {
            bestGame = counter
        }
    }
    
}

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func compare(count: GameRecord) -> Bool {
        if count.correct > self.correct {
            return true
        } else {
            return false
        }
        
    }
    
}
