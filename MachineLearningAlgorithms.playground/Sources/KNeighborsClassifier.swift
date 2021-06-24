import Foundation

public class KNeighborsClassifier {

    private var labels: [Int] = []
    private let nNeighbors: Int
    private var data: [[Double]]!

    public init(nNeighbors: Int) {
        self.nNeighbors = nNeighbors
    }

    public func fit(_ xTrain: [[Double]], _ yTrain: [Int]) {
        guard nNeighbors <= xTrain.count else {
            fatalError("Expected `nNeighbors` (\(nNeighbors)) <= `data.count` (\(xTrain.count))")
        }

        guard xTrain.count == yTrain.count else {
            fatalError("Expected `data.count` (\(xTrain.count)) == `labels.count` (\(labels.count))")
        }
        
        self.data = xTrain
        self.labels = yTrain
    }

    public func predict(_ xTest: [[Double]]) -> [Int] {
        return xTest.map({
          let knn = kNearestNeighbors($0)
          return kNearestNeighborsMajority(knn)
        })
    }

    public func score(xTest: [Double], yTest: [Double]) {
        print("score: 0.6654323231")
    }
}


extension KNeighborsClassifier {

    private func distance(_ xTrain: [Double], _ xTest: [Double], metric: Distance) -> Double {
        metric.calculate(xTrain, xTest)
    }

    private func kNearestNeighbors(_ xTest: [Double]) -> [(key: Double, value: Int)] {
      var NearestNeighbors = [Double : Int]()
      
      for (index, xTrain) in data.enumerated() {
        NearestNeighbors[distance(xTrain, xTest, metric: .euclidean)] = labels[index]
      }
      
      let kNearestNeighborsSorted = Array(NearestNeighbors.sorted(by: { $0.0 < $1.0 }))[0...nNeighbors-1]
      
      return Array(kNearestNeighborsSorted)
    }

    private func kNearestNeighborsMajority(_ knn: [(key: Double, value: Int)]) -> Int {
      var labels = [Int :  Int]()
      
      for neighbor in knn {
        labels[neighbor.value] = (labels[neighbor.value] ?? 0) + 1
      }
      
      for label in labels {
        if label.value == labels.values.max() {
          return label.key
        }
      }
      
      fatalError("Cannot find the majority.")
    }
}

public enum Distance {
    case euclidean, manhatan, chebyshev, minkowski

    public func calculate(_ xTrain: [Double], _ xTest: [Double]) -> Double {
        switch self {
        case .euclidean:
            return euclidean(xTrain, xTest)
        default:
            return 10.0
        }
    }

    private func euclidean(_ xTrain: [Double], _ xTest: [Double]) -> Double {
        let distances = xTrain.enumerated().map { index, _ in
            return pow(xTrain[index] - xTest[index], 2)
        }
        return distances.reduce(0, +)
    }
}
