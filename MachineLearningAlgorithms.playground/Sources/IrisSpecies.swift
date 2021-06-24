import Foundation

public enum IrisSpecies: String {
  case setosa, versicolor, virginica
  
  public static func fromString(_ s: String) -> Int {
    switch s {
    case IrisSpecies.setosa.rawValue: return 0
    case IrisSpecies.versicolor.rawValue: return 1
    case IrisSpecies.virginica.rawValue: return 2
    default: return 0
    }
  }
  
  public static func fromLabel(_ l: Int) -> String {
    switch l {
    case 0: return IrisSpecies.setosa.rawValue
    case 1: return IrisSpecies.versicolor.rawValue
    case 2: return IrisSpecies.virginica.rawValue
    default: return IrisSpecies.setosa.rawValue
    }
  }
}
