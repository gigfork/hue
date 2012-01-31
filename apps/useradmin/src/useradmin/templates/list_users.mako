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
<%namespace name="wrappers" file="header_footer.mako" />
<% import urllib %>
<% from django.utils.translation import ugettext, ungettext, get_language, activate %>
<% _ = ugettext %>

${wrappers.head()}
	<div class="well">
			Filter by name: <input id="filterInput"/> <a href="#" id="clearFilterBtn" class="btn">Clear</a>
			<p class="pull-right">
				<a href="${ url('useradmin.views.edit_user') }" class="btn">Add user</a>
			</p>
	</div>
      <table class="datatables">
        <thead>
          <tr>
            <th>${_('Username')}</th>
            <th>${_('First Name')}</th>
            <th>${_('Last Name')}</th>
            <th>${_('E-mail')}</th>
            <th>${_('Last Login')}</th>
			<th>&nbsp;</th>
          </tr>
        </head>
        <tbody>
        % for user in users:
          <tr class="userRow" data-search="${user.username}${user.first_name}${user.last_name}${user.email}">
            <td>${user.username}</td>
            <td>${user.first_name}</td>
            <td>${user.last_name}</td>
            <td>${user.email}</td>
            <td>
              ${user.last_login.strftime('%c')}
            </td>
            <td>
              <a title="Edit ${user.username}" class="btn small" href="${ url('useradmin.views.edit_user', username=urllib.quote(user.username)) }">Edit</a>
              <a title="Delete ${user.username}" class="btn small confirmationModal" alt="Are you sure you want to delete ${user.username}?" href="javascript:void(0)" data-confirmation-url="${ url('useradmin.views.delete_user', username=urllib.quote_plus(user.username)) }">Delete</a>
            </td>
          </tr>
        % endfor
        </tbody>
      </table>



<div id="deleteUser" class="modal hide fade">
	<form id="deleteUserForm" action="" method="POST">
	<div class="modal-header">
		<a href="#" class="close">&times;</a>
		<h3 id="deleteUserMessage">Confirm action</h3>
	</div>
	<div class="modal-footer">
		<input type="submit" class="btn primary" value="Yes"/>
		<a href="#" class="btn secondary hideModal">No</a>
	</div>
	</form>
</div>


	<script type="text/javascript" charset="utf-8">
		$(document).ready(function(){
			$(".datatables").dataTable({
				"bPaginate": false,
			    "bLengthChange": false,
				"bInfo": false,
				"bFilter": false
			});
			$(".dataTables_wrapper").css("min-height","0");
			$(".dataTables_filter").hide();

			$("#deleteUser").modal({
				backdrop: "static",
				keyboard: true
			});
			$(".confirmationModal").click(function(){
				var _this = $(this);
				$.getJSON(_this.attr("data-confirmation-url"), function(data){
					$("#deleteUserForm").attr("action", data.path);
					$("#deleteUserMessage").text(_this.attr("alt"));
				});
				$("#deleteUser").modal("show");
			});
			$(".hideModal").click(function(){
				$("#deleteUser").modal("hide");
			});

			$("#filterInput").keyup(function(){
		        $.each($(".userRow"), function(index, value) {

		          if($(value).attr("data-search").toLowerCase().indexOf($("#filterInput").val().toLowerCase()) == -1 && $("#filterInput").val() != ""){
		            $(value).hide(250);
		          }else{
		            $(value).show(250);
		          }
		        });

		    });

		    $("#clearFilterBtn").click(function(){
		        $("#filterInput").val("");
		        $.each($(".file-row"), function(index, value) {
		            $(value).show(250);
		        });
		    });


		});
	</script>

${wrappers.foot()}
