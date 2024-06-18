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
        setupTableView()
        fetchMeals()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealCell")
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

extension MealListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        let meal = viewModel.meals[indexPath.row]
        cell.textLabel?.text = meal.strMeal
        return cell
    }
}

extension MealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = viewModel.meals[indexPath.row]
        let detailVC = MealDetailViewController()
        detailVC.mealID = meal.idMeal
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
