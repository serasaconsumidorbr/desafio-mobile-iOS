//
//  File.swift
//
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit

extension PaginatedTableViewProxyData {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isStatusCell(at: indexPath) && currentState == .retryError {
            retryCallBack?()
        }
        if !isStatusCell(at: indexPath) {
            delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        }
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y + scrollView.frame.height
        if yOffset >= scrollView.contentSize.height * 0.95 && currentState == .none {
            if haveNextPage {
                infiniteScrollingCallBack?()
                currentState = .infiniteLoading
            }
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isStatusCell(at: indexPath) {
            return UITableView.automaticDimension
        }
        return delegate?.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return delegate?.tableView?(tableView, viewForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.tableView?(tableView, heightForHeaderInSection: section) ?? .zero
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return delegate?.tableView?(tableView, viewForFooterInSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate?.tableView?(tableView, heightForFooterInSection: section) ?? .zero
    }
}
