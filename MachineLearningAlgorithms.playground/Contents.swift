import Foundation

let reader = CSVManager()
let dataFrame = reader.read(named: "Iris")


let labels: [Int] = dataFrame.map { row -> Int in
    let label = IrisSpecies.fromString(row[4])
    row.dropLast()
    return label
}

let rowOfClasses = 4
let xTrain = dataFrame.map { row in
  return row.enumerated().filter { $0.offset != rowOfClasses }.map { Double($0.element)! }
}


let knn = KNeighborsClassifier(nNeighbors: 3)
//let (XTrain, XTest, yTrain, yTest) = split(xTrain, labels, testSize: 0.2)

knn.fit(xTrain, labels)

let predictionLabels = knn.predict([[2.0, 2.0, 1.0, 9.3]])
let predictionIrisType = predictionLabels.map({ IrisSpecies.fromLabel($0) })

print(predictionIrisType)
//knn.score(xTest: XTest, yTest: yTest)
