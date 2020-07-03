//
//  ViewController.swift
//  Project1
//
//  Created by Pradeep Reddy Kypa on 26/05/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
        
        pictures.sort(by: <)
        
        print(pictures)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTapOfShare))
    }
    
    @objc func onTapOfShare(){
        
        let activityViewController = UIActivityViewController(activityItems: ["I am using an ImageSlideShow to show Images"], applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageNo = indexPath.row + 1
            vc.totalPicturesCount = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            // 2: success! Set its selectedImage property
//            vc.selectedImage = pictures[indexPath.row]
//
//            // 3: now push it onto the navigation controller
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}

