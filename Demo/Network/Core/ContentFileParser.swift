/*
 * Copyright 2021 Auro
 * Name of the module - Core
 * Created date - 17/04/21
 * Created by - Krishna Kirana
 * Synopsis - File content parser
 */

import Foundation

class ContentFileParser {
    /**
     Function to get data value from the file
     - PARAMETER fileName: Name of the file as `String`
     - PARAMETER fileType: Type of the file as `String`
     - PARAMETER completion: Completion handler to give callback
     */
    func getDataFromFile(fileName: String, fileType: String, completion: @escaping ((Data?) -> Void))  {
        DispatchQueue.global(qos: .background).async {
            if let path = Bundle.main.path(forResource: fileName, ofType: fileType)
            {
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    completion(jsonData)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
