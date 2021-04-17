/*
 * Copyright 2021 Auro
 * Name of the module - Image List
 * Created date - 17/04/21
 * Created by - Krishna Kirana
 * Synopsis - View model for image list
 */

import Foundation

protocol ImageListProtocol: class {
    func gallaryDetailsUpdated()
}

class ImageListViewModel {
    
    private weak var delegate: ImageListProtocol?
    var movieDetailsList: [MovieDetails]?
    
    /**
     Default initializer
     - PARAMETER delegate: Image List Protocol
     */
    init(delegate: ImageListProtocol) {
        self.delegate = delegate
    }
    
    /**
     Get gallary details
     */
    func getGallaryDetails() {
        let contentFileParser = ContentFileParser()
        contentFileParser.getDataFromFile(fileName: "movies", fileType: "json") { [weak self] (jsonData) in
            
            guard let jsonData = jsonData else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let movieDetails = try jsonDecoder.decode([MovieDetails].self, from: jsonData)
                self?.movieDetailsList = movieDetails
                print(movieDetails)
            } catch {
                print("Error")
            }
            
            self?.delegate?.gallaryDetailsUpdated()
        }
    }
}


