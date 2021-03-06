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
  import cgi
  import urllib
  from django.template.defaultfilters import date, time
  from desktop.lib.django_util import extract_field_data
  from desktop.views import commonheader, commonfooter
%>
<%namespace name="layout" file="layout.mako" />

${commonheader("Job Designer", "jobsub", "100px")}
${layout.menubar(section='designs')}

<script src="/static/ext/js/datatables-paging-0.1.js" type="text/javascript" charset="utf-8"></script>

<div class="container-fluid">
    <h1>Job Designs</h1>
	<div class="well hueWell">
			<div class="btn-group pull-right">
				<a href="${ url('jobsub.views.new_design', action_type='mapreduce') }" class="btn">Create Mapreduce Design</a>
            	<a href="${ url('jobsub.views.new_design', action_type='streaming') }" class="btn">Create Streaming Design</a>
            	<a href="${ url('jobsub.views.new_design', action_type='java') }" class="btn">Create Java Design</a>
				%if show_install_examples:
					<a id="installSamplesLink" href="javascript:void(0)" data-confirmation-url="${url('jobsub.views.setup')}" class="btn" >Install Samples</a>
				%endif
			</div>

		<form class="form-search">
			Filter: <input id="filterInput" class="input-xlarge search-query" placeholder="Search for username, name, etc...">
		</form>
	</div>

    <table id="designTable" class="table table-condensed datatables">
        <thead>
            <tr>
                <th>Owner</th>
                <th>Name</th>
                <th>Type</th>
                <th>Description</th>
                <th>Last Modified</th>
                <th nowrap="nowrap">&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            %for design in designs:
                <tr>
                    <td>${design.owner.username}</td>
                    <td>${design.name}</td>
                    <td>${design.root_action.action_type}</td>
                    <td>${design.description}</td>
                    <td nowrap="nowrap">${date(design.last_modified)} ${time(design.last_modified).replace("p.m.","PM").replace("a.m.","AM")}</td>
                    <td nowrap="nowrap" class="right">
                    %if currentuser.username == design.owner.username:
                        <a title="Submit ${design.name}" class="btn small submitConfirmation"
                           alt="Submit ${design.name} to the cluster"
                           href="javascript:void(0)"
                           data-param-url="${ url('jobsub.views.get_design_params', design_id=design.id) }"
                           data-submit-url="${ url('jobsub.views.submit_design', design_id=design.id) }">Submit</a>
                        <a title="Edit ${design.name}" class="btn small"
                           href="${ url('jobsub.views.edit_design', design_id=design.id) }" data-row-selector="true">Edit</a>
                    %endif%
                    %if currentuser.is_superuser or currentuser.username == design.owner.username:
                        <a title="Delete ${design.name}" class="btn small deleteConfirmation"
                           alt="Are you sure you want to delete ${design.name}?"
                           href="javascript:void(0)"
                           data-confirmation-url="${ url('jobsub.views.delete_design', design_id=design.id) }">Delete</a>
                    %endif
                        <a title="Clone ${design.name}" class="btn small" href="${ url('jobsub.views.clone_design', design_id=design.id) }">Clone</a>
                    </td>
                </tr>
            %endfor
        </tbody>
    </table>

</div>


<div id="submitWf" class="modal hide fade">
	<form id="submitWfForm" action="" method="POST">
        <div class="modal-header">
            <a href="#" class="close" data-dismiss="modal">&times;</a>
            <h3 id="submitWfMessage">Submit this design?</h3>
        </div>
        <div class="modal-body">
            <fieldset>
                <div id="param-container">
                </div>
            </fieldset>
        </div>
        <div class="modal-footer">
            <input id="submitBtn" type="submit" class="btn primary" value="Submit"/>
            <a href="#" class="btn secondary hideModal">Cancel</a>
        </div>
	</form>
</div>

<div id="deleteWf" class="modal hide fade">
	<form id="deleteWfForm" action="" method="POST">
        <div class="modal-header">
            <a href="#" class="close" data-dismiss="modal">&times;</a>
            <h3 id="deleteWfMessage">Delete this design?</h3>
        </div>
        <div class="modal-footer">
            <input type="submit" class="btn primary" value="Yes"/>
            <a href="#" class="btn secondary hideModal">No</a>
        </div>
	</form>
</div>

<div id="installSamples" class="modal hide fade">
	<form id="installSamplesForm" action="${url('jobsub.views.setup')}" method="POST">
        <div class="modal-header">
            <a href="#" class="close" data-dismiss="modal">&times;</a>
            <h3>Install sample job designs?</h3>
        </div>
        <div class="modal-body">
          It will take a few seconds to install.
        </div>
        <div class="modal-footer">
            <input type="submit" class="btn primary" value="Yes"/>
            <a href="#" class="btn secondary" data-dismiss="modal">No</a>
        </div>
	</form>
</div>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {

        $(".deleteConfirmation").click(function(){
            var _this = $(this);
            var _action = _this.attr("data-confirmation-url");
            $("#deleteWfForm").attr("action", _action);
            $("#deleteWfMessage").text(_this.attr("alt"));
            $("#deleteWf").modal("show");
        });
        $("#deleteWf .hideModal").click(function(){
            $("#deleteWf").modal("hide");
        });

        $(".submitConfirmation").click(function(){
            var _this = $(this);
            var _action = _this.attr("data-submit-url");
            $("#submitWfForm").attr("action", _action);
            $("#submitWfMessage").text(_this.attr("alt"));
            // We will show the model form, but disable the submit button
            // until we've finish loading the parameters via ajax.
            $("#submitBtn").attr("disabled", "disabled");
            $("#submitWf").modal("show");

            $.get(_this.attr("data-param-url"), function(data) {
                var params = data["params"]
                var container = $("#param-container");
                container.empty();
                for (key in params) {
                    if (!params.hasOwnProperty(key)) {
                        continue;
                    }
                    container.append(
                        $("<div/>").addClass("clearfix")
                          .append($("<label/>").text(params[key]))
                          .append(
                              $("<div/>").addClass("input")
                                .append($("<input/>").attr("name", key).attr("type", "text"))
                          )
                    )
                }
                // Good. We can submit now.
                $("#submitBtn").removeAttr("disabled");
            }, "json");
        });
        $("#submitWf .hideModal").click(function(){
            $("#submitWf").modal("hide");
        });

        var oTable = $('#designTable').dataTable( {
          "sPaginationType": "bootstrap",
          "bLengthChange": false,
          "sDom": "<'row'r>t<'row'<'span8'i><''p>>",
		  "aoColumns": [
				null,
				null,
				null,
				null,
				{ "sType": "date" },
				{ "bSortable": false }
			],
			"aaSorting": [[ 4, "desc" ]]
        });

        $("#filterInput").keyup(function() {
            oTable.fnFilter($(this).val());
        });

		$("#installSamplesLink").click(function(){
            $("#installSamples").modal("show");
        });

		$("a[data-row-selector='true']").jHueRowSelector();


    });
</script>
${commonfooter()}
