//
//  DrawingViewController.swift
//  Drawing
//
//  Created by Pawan  on 17/01/2021.
//

import UIKit

struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}

class Canvas: UIView {
    
    // public function
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    fileprivate var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
}


class DrawingViewController: UIViewController {
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var pink: UIButton!
    @IBOutlet weak var white: UIButton!
    
    @IBOutlet weak var bgBlue: UIButton!
    @IBOutlet weak var bgRed: UIButton!
    @IBOutlet weak var bgGreen: UIButton!
    @IBOutlet weak var bgYellow: UIButton!
    @IBOutlet weak var bgPink: UIButton!
    @IBOutlet weak var bgWhite: UIButton!
    
    @IBOutlet weak var mainView: Canvas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.minimumValue = 1
        slider.maximumValue = 10
        
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        
        blue.layer.cornerRadius = blue.layer.bounds.height/2
        red.layer.cornerRadius = red.layer.bounds.height/2
        green.layer.cornerRadius = green.layer.bounds.height/2
        yellow.layer.cornerRadius = yellow.layer.bounds.height/2
        pink.layer.cornerRadius = pink.layer.bounds.height/2
        white.layer.cornerRadius = white.layer.bounds.height/2
        
        bgBlue.layer.cornerRadius = bgBlue.layer.bounds.height/2
        bgRed.layer.cornerRadius = bgRed.layer.bounds.height/2
        bgGreen.layer.cornerRadius = bgGreen.layer.bounds.height/2
        bgYellow.layer.cornerRadius = bgYellow.layer.bounds.height/2
        bgPink.layer.cornerRadius = bgPink.layer.bounds.height/2
        bgWhite.layer.cornerRadius = bgWhite.layer.bounds.height/2
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        mainView?.clear()
    }
    
    @IBAction func undoButtonTapped(_ sender: UIButton) {
        mainView?.undo()
    }
    
    @IBAction func blueColorTapped(_ sender: UIButton) {
        mainView?.setStrokeColor(color: .blue)
    }
    
    @IBAction func redColorTapped(_ sender: UIButton) {
        mainView?.setStrokeColor(color: .red)
    }
    
    @IBAction func greenColorTapped(_ sender: UIButton) {
        mainView?.setStrokeColor(color: .green)
    }
    
    @IBAction func YellowColorTapped(_ sender: UIButton) {
        mainView?.setStrokeColor(color: .yellow)
    }
    
    @IBAction func pinkColorTapped(_ sender: UIButton) {
        mainView?.setStrokeColor(color: .systemPink)
    }
    
    @IBAction func whiteColorTapped(_ sender: UIButton) {
        mainView?.setStrokeColor(color: .white)
    
    }
    
    @IBAction func bgBlueColor(_ sender: Any) {
        mainView?.backgroundColor = .blue
    }
    
    @IBAction func bgRedColor(_ sender: Any) {
        mainView?.backgroundColor = .red
    }
    
    @IBAction func bgGreenColor(_ sender: Any) {
        mainView?.backgroundColor = .green
    }
    
    
    @IBAction func bgYellowColor(_ sender: Any) {
        mainView?.backgroundColor = .yellow
    }
    
    @IBAction func bgPinkColor(_ sender: Any) {
        mainView?.backgroundColor = .systemPink
    }
    
    @IBAction func bgWhiteColor(_ sender: Any) {
        mainView?.backgroundColor = .white
    }
    
    @IBAction func slider(_ sender: UISlider) {
        mainView?.setStrokeWidth(width: slider.value)
    }
}
