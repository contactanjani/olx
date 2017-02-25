//
//  ListViewTests.swift
//  olx
//
//  Created by Anjani on 2/25/17.
//  Copyright © 2017 do. All rights reserved.
//

import XCTest

class ListModuleTests: XCTestCase {
    
    class FakeVC : ListViewInterface{
        var eventHandler : ListModuleInterface?
        func showNoContentMessage() {
            
        }
        func showFetchedDisplayDataForQuery(_ query : String,data: DisplayData) {
            XCTAssert(data.products?.first?.id == "3456")
        }
        func showFetchedInitialDisplayData(_ data: DisplayData) {
            XCTAssert(data.products?.first?.id == "5678")
        }
        func updateTitle(_ title : String) {
            
        }
        func resetSearchTable() {
            
        }
        func updateListWithPaginatedData(_query : String, data : DisplayData){}
    }
    
    class FakePresenter : ListModuleInterface {
        var userInterface : ListViewInterface?
        func updateView() {
            userInterface?.showFetchedInitialDisplayData(DisplayData([ProductDisplayItem(product: Product(dictionary: ["id":5678]))]))

        }
        func updateViewWithSearchQuery(_ query : String) {
            userInterface?.showFetchedDisplayDataForQuery(query,data: DisplayData([ProductDisplayItem(product: Product(dictionary: ["id":3456]))]))
        }
        
        func productTapped(displayProduct : ProductDisplayItem) {
            
        }
        
        func updateViewWithResultsAtOffset(_ offset : Int) {
            
        }
        func updateViewWithResultsAtOffset(_ query : String, offset : Int){}
    }
    
    var product : Product?
    var fakeVC : FakeVC?
    var fakePresenter : FakePresenter?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        product = Product(dictionary: ["title":"lorem ipsum","id":1234])
        fakeVC = FakeVC()
        fakePresenter = FakePresenter()
        
        fakeVC?.eventHandler = fakePresenter
        fakePresenter?.userInterface = fakeVC
        
    }
    
    func testProductModel() {
        XCTAssert(product?.id == "1234")
        XCTAssert(product?.title == "lorem ipsum")
    }
    
    func testProductDisplayItemModel() {
        
        let productDisplayItem = ProductDisplayItem(product: product!)
        XCTAssert(productDisplayItem.title == "lorem ipsum")
    }
    
    func testUIPresenterInteraction() {
        fakeVC?.eventHandler?.updateViewWithSearchQuery("abc")
        fakeVC?.eventHandler?.updateView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.fakeVC = nil
        self.fakePresenter = nil
        self.product = nil
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
