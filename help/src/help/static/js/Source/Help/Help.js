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
/*
---

script: Help.js

description: Defines Help; a Hue application that extends Hue.JBrowser.

authors:
- Unknown

requires:
- JFrame/JFrame.Browser

provides: [Help]

...
*/
ART.Sheet.define('window.art.browser.help', {
	'min-width': 620
});

var Help = new Class({

	Extends: Hue.JBrowser,

	options: {
		className: 'art browser logo_header help'
	},

	initialize: function(path, options){
		this.parent(path || '/help/', options);
	}

});
