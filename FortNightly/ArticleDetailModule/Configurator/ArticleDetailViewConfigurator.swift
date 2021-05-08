//
//  ArticleDetailViewConfigurator.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/7/21.
//

import Foundation
import UIKit

protocol ArticleDetailViewPresenterToRouter: AnyObject {
    static func createArticleDetailModule() -> ArticleDetailViewController
}
