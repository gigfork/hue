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
from django.template.defaultfilters import timesince
from desktop.views import commonheader, commonfooter
%>
<%namespace name="comps" file="beeswax_components.mako" />
<%namespace name="layout" file="layout.mako" />
${commonheader("Beeswax: Queries", "beeswax", "100px")}
${layout.menubar(section='saved queries')}
<div class="container-fluid">
    <h1>Beeswax: Queries</h1>
    <table class="table table-striped table-condensed datatables">
        <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Owner</th>
            <th>Type</th>
            <th>Last Modified</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
            <%!
                from beeswax import models
            %>
            % for design in page.object_list:
                <%
                    may_edit = user == design.owner
                %>
                <tr>
                <td>
                    % if may_edit:
                    % if design.type == models.SavedQuery.REPORT:
                            <a href="${ url('beeswax.views.edit_report', design_id=design.id) }" data-row-selector="true">${design.name}</a>
                    % else:
                            <a href="${ url('beeswax.views.execute_query', design_id=design.id) }" data-row-selector="true">${design.name}</a>
                    % endif
                    % else:
                    ${design.name}
                    % endif
                </td>
                <td>
                    % if design.desc:
                        <p>${design.desc}</p>
                    % endif
                </td>
                    <td>${design.owner.username}</td>
                <td>
                    % if design.type == models.SavedQuery.REPORT:
                        Report
                    % else:
                        Query
                    % endif
                </td>
                    <td>
                    ${ timesince(design.mtime) } ago
                    </td>
                <td>
                <div class="btn-group">
                    <a href="#" data-toggle="dropdown" class="btn dropdown-toggle">
                        Options
                        <span class="caret"></span>
                    </a>
                <ul class="dropdown-menu">

                % if may_edit:
                    % if design.type == models.SavedQuery.REPORT:
                            <li><a href="${ url('beeswax.views.edit_report', design_id=design.id) }" title="Edit this report." class="contextItem">Edit</a></li>
                    % else:
                            <li><a href="${ url('beeswax.views.execute_query', design_id=design.id) }" title="Edit this query." class="contextItem">Edit</a></li>
                    % endif
                        <li><a href="javascript:void(0)" data-confirmation-url="${ url('beeswax.views.delete_design', design_id=design.id) }" title="Delete this query." class="contextItem confirmationModal">Delete</a></li>
                        <li><a href="${ url('beeswax.views.list_query_history') }?design_id=${design.id}" title="View the usage history of this query." class="contextItem">Usage History</a></li>

                % endif
                    <li><a href="${ url('beeswax.views.clone_design', design_id=design.id) }" title="Copy this query." class="contextItem">Clone</a></li>
                </ul>
                </div>
                </td>
                </tr>
            % endfor
        </tbody>
    </table>
    ${comps.pagination(page)}
</div>

<div id="deleteQuery" class="modal hide fade">
    <form id="deleteQueryForm" action="" method="POST">
        <div class="modal-header">
            <a href="#" class="close" data-dismiss="modal">&times;</a>
            <h3 id="deleteQueryMessage">Confirm action</h3>
        </div>
        <div class="modal-footer">
            <input type="submit" class="btn primary" value="Yes"/>
            <a href="#" class="btn secondary" data-dismiss="modal">No</a>
        </div>
    </form>
</div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function(){

        $(".datatables").dataTable({
            "bPaginate": false,
            "bLengthChange": false,
            "bInfo": false,
            "bFilter": false,
            "aoColumns": [
                null,
                null,
                null,
                null,
                null,
                { "bSortable": false }
            ]
        });

        $(".confirmationModal").live("click", function(){
            $.getJSON($(this).attr("data-confirmation-url"), function(data){
                $("#deleteQueryForm").attr("action", data.url);
                $("#deleteQueryMessage").text(data.title);
            });
            $("#deleteQuery").modal("show");
        });

        $("a[data-row-selector='true']").jHueRowSelector();
    });
</script>

${commonfooter()}
