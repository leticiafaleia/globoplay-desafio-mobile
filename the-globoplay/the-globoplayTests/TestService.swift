//
//  the_globoplayTests.swift
//  the-globoplayTests
//
//  Created by Letícia Faleia on 13/11/24.
//

import XCTest
@testable import the_globoplay

final class ServiceTests: XCTestCase {
    var service: Service!

    override func setUp() {
        super.setUp()
        service = Service()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testGetMoviesByGenresRequest_Success() {
        let expectation = self.expectation(description: "Completion handler invoked")
        var fetchedMovies: Root?

        service.getMoviesByGenresRequest(with_genre: 28) { movies in
            fetchedMovies = movies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchedMovies, "A lista de filmes por gênero deve ser retornada com sucesso.")
    }

    func testGetMoviesGenresRequest_Success() {
        let expectation = self.expectation(description: "Completion handler invoked")
        var fetchedGenres: Genres?

        service.getMoviesGenresRequest { genres in
            fetchedGenres = genres
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchedGenres, "Os gêneros de filmes devem ser retornados com sucesso.")
    }

    func testGetMovieDetails_Success() {
        let expectation = self.expectation(description: "Completion handler invoked")
        var fetchedDetail: MovieDetail?

        service.getMovieDetails(movieId: 550) { detail in
            fetchedDetail = detail
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchedDetail, "Os detalhes do filme devem ser retornados com sucesso.")
    }

    func testGetRecommendations_Success() {
        let expectation = self.expectation(description: "Completion handler invoked")
        var fetchedRecommendations: Root?

        service.getRecommendations(movieID: 550) { recommendations in
            fetchedRecommendations = recommendations
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchedRecommendations, "As recomendações de filmes devem ser retornadas com sucesso.")
    }

}
