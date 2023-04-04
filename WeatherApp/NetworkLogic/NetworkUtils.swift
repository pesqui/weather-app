//
//  NetworkUtils.swift
//  WeatherApp
//
//  Created by OakHost Customer on 22/02/2023.
//

import Foundation

public final class NetworkUtils {
    public static func formatIconURL(iconAbbr: String) -> String {
        return "https://cdn.faire.com/static/mobile-take-home/icons/\(iconAbbr).png"
    }
}
