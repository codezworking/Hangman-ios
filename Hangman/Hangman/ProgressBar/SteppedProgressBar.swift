import Foundation
import UIKit

class SteppedProgressBar: UIView {

  private var numberOfSteps = 0
  private var currentStep = 0
  private let stepViewSpacing = 2.0
  private var stepViews = [StepView]()
  
  init(frame: CGRect, steps: Int) {
    super.init(frame:frame)
    self.numberOfSteps = steps
    self.createViewTree()
    self.applyConstrains()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func incrementStep() {
    self.stepViews[self.currentStep].fillColor()
    currentStep = currentStep + 1
  }
  
  func createViewTree() {
    for _ in 1...self.numberOfSteps {
      let subview = self.createStepView()
      stepViews.append(subview)
      self.addSubview(subview)
    }
  }
  
  func applyConstrains() {
    // Figure out the size of the subview
    let stepViewHeightRatio:Double = 1.0/Double(self.numberOfSteps)
    for stepView in self.stepViews {
      self.addConstraint(NSLayoutConstraint(item: stepView, attribute: .width,
                                            relatedBy: .equal,
                                            toItem: self, attribute: .width,
                                            multiplier: 1.0, constant: 0.0))
      self.addConstraint(NSLayoutConstraint(item: stepView, attribute: .height,
                                            relatedBy: .equal,
                                            toItem: self, attribute: .height,
                                            multiplier: CGFloat(stepViewHeightRatio),
                                            constant: CGFloat(stepViewSpacing)))
    }
    
    var previousView:UIView? = nil
    for stepView in self.stepViews {
      if (previousView != nil) {
        self.addConstraint(NSLayoutConstraint(item: stepView, attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: previousView, attribute: .top,
                                              multiplier: 1.0, constant: -1 * CGFloat(stepViewSpacing)))
      } else {
        self.addConstraint(NSLayoutConstraint(item: stepView, attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self, attribute: .bottom,
                                              multiplier: 1.0, constant: 0.0))
      }
      previousView = stepView
    }
  }
  
  func createStepView() -> StepView {
    let view = StepView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    return view
  }
}

class StepView : UIView {
  private let kCornerRadius = 4.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = CGFloat(kCornerRadius)
    self.backgroundColor = .white
    self.layer.borderColor = UIColor.red.cgColor
    self.layer.borderWidth = 1.0
    self.createViewTree()
    self.applyConstrains()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func fillColor() {
    self.addConstraint(NSLayoutConstraint(item: self.fillView, attribute: .height,
                                          relatedBy: .equal,
                                          toItem: self, attribute: .height,
                                          multiplier: 1.0, constant: 0.0))
    UIView.animate(withDuration: 1.0) {
      self.layoutIfNeeded()
    }
  }
  
  func createViewTree() {
    self.addSubview(self.fillView)
  }
  
  func applyConstrains() {
    self.addConstraint(NSLayoutConstraint(item: self.fillView, attribute: .width,
                                          relatedBy: .equal,
                                          toItem: self, attribute: .width,
                                          multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: self.fillView, attribute: .bottom,
                                          relatedBy: .equal,
                                          toItem: self, attribute: .bottom,
                                          multiplier: 1.0, constant: 0.0))
  }
  
  lazy var fillView: UIView = {
    var fillView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    fillView.translatesAutoresizingMaskIntoConstraints = false
    fillView.layer.cornerRadius = CGFloat(kCornerRadius)
    fillView.backgroundColor = .red
    return fillView
  }()
}
