//
//  MealListViewModel.swift
//  Fetch-Project
//
//  Created by Shiva on 6/18/24.
//

import Foundation
import Alamofire

class MealListViewModel {
    var meals: [Meal] = []
    
    func fetchMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let url = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        AF.request(url).responseDecodable(of: [String: [Meal]].self) { response in
            switch response.result {
            case .success(let value):
                self.meals = value["meals"]?.sorted(by: { $0.strMeal < $1.strMeal }) ?? []
                completion(.success(self.meals))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
