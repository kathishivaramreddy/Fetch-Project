//
//  MealDetailViewController.swift
//  Fetch-Project
//
//  Created by Shiva on 6/18/24.
//


import UIKit
import SnapKit

class MealDetailViewController: UIViewController {
    var mealID: String?
    private let viewModel = MealDetailViewModel()
    
    private let nameLabel = UILabel()
    private let instructionsLabel = UILabel()
    private let ingredientsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchMealDetail()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, instructionsLabel, ingredientsLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        instructionsLabel.numberOfLines = 0
        ingredientsLabel.numberOfLines = 0
    }
    
    private func fetchMealDetail() {
        guard let mealID = mealID else { return }
        
        viewModel.fetchMealDetail(by: mealID) { [weak self] result in
            switch result {
            case .success(let mealDetail):
                DispatchQueue.main.async {
                    self?.updateViews(with: mealDetail)
                }
            case .failure(let error):
                print("Failed to fetch meal detail: \(error)")
            }
        }
    }
    
    private func updateViews(with mealDetail: MealDetail) {
        nameLabel.text = mealDetail.strMeal
        instructionsLabel.text = mealDetail.strInstructions
        ingredientsLabel.text = "Ingredients:\n" + mealDetail.ingredients.joined(separator: "\n")
    }
}
