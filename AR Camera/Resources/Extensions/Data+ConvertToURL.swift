//
//  Data+ConvertToURL.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/18/22.
//

import Foundation

extension Data {
  // convert Data to a URL
    public func convertToURL() -> URL? {
    let tmpFileURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("video")
            .appendingPathExtension("mp4")
    do {
      try self.write(to: tmpFileURL, options: [.atomic])
      return tmpFileURL
    } catch {
      print("failed to write to file url with error: \(error)")
    }
    return nil
  }
}
