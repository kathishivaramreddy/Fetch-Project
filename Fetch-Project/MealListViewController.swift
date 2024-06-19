//
//  MealListViewController.swift
//  Fetch-Project
//
//  Created by Shiva on 6/18/24.
//

import UIKit
import SnapKit

class MealListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = MealListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchMeals()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Meals"
        
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchMeals() {
        viewModel.fetchMeals { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch meals: \(error)")
            }
        }
    }
}

extension MealListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell()
        }
        let meal = viewModel.meals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = viewModel.meals[indexPath.row]
        let detailVC = MealDetailViewController()
        detailVC.mealID = meal.idMeal
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
