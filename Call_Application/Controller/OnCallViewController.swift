//
//  OnCallViewController.swift
//  Call_Application
//
//  Created by talha polat on 9.07.2023.
//

import UIKit

class OnCallViewController: UIViewController {
    private var timer = Timer()
    private var counter = 0
    // MARK:- Aslanım
    @IBOutlet weak var lblCalling:UILabel!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    var number = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(LblCallingChanging), userInfo: nil, repeats: true)
        configureUI()
    }
    
    private func configureUI(){
        lblPhoneNumber.text = number
        TwilioManager.shared.makeCall(to: number)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func LblCallingChanging(){
        counter += 1
        
        switch counter % 3{
        case 0: lblCalling.text = "Calling."
        case 1: lblCalling.text = "Calling.."
        case 2: lblCalling.text = "Calling..."
        default:return
            
        }
        
        
    }
    
    
    @IBAction func btnHangOffClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}
