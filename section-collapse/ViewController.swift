//
//  ViewController.swift
//  section-collapse
//
//  Created by Satyam Saluja on 18/01/19.
//  Copyright © 2019 Satyam Saluja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // List that maintains the status of section collasped or open
    var sectionOpenStatus = [false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Selector when arrow_up / arrow_down is tapped
    @objc func didTapSectionButton(sender : UIButton!) {
        sectionOpenStatus[sender.tag] = !sectionOpenStatus[sender.tag]
        let section = IndexSet.init(integer: sender.tag)
        tableView.reloadSections(section, with: .none)
    }
    
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Section View
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 50))
        
        // Section Gradient
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red:0.04, green:0.44, blue:0.99, alpha:1.0).cgColor , UIColor(red:0.04, green:0.91, blue:0.99, alpha:1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = view.bounds
        
        // arrow_up / arrow_down button
        let button = UIButton()
        sectionOpenStatus[section] ? button.setImage(#imageLiteral(resourceName: "arrow_up"), for: .normal) : button.setImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
        button.frame = CGRect(x: UIScreen.main.bounds.width-30, y: 5, width: 20, height: 20)
        button.tag = section
        button.addTarget(self, action: #selector(ViewController.didTapSectionButton(sender:)), for: .touchUpInside)
        button.center.y = view.center.y
        
        // Section Label
        let label = UILabel()
        label.text = "Section \(section+1)"
        label.textColor = .white
        label.frame = CGRect(x: 5, y: 2.5, width: UIScreen.main.bounds.width-50, height: 25)
        label.center.y = view.center.y
        
        view.layer.addSublayer(gradient)
        view.addSubview(button)
        view.addSubview(label)
        
        return view
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionOpenStatus[section] {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "Cell \(indexPath.row+1)"
        return cell
    }
}

