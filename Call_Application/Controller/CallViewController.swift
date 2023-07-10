//
//  CallViewController.swift
//  Call_Application
//
//  Created by talha polat on 7.07.2023.
//

import UIKit

class CallViewController: UIViewController {

    @IBOutlet weak var lblNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
   
    func configureUI(){
        lblNumber.text = ""
    }
    
    @IBAction func btnNumberClicked(_ sender: UIButton) {
    
        guard let text = lblNumber.text else{return}
        lblNumber.text! += "\(sender.tag)"
    }
    
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        
        if lblNumber.text!.count >= 1{
            let text = lblNumber.text!.dropLast(1)
            lblNumber.text = String(text)
        }
    }
   
    @IBAction func btnCallClicked(_ sender: UIButton) {
        guard let number = lblNumber.text else{return}
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnCallViewController") as! OnCallViewController
        
        vc.modalPresentationStyle = .fullScreen
        vc.number = number
        navigationController?.pushViewController(vc, animated: true)
        guard let number = lblNumber.text else{return}
        TwilioManager.shared.makeCall(to: number)
    }
    
}
