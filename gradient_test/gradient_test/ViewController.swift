import UIKit

class ViewController: UIViewController {
    
    private lazy var lapView: UIView = { createLapView() }()
    
    private lazy var waveView: WaveAnimationView = { createWaveView() }()
    
    private func createLapView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }
    
    private func createWaveView() -> WaveAnimationView {
        let waveView = WaveAnimationView()
        waveView.translatesAutoresizingMaskIntoConstraints = false
        lapView.addSubview(waveView)
        return waveView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        waveView.backColor = UIColor.blue.withAlphaComponent(0.5)
        waveView.frontColor = UIColor.red.withAlphaComponent(0.5)
        lapView.layer.borderColor = UIColor.blue.cgColor
        
        waveView.startAnimation()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            lapView.topAnchor.constraint(equalTo: view.topAnchor),
            lapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            waveView.topAnchor.constraint(equalTo: lapView.topAnchor),
            waveView.leadingAnchor.constraint(equalTo: lapView.leadingAnchor),
            waveView.bottomAnchor.constraint(equalTo: lapView.bottomAnchor),
            waveView.trailingAnchor.constraint(equalTo: lapView.trailingAnchor)
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        waveView.stopAnimation()
    }
    
    func style() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)

        // Add the gradient to the label. Causes this sublayer to appear on top.
        view.layer.addSublayer(gradient)

        // Create the shimmer animation
        let animationGroup = makeAnimationGroup()
        animationGroup.beginTime = 0.0
        gradient.add(animationGroup, forKey: "backgroundColor")

        // Set the gradients frame to the labels bounds
        gradient.frame = view.bounds
    }
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.systemPink.cgColor
        anim1.toValue = UIColor.systemPurple.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.systemPurple.cgColor
        anim2.toValue = UIColor.systemPink.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }
}

extension UIColor {
    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
}
