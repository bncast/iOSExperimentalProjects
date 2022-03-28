//
//  MovieListViewModel.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation

final class MovieListViewModel {
    
    var coordinator:MainCoordinator!

    var onUpdate: () -> Void = {}

    let title = "Movie Search"
    
    var movies: [MovieModel] = []
    
    private(set) var cells: [MovieCellViewModel] = []

    init(){
        
    }
    
    func filterCancelled() {
        
        movies.removeAll()
        reloadData()
    }
    
    func filterUsers(_ searchText: String) {
        movies.removeAll()
        reloadData()
        
        ApiManager.shared.findMovie(searchString: searchText) { results in
            self.movies.append(contentsOf: results)
            
            self.reloadData()
        }

        
    }

    private func reloadData() {
        cells.removeAll()

        movies.forEach({ movie in
            let cellViewModel = MovieCellViewModel(movie: movie)
            cellViewModel.onSelect = coordinator.onSelect
            cells.append(cellViewModel)
        })

        DispatchQueue.main.async {
            self.onUpdate()
        }
        
    }

    func numberOfRows() -> Int {
        return cells.count
    }

    func cell(for indexPath: IndexPath) -> MovieCellViewModel {
        return cells[indexPath.row]
    }

    func didSelect(for indexPath: IndexPath) {
        let cell = cells[indexPath.row]
        cell.didSelect()
    }
}
