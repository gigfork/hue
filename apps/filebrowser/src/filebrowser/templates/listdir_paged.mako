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
from django.template.defaultfilters import urlencode, stringformat, filesizeformat, date, time, escape
from desktop.views import commonheader, commonfooter
%>

<%namespace name="dir" file="listdir_components.mako" />
<%namespace name="fb_components" file="fb_components.mako" />

${commonheader('File Browser', 'filebrowser')}
<div class="container-fluid">
    <h1>File Browser</h1>
    % if breadcrumbs:
        ${fb_components.breadcrumbs(path, breadcrumbs)}
    %endif
    <div id="dirlist" class="view">
        ${dir.list_table_browser(files, path, current_request_path, cwd_set)}
    </div>
</div>
${commonfooter()}
