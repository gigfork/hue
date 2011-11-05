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
<%namespace name="edit" file="editor_components.mako" />
<%namespace name="wrappers" file="header_footer.mako" />
${wrappers.head('Change Permissions: ' + path.split('/')[-1], show_side_bar=False)}




  <div class="well">
    <form action="/filebrowser/chmod?next=${next|u}" method="POST" enctype="multipart/form-data">
    <h1 class="jframe-hidden">Change Permissions: ${path}</h1>
    ${edit.render_field(form["path"], hidden=True)}
    <table class="zebra-striped"
            style="background-color: #ffffff;">
      <thead>
        <tr>
          <th></th>
          <th>User</th>
          <th>Group</th>
          <th>Other</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Read</td>
          <td>${edit.render_field(form["user_read"], tag="checkbox", button_text=" ", notitle=True)}</td>
          <td>${edit.render_field(form["group_read"], tag="checkbox", button_text=" ", notitle=True)}</td>
          <td>${edit.render_field(form["other_read"], tag="checkbox", button_text=" ", notitle=True)}</td>
        </tr>
        <tr>
          <td>Write</td>
          <td>${edit.render_field(form["user_write"], tag="checkbox", button_text=" ", notitle=True)}</td>
          <td>${edit.render_field(form["group_write"], tag="checkbox", button_text=" ", notitle=True)}</td>
          <td>${edit.render_field(form["other_write"], tag="checkbox", button_text=" ", notitle=True)}</td>
        </tr>
        <tr>
          <td>Execute</td>
          <td>${edit.render_field(form["user_execute"], tag="checkbox", button_text=" ", notitle=True)}</td>
          <td>${edit.render_field(form["group_execute"], tag="checkbox", button_text=" ", notitle=True)}</td>
          <td>${edit.render_field(form["other_execute"], tag="checkbox", button_text=" ", notitle=True)}</td>
        </tr>
      </tbody>
    </table>
    <div>
        <input class="btn primary" type="submit" value="Submit" />
        <a class="btn" href="${next|u}">Cancel</a>
    </div>
    </form>
  </div>

${wrappers.foot()}
