//
//  MealDetailViewModel.swift
//  Fetch-Project
//
//  Created by Shiva on 6/18/24.
//

import Foundation
import Alamofire

class MealDetailViewModel {
    var mealDetail: MealDetail?
    
    func fetchMealDetail(by id: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        let url = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        AF.request(url).responseDecodable(of: [String: [MealDetail]].self) { response in
            switch response.result {
            case .success(let value):
                self.mealDetail = value["meals"]?.first
                if let mealDetail = self.mealDetail {
                    completion(.success(mealDetail))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Meal details not found"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
