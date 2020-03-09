//
//  CountryListViewController.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class CountryListViewController: UITableViewController {

    @IBOutlet var countryTableView: UITableView!
    public var viewModel = CountryViewModel(countryWebService: WebServiceManager()) 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
         countryTableView.dataSource = viewModel
        countryTableView.accessibilityIdentifier = "tableview.country.search"
        viewModel.countries.bind { [weak self] (data) in
            self?.refreshTableView()
        }
        
        initSearchVC()
    }
    
    //MARK: Serach View Added
    
    private func initSearchVC() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchBar.accessibilityIdentifier = "country.searchbar"
        searchController.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField

    }
    
    private func refreshTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.countryTableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as? CountryDetailViewController
        
        guard let nextViewController = vc, let arrVal = viewModel.countries.value else {
            return
        }
        
        let countryDetail = arrVal[indexPath.row]
        let vm = CountryDetailsViewModel(countryModelObj: countryDetail)
        nextViewController.viewModel = vm
        splitViewController?.showDetailViewController(nextViewController, sender: nil)
    }
}

extension CountryListViewController :  UISearchBarDelegate {
    
    // called when text changes
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search Text: \(searchText)")
        viewModel.getCountryListBySearchText(searchText: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getCountryListBySearchText(searchText: "")
    }
}
