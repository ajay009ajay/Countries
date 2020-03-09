//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by user on 3/7/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SVGKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    var viewModel: CountryDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailTableView.dataSource = viewModel
        detailTableView.delegate = self
        detailTableView.reloadData()
    }
}

extension CountryDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return TableViewConstant.flagSectionHeight
        } else if(indexPath.section == 3) {
            return TableViewConstant.countryAboutSecionHeight
        }
        return TableViewConstant.commonSectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return TableViewConstant.flagSectionHeaderHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  section == 0 {
            let svgImageHeaderView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: TableViewConstant.flagSectionHeaderHeight))
            
            if let imageData = viewModel?.countryModelObj.flagImageData {
                let anSVGImage: SVGKImage = SVGKImage(data: imageData)
                svgImageHeaderView.image = anSVGImage
                return svgImageHeaderView
            }
        }
        return nil

    }
}
