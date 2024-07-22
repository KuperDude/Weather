//
//  WeatherController.swift
//  Weather
//
//  Created by MyBook on 19.07.2024.
//

import UIKit

enum Weather: String, CaseIterable {
    case sunny
    case cloudy
    case overcast
    case storm
    case foggy
    case snowfall
    case hail
    
    var backgroundColor: UIColor {
        switch self {
        case .sunny:    return UIColor(red: 255/255, green: 223/255, blue: 86/255, alpha: 1)
        case .cloudy:   return UIColor(red: 176/255, green: 196/255, blue: 222/255, alpha: 1)
        case .overcast: return UIColor(red: 119/255, green: 136/255, blue: 153/255, alpha: 1)
        case .storm:    return UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1)
        case .foggy:    return UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        case .hail:     return UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
        case .snowfall: return UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1)
        }
    }
}

class WeatherController: UIViewController {
    
    lazy var actions: [Weather: ()->Void] = [
        .sunny : sunnyAnimation,
        .cloudy : cloudyAnimation,
        .overcast : overcastAnimation,
        .storm : stormAnimation,
        .foggy : foggyAnimation,
        .snowfall : snowfallAnimation,
        .hail : hailAnimation,
    ]

    let cloud1 = UIImageView(image: UIImage(systemName: "cloud.drizzle.fill"))
    let cloud2 = UIImageView(image: UIImage(systemName: "cloud.drizzle.fill"))
    let cloud3 = UIImageView(image: UIImage(systemName: "cloud.drizzle.fill"))
    let cloud4 = UIImageView(image: UIImage(systemName: "cloud.drizzle.fill"))
    let cloud5 = UIImageView(image: UIImage(systemName: "cloud.drizzle.fill"))
    let cloud6 = UIImageView(image: UIImage(systemName: "cloud.drizzle.fill"))
    let lightning1 = UIImageView(image: UIImage(systemName: "bolt.fill"))
    let lightning2 = UIImageView(image: UIImage(systemName: "bolt.fill"))
    let sun = UIImageView(image: UIImage(systemName: "sun.max.fill"))
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let randElement = Weather.allCases.randomElement() else { return }
        actions[randElement]?()
        setGradient(weather: randElement)
    }
    
    private func setupViews() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let centerX = view.center.x
        let centerY = view.center.y

        cloud1.frame = CGRect(x: -200, y: screenHeight / 2 - 50, width: 200, height: 200)
        cloud2.frame = CGRect(x: screenWidth + 300, y: screenHeight / 2 - 50, width: 300, height: 300)
        cloud3.frame = CGRect(x: -300, y: screenHeight / 2 + 50, width: 300, height: 300)
        cloud4.frame = CGRect(x: -200, y: screenHeight / 2 - 50, width: 200, height: 200)
        cloud5.frame = CGRect(x: screenWidth + 300, y: screenHeight / 2 - 50, width: 300, height: 300)
        cloud6.frame = CGRect(x: -300, y: screenHeight / 2 + 50, width: 300, height: 300)
        
        lightning1.frame = CGRect(x: centerX, y: centerY - 25, width: 100, height: 100)
        lightning2.frame = CGRect(x: centerX - 100, y: centerY + 25, width: 100, height: 100)
        
        sun.frame = CGRect(x: screenWidth + 250, y: screenHeight / 2 + 50, width: 250, height: 250)
        
        cloud1.tintColor = UIColor(white: 1.0, alpha: 0.9)
        cloud2.tintColor = UIColor(white: 0.98, alpha: 1.0)
        cloud3.tintColor = UIColor(white: 0.95, alpha: 1.0)
        cloud4.tintColor = UIColor(white: 1.0, alpha: 0.9)
        cloud5.tintColor = UIColor(white: 0.98, alpha: 1.0)
        cloud6.tintColor = UIColor(white: 0.95, alpha: 1.0)
        
        lightning1.tintColor = .yellow
        lightning2.tintColor = .yellow
        lightning1.alpha = 0
        lightning2.alpha = 0
        lightning1.layer.zPosition = 4
        
        cloud4.layer.zPosition = 4
        cloud5.layer.zPosition = 4
        cloud6.layer.zPosition = 4
        
        sun.tintColor = .yellow
        
        view.addSubview(sun)
        view.addSubview(cloud1)
        view.addSubview(cloud2)
        view.addSubview(lightning2)
        view.addSubview(cloud3)
        
        view.addSubview(cloud4)
        view.addSubview(cloud5)
        view.addSubview(lightning1)
        view.addSubview(cloud6)
    }
    
    private func sunnyAnimation() {
        let centerX = view.center.x
        let centerY = view.center.y
       
        self.lightning1.alpha = 0
        self.lightning2.alpha = 0
        
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.stayOnlySun()
            self.sun.center = CGPoint(x: centerX, y: centerY - 50)
        }, completion: nil)
    }
    
    private func snowfallAnimation() {
        let clouds = (cloud2, cloud3, cloud1)
        
        startSettings()
        
        startSettingsForThreeClouds(imageName: "cloud.snow.fill", isFirstColorWhite: true, secondaryColor: .blue, clouds: clouds)

        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.changePositionForThreeClouds(clouds: clouds)
            self.stayThreeClouds()
            self.changeColorAtPositionForThreeClouds(isWhiteColor: true, clouds: clouds)
        }, completion: nil)
    }
    
    private func hailAnimation() {
        let clouds = (cloud3, cloud1, cloud2)
        
        startSettings()
        
        startSettingsForThreeClouds(imageName: "cloud.hail.fill", isFirstColorWhite: true, secondaryColor: .blue, clouds: clouds)

        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.changePositionForThreeClouds(clouds: clouds)
            self.stayThreeClouds()
            self.changeColorAtPositionForThreeClouds(isWhiteColor: true, clouds: clouds)
        }, completion: nil)
    }
    
    private func cloudyAnimation() {
        let clouds = (cloud1, cloud2, cloud3)
        
        startSettings()
        
        startSettingsForThreeClouds(imageName: "cloud.drizzle.fill", isFirstColorWhite: true, secondaryColor: .clear, clouds: clouds)

        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.changePositionForThreeClouds(clouds: clouds)
            self.stayThreeClouds()
            self.changeColorAtPositionForThreeClouds(isWhiteColor: true, clouds: clouds)
        }, completion: nil)
    }
    
    private func overcastAnimation() {
        let centerX = view.center.x
        let centerY = view.center.y
        
        startSettings()
        
        startSettingsForThreeClouds(imageName: "cloud.drizzle.fill", isFirstColorWhite: false, secondaryColor: .clear, clouds: (cloud1, cloud2, cloud3))
        
        startSettingsForThreeClouds(imageName: "cloud.drizzle.fill", isFirstColorWhite: false, secondaryColor: .blue, clouds: (cloud4, cloud5, cloud6))
        
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.changePositionForSixClouds(clouds: (self.cloud1, self.cloud2, self.cloud3, self.cloud4, self.cloud5, self.cloud6))
            self.changeColorAtPositionForThreeClouds(isWhiteColor: false, clouds: (self.cloud1, self.cloud2, self.cloud3))
            self.changeColorAtPositionForThreeClouds(isWhiteColor: false, clouds: (self.cloud4, self.cloud5, self.cloud6))

            self.sun.center = CGPoint(x: centerX, y: centerY - 50)
            
        }, completion: nil)
    }
    
    private func stormAnimation() {
        let centerX = view.center.x
        let centerY = view.center.y
        
        startSettings()
        
        startSettingsForThreeClouds(imageName: "cloud.heavyrain.fill", isFirstColorWhite: false, secondaryColor: .blue, clouds: (cloud1, cloud2, cloud3))
        
        startSettingsForThreeClouds(imageName: "cloud.heavyrain.fill", isFirstColorWhite: false, secondaryColor: .blue, clouds: (cloud4, cloud5, cloud6))

        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            self.changePositionForSixClouds(clouds: (self.cloud1, self.cloud2, self.cloud3, self.cloud4, self.cloud5, self.cloud6))
            
            self.lightning2.center = CGPoint(x: centerX, y: centerY + 175)
            self.lightning1.center = CGPoint(x: centerX - 5, y: centerY + 25)
            
            self.sun.center = CGPoint(x: centerX, y: centerY - 50)
            
            self.changeColorAtPositionForThreeClouds(isWhiteColor: false, clouds: (self.cloud1, self.cloud2, self.cloud3))
            self.changeColorAtPositionForThreeClouds(isWhiteColor: false, clouds: (self.cloud4, self.cloud5, self.cloud6))
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseInOut, animations: {
            SoundManager.shared.playSound(named: "storm")
            self.lightning1.alpha = 1
            self.lightning2.alpha = 1
        }, completion: nil)
    }
    
    private func foggyAnimation() {
        let centerX = view.center.x
        let centerY = view.center.y
        
        startSettings()
        
        startSettingsForThreeClouds(imageName: "cloud.drizzle.fill", isFirstColorWhite: true, secondaryColor: .clear, clouds: (cloud1, cloud2, cloud3))
        
        startSettingsForThreeClouds(imageName: "cloud.drizzle.fill", isFirstColorWhite: true, secondaryColor: .clear, clouds: (cloud4, cloud5, cloud6))

        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.changePositionForSixClouds(clouds: (self.cloud1, self.cloud2, self.cloud3, self.cloud4, self.cloud5, self.cloud6))
            
            self.sun.center = CGPoint(x: centerX, y: centerY - 50)
            
            self.changeColorAtPositionForThreeClouds(isWhiteColor: true, clouds: (self.cloud1, self.cloud2, self.cloud3))
            self.changeColorAtPositionForThreeClouds(isWhiteColor: true, clouds: (self.cloud4, self.cloud5, self.cloud6))
            
            self.setAlphaForFoggy()
        }, completion: nil)
    }
}

extension WeatherController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Weather.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        
        cell.configure(image: UIImage(named: Weather.allCases[indexPath.row].rawValue) ?? UIImage(), title: Weather.allCases[indexPath.row].rawValue.localized) {
            
            self.actions[Weather.allCases[indexPath.row]]?()
            self.cellPressed(cell, weather: Weather.allCases[indexPath.row])
        }
        
        return cell
    }
    
    private func cellPressed(_ cell: WeatherCell, weather: Weather) {
        let cellCenter = CGPoint(x: cell.frame(in: view)?.midX ?? 0, y: cell.frame(in: view)?.midY ?? 0)

        let circleLayer = CAShapeLayer()
        let circlePathInitial = UIBezierPath(arcCenter: cellCenter, radius: 1, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        let circlePathFinal = UIBezierPath(arcCenter: cellCenter, radius: max(view.bounds.width, view.bounds.height), startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        circleLayer.path = circlePathFinal.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2
        view.layer.addSublayer(circleLayer)

        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = circlePathInitial.cgPath
        animation.toValue = circlePathFinal.cgPath
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        circleLayer.add(animation, forKey: "pathAnimation")

        setGradient(weather: weather) {
            circleLayer.removeFromSuperlayer()
        }
    }
}

//MARK: - Utility Methods
extension WeatherController {
    private func stayOnlySun() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        stayThreeClouds()
        self.cloud1.frame = CGRect(x: -200, y: screenHeight / 2 - 50, width: 200, height: 200)
        self.cloud2.frame = CGRect(x: screenWidth + 300, y: screenHeight / 2 - 50, width: 300, height: 300)
        self.cloud3.frame = CGRect(x: -300, y: screenHeight / 2 + 50, width: 300, height: 300)
    }
    
    private func startSettingsForThreeClouds(imageName: String, isFirstColorWhite: Bool, secondaryColor: UIColor, clouds: (UIImageView, UIImageView, UIImageView)) {
        
        let paletteConfigurationClear1 = UIImage.SymbolConfiguration(paletteColors: [isFirstColorWhite ? UIColor(white: 1.0, alpha: 0.9) : .systemGray, secondaryColor])
        let paletteConfigurationClear2 = UIImage.SymbolConfiguration(paletteColors: [isFirstColorWhite ? UIColor(white: 0.98, alpha: 1.0) : .systemGray2, secondaryColor])
        let paletteConfigurationClear3 = UIImage.SymbolConfiguration(paletteColors: [isFirstColorWhite ? UIColor(white: 0.95, alpha: 1.0) : .systemGray3, secondaryColor])
        clouds.0.image = UIImage(systemName: imageName, withConfiguration: paletteConfigurationClear1)
        clouds.1.image = UIImage(systemName: imageName, withConfiguration: paletteConfigurationClear2)
        clouds.2.image = UIImage(systemName: imageName, withConfiguration: paletteConfigurationClear3)
    }
    
    private func stayThreeClouds() {
        let centerX = view.center.x
        let centerY = view.center.y
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        self.cloud4.frame = CGRect(x: -200, y: screenHeight / 2 - 50, width: 200, height: 200)
        self.cloud5.frame = CGRect(x: screenWidth + 300, y: screenHeight / 2 - 50, width: 300, height: 300)
        self.cloud6.frame = CGRect(x: -300, y: screenHeight / 2 + 50, width: 300, height: 300)
        self.sun.center = CGPoint(x: centerX, y: centerY - 50)
    }
    
    private func changePositionForThreeClouds(clouds: (UIImageView, UIImageView, UIImageView)) {
        let centerX = view.center.x
        let centerY = view.center.y
        
        clouds.0.frame.size = CGSize(width: 200, height: 200)
        clouds.0.center = CGPoint(x: centerX - 100, y: centerY - 25)
        clouds.0.layer.zPosition = 1
        
        clouds.1.frame.size = CGSize(width: 300, height: 300)
        clouds.1.center = CGPoint(x: centerX + 100, y: centerY + 25)
        clouds.1.layer.zPosition = 2
        
        clouds.2.frame.size = CGSize(width: 300, height: 300)
        clouds.2.center = CGPoint(x: centerX, y: centerY + 100)
        clouds.2.layer.zPosition = 3
    }
    
    private func changeColorAtPositionForThreeClouds(isWhiteColor: Bool, clouds: (UIImageView, UIImageView, UIImageView)) {
        clouds.0.tintColor = isWhiteColor ? UIColor(white: 1.0, alpha: 0.9) : .systemGray
        clouds.1.tintColor = isWhiteColor ? UIColor(white: 0.98, alpha: 1.0) : .systemGray2
        clouds.2.tintColor = isWhiteColor ? UIColor(white: 0.95, alpha: 1.0) : .systemGray3
    }
    
    private func changePositionForSixClouds(clouds: (UIImageView, UIImageView, UIImageView, UIImageView, UIImageView, UIImageView)) {
        let centerX = view.center.x
        let centerY = view.center.y
        
        self.changePositionForThreeClouds(clouds: (clouds.0, clouds.1, clouds.2))
        
        clouds.3.center = CGPoint(x: centerX + 75, y: centerY + 25)
        clouds.4.center = CGPoint(x: centerX - 100, y: centerY + 75)
        clouds.5.center = CGPoint(x: centerX - 5, y: centerY - 50)
    }
    
    private func startSettings() {
        lightning1.alpha = 0
        lightning2.alpha = 0
        
        cloud1.layer.zPosition = 0
        cloud2.layer.zPosition = 0
        cloud3.layer.zPosition = 0
        
        cloud1.alpha = 1
        cloud2.alpha = 1
        cloud3.alpha = 1
        cloud4.alpha = 1
        cloud5.alpha = 1
        cloud6.alpha = 1
    }
    
    private func setAlphaForFoggy() {
        cloud1.alpha = 0.9
        cloud2.alpha = 0.9
        cloud3.alpha = 0.95
        
        cloud4.alpha = 0.9
        cloud5.alpha = 0.9
        cloud6.alpha = 0.95
    }
    
    private func setGradient(weather: Weather, _ action: (()->Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.applyGradient(isVertical: true, colorArray: [
                weather.backgroundColor,
                weather.backgroundColor.withAlphaComponent(0)
            ])
            action?()
        }
    }
}
