//
//  MealTableViewCell.swift
//  Fetch-Project
//
//  Created by Shiva on 6/18/24.
//

import UIKit
import SnapKit

class MealTableViewCell: UITableViewCell {
    static let identifier = "MealTableViewCell"
    
    let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40 // Set corner radius to half of the image view size
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let mealNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        
        mealImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(80) // Set width and height to 80 to make a square
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(mealImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with meal: Meal) {
        mealNameLabel.text = meal.strMeal
        if let urlString = meal.strMealThumb, let url = URL(string: urlString) {
            // Load image asynchronously (you can use a library like SDWebImage or AlamofireImage here)
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.mealImageView.image = UIImage(data: data)
                }
            }.resume()
        } else {
            mealImageView.image = nil
        }
    }
}
