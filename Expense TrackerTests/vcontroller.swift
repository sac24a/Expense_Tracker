//
//  vcontroller.swift
//  Expense TrackerTests
//
//  Created by ITRENTALINDIA on 27/09/22.
//

import XCTest
@testable import Expense_Tracker
class vcontroller: XCTestCase {
    func testViewModel() {
        let viewmodel = ExpenseViewModel()
        viewmodel.getExpense()
        XCTAssertNotNil(viewmodel.model, "model is nil")
    }
    func testHomeVCStuff() {
        let vc = ExpenseViewModel()
        vc.getExpenseBydate(date: "27 Sep 2022")
        XCTAssertEqual(vc.model?.count, 0)
    }
}
