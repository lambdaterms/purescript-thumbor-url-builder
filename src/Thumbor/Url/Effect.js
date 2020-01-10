/* global exports, require */
/* jshint -W097 */

"use strict";

var thumbor = require('thumbor-url-builder-ts');

exports.thumborImpl = function(key) {
  return function(serverUrl) {
    return function(imagePath) {
      return function() {
        return (new thumbor.ThumborUrlBuilder(key, serverUrl)).setImagePath(imagePath);
      };
    }
  };
};

exports.buildUrl = function(thumbor) {
  return function() {
    return thumbor.buildUrl();
  }
}

exports.resize = function(width) {
  return function(height) {
    return function(thumbor) {
      return function() {
        return thumbor.resize(width, height);
      }
    };
  };
};


exports.smartCrop = function(t) {
  return function(thumbor) {
    return function() {
      thumbor.smartCrop(t);
    };
  };
};

exports.formatImpl = function(f) {
  return function(thumbor) {
    return function() {
      thumbor.format(f);
    };
  };
};

exports.crop = function(c) {
  return function(thumbor) {
    return function() {
      thumbor.crop(c.left, c.top, c.right, c.bottom);
    };
  };
};
