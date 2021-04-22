//
//  PaginatedTableViewProxyData+DelegateProxy.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import UIKit

extension PaginatedTableViewProxyData {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isStatusCell(at: indexPath) && currentState == .retryError {
            retryCallBack?()
        }
        if !isStatusCell(at: indexPath) {
            delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y + scrollView.frame.height
        if yOffset >= scrollView.contentSize.height * 0.95 && currentState == .none {
            if haveNextPage {
                infiniteScrollingCallBack?()
                currentState = .infiniteLoading
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isStatusCell(at: indexPath) {
            return UITableView.automaticDimension
        }
        return delegate?.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return delegate?.tableView?(tableView, viewForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.tableView?(tableView, heightForHeaderInSection: section) ?? .zero
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return delegate?.tableView?(tableView, viewForFooterInSection: section)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate?.tableView?(tableView, heightForFooterInSection: section) ?? .zero
    }
}
