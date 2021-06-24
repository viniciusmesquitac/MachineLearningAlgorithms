import Foundation

/// Module created to help manager reading data from csv
public class CSVManager {
    
    public init() { }
    /// Description
    /// - Parameter named: name of the file that you wanna read
    /// - Returns: matrix of csv data.
    public func read(named: String) -> [[String]] {
        /*
         Open the CSV file
         */
        guard let csv = Bundle.main.path(forResource: named, ofType: "csv") else {
          print("Resource could not be found!")
          exit(0)
        }
        /*
         Read the CSV file
         */
        guard let content = try? String(contentsOfFile: csv) else {
          print("File could not be read!")
          exit(0)
        }

        /*
         ## Parse the CSV
         split the lines with the character `\n` and create an array
         */
        let rows = content.split(separator: "\n").map { String($0) }

        /*
         split values in row with the character `,` and create an array
         */
        let data = rows.map { row -> [String] in
          let split = row.split(separator: ",")
          return split.map { String($0) }
        }

        return data
    }
}
