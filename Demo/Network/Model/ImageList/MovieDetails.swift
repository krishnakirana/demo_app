/*
 * Copyright 2021 Auro
 * Name of the module - Movie Details
 * Created date - 17/04/21
 * Created by - Krishna Kirana
 * Synopsis - Model to store the movie details
 */

import Foundation

struct MovieDetails: Codable {
    let backdrop_path : String?
    let id : Int?
    let original_title : String?
    let poster_path : String?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case backdrop_path = "backdrop_path"
        case id = "id"
        case original_title = "original_title"
        case poster_path = "poster_path"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
    /**
     Generate the photo URL from photo details
     - RETURNS: Generated photo URL
     */
    func generatePosterPathUrl() -> String {
        guard let poster_path = self.poster_path else {
            return ""
        }
        return "https://image.tmdb.org/t/p/w92" + poster_path
    }
}
