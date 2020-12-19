//
//  SearchPresenter.swift
//  Music
//
//  Created by ivan on 18.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
    
    switch response {
    case .some:
        print("presenter .some")
    case .presentTracks(let searchResult):
        let cells = searchResult?.results.map({ (track) in
            cellViewModel(from: track)
        }) ?? []
        
        let searchViewModel = SearchViewModel.init(cells: cells)
        print("presenter .presentTracks")
        viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
    }
  
  }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell.init(iconUrlString: track.artworkUrl100,
                                         trackName: track.trackName,
                                         collectionName: track.collectionName ?? "",
                                         artistName: track.artistName,
                                         previewUrl: track.previewUrl)
    }
  
}
