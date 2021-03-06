/*
---
description: Gets the logged user info
requires: [jQuery]
script: jquery.showusername.js
...
*/
// Licensed to Cloudera, Inc. under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  Cloudera, Inc. licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
;(function ($, window, document, undefined) {

	var pluginName = "jHueUsername",
	defaults = {
		onLoad: function(){}
	};

	function Plugin(element, options) {
		this.element = element;
		this.options = $.extend({}, defaults, options) ;
		this._defaults = defaults;
		this._name = pluginName;
		this.init();
	}
	
	Plugin.prototype.setOptions = function(options) {
		this.options = $.extend({}, defaults, options) ;
	};

	Plugin.prototype.init = function () {
        var _this = this;
        var elem = $(_this.element);
        if (elem.data("user")!=null && elem.data("user")["username"]){
            elem.text(elem.data("user")["username"]);
        }
        else {
            $.post(
                "/profile", function(user){
                    // sets a user field value the 
                    elem.data("user", user);
                    elem.text(elem.data("user")["username"]);
                    _this.options.onLoad(user);
                }, "json").error(function(e){
                    // we get an error when the user is not logged in
                    elem.data("user", null);
            });
        }
	};

	$.fn[pluginName] = function (options) {
		return this.each(function () {
			if (!$.data(this, 'plugin_' + pluginName)) {
				$.data(this, 'plugin_' + pluginName, new Plugin( this, options));
			}
			else {
				$.data(this, 'plugin_' + pluginName).setOptions(options);
			}
		});
	}

})(jQuery, window, document );
