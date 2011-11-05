## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
<%!
import datetime
from django.template.defaultfilters import escape, stringformat, date, time
%>
<%namespace name="wrappers" file="header_footer.mako" />
<%namespace name="dir" file="listdir_components.mako" />
${wrappers.head('File Browser', '', path, current_request_path, cwd_set=cwd_set, show_upload=show_upload, show_new_directory=True)}

  <div id="dirlist" class="view">
    <ul class="breadcrumb">
      % for breadcrumb_item in breadcrumbs:
      <li><a href="/filebrowser/view${breadcrumb_item['url']}">${breadcrumb_item['label']}</a> <span class="divider">/</span></li>
      % endfor

    </ul>

    ${dir.list_table_browser(files, path_enc, current_request_path, cwd_set)}
  </div>
${wrappers.foot()}
