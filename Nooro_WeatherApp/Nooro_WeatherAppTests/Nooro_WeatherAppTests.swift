//
//  Nooro_WeatherAppTests.swift
//  Nooro_WeatherAppTests
//
//  Created by Osama on 18/12/2024.
//

import XCTest
@testable import Nooro_WeatherApp

final class Nooro_WeatherAppTests: XCTestCase {

    // MARK: - Mock Data
    let mockWeatherData = WeatherData(
        location: Location(name: "London", region: "England", country: "UK", tz_id: "Europe/London"),
        current: Current(
            temp_c: 25.0,
            temp_f: 77.0,
            is_day: 1,
            condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000),
            humidity: 50,
            feelslike_c: 27.0,
            feelslike_f: 80.6,
            uv: 5.0
        )
    )

    // MARK: - Mock Classes

    class MockWeatherRemoteDS: WeatherRemoteDSProtocol {
        var shouldReturnError = false
        var mockData: WeatherData?

        init(mockData: WeatherData?) {
            self.mockData = mockData
        }

        func searchWeatherReport(param: RequestPararm) async throws -> WeatherData? {
            if shouldReturnError {
                throw NetworkError.apiError(code: 404, message: "Not Found")
            }
            return mockData
        }
    }

    class MockWeatherLocalDS: WeatherLocalDSProtocol {
        private var storedWeather: WeatherData?

        func save(weather: WeatherData) {
            storedWeather = weather
        }

        func get(key: UserDefaultsKeys) -> WeatherData? {
            return storedWeather
        }

        func delete(key: UserDefaultsKeys) {
            storedWeather = nil
        }
    }

    // MARK: - Tests

    func testWeatherUseCase_Success() async throws {
        // Arrange
        let remoteDS = MockWeatherRemoteDS(mockData: mockWeatherData)
        let localDS = MockWeatherLocalDS()
        let repo = WeatherRepo(remoteDS: remoteDS, localDS: localDS)
        let useCase = WeatherUseCase(repo: repo)

        // Act
        let weather = try await useCase.execute(query: "London")

        // Assert
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.location.name, "London")
        XCTAssertEqual(weather?.current.condition.text, "Sunny")
    }

    func testWeatherUseCase_FallbackToLocal() async throws {
        // Arrange
        let remoteDS = MockWeatherRemoteDS(mockData: nil)
        remoteDS.shouldReturnError = true

        let localDS = MockWeatherLocalDS()
        localDS.save(weather: mockWeatherData)

        let repo = WeatherRepo(remoteDS: remoteDS, localDS: localDS)
        let useCase = WeatherUseCase(repo: repo)

        // Act
        let weather = try await useCase.execute(query: "London")

        // Assert
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.location.name, "London")
        XCTAssertEqual(weather?.current.condition.text, "Sunny")
    }

    func testSaveSelectedWeatherUseCase() {
        // Arrange
        let localDS = MockWeatherLocalDS()
        let repo = WeatherRepo(remoteDS: MockWeatherRemoteDS(mockData: mockWeatherData), localDS: localDS)
        let saveUseCase = SaveSelectedWeatherUseCase(repo: repo)

        // Act
        saveUseCase.execute(data: mockWeatherData)

        // Assert
        let savedWeather = localDS.get(key: .currentWeather)
        XCTAssertNotNil(savedWeather)
        XCTAssertEqual(savedWeather?.current.temp_c, 25.0)
        XCTAssertEqual(savedWeather?.current.condition.text, "Sunny")
    }

    func testWeatherRepo_UsesRemoteDataSource() async throws {
        // Arrange
        let remoteDS = MockWeatherRemoteDS(mockData: mockWeatherData)
        let localDS = MockWeatherLocalDS()
        let repo = WeatherRepo(remoteDS: remoteDS, localDS: localDS)

        // Act
        let weather = try await repo.searchWeatherReport(param: RequestPararm(path: .getCurrent, queryParams: ["q": "London"]))

        // Assert
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.location.name, "London")
        XCTAssertEqual(weather?.current.temp_c, 25.0)
    }

    func testWeatherRepo_FallbackToLocal() async throws {
        // Arrange
        let remoteDS = MockWeatherRemoteDS(mockData: nil)
        remoteDS.shouldReturnError = true

        let localDS = MockWeatherLocalDS()
        localDS.save(weather: mockWeatherData)

        let repo = WeatherRepo(remoteDS: remoteDS, localDS: localDS)

        // Act
        let weather = try await repo.searchWeatherReport(param: RequestPararm(path: .getCurrent, queryParams: ["q": "London"]))

        // Assert
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.location.name, "London")
        XCTAssertEqual(weather?.current.condition.text, "Sunny")
    }

    func testWeatherUseCase_NoLocalFallback() async throws {
        // Arrange
        let remoteDS = MockWeatherRemoteDS(mockData: nil)
        remoteDS.shouldReturnError = true

        let localDS = MockWeatherLocalDS()
        let repo = WeatherRepo(remoteDS: remoteDS, localDS: localDS)
        let useCase = WeatherUseCase(repo: repo)

        do {
            // Act
            _ = try await useCase.execute(query: "Unknown")
            XCTFail("Expected to throw, but did not")
        } catch let error as NetworkError {
            // Assert
            XCTAssertEqual(error, .apiError(code: 404, message: "Not Found"))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
