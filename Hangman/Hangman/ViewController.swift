//
//  ViewController.swift
//  Hangman
//
//  Created by Viswanathan Munisamy on 03/12/17.
//  Copyright © 2017 Enigma Inc.,. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let progressBar = SteppedProgressBar(frame: CGRect(x: 0, y: 0, width: 20, height: 600), steps: 5)
    self.view.addSubview(progressBar)
    let later = DispatchTime.now() + 2
    DispatchQueue.main.asyncAfter(deadline: later, execute: {
      progressBar.incrementStep()
      let later = DispatchTime.now() + 2
      DispatchQueue.main.asyncAfter(deadline: later, execute: {
        progressBar.incrementStep()
      })
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

