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
import md5
from django.template.defaultfilters import urlencode, stringformat, filesizeformat, date, time, escape
from desktop.lib.django_util import reverse_with_get, extract_field_data
from django.utils.encoding import smart_str
%>


<%def name="pageref(num)">
    href="?pagenum=${num}&pagesize=${pagesize}"
</%def>
<%def name="prevpage(page)">
  ${pageref(page.previous_page_number())}
</%def>
<%def name="nextpage(page)">
  ${pageref(page.next_page_number())}
</%def>
<%def name="toppage(page)">
  ${pageref(1)}
</%def>
<%def name="bottompage(page)">
  ${pageref(page.num_pages())}
</%def>
<%def name="pagination(page)">
	<div class="pagination">
	  <ul class="pull-right">
	    <li class="prev"><a title="Beginning of List" ${toppage(page)}>&larr; Beginning of List</a></li>
	    <li><a title="Previous Page" ${prevpage(page)}>Previous Page</a></li>
		<li><a title="Next page" ${nextpage(page)}>Next Page</a></li>
	    <li class="next"><a title="End of List" ${bottompage(page)}>End of List &rarr;</a></li>
	  </ul>
	<p>Show <select id="pagesize" class="input-mini"><option>15</option><option>30</option><option>45</option><option>60</option><option>100</option><option>200</option></select> items per page. Showing ${page.start_index()} to ${page.end_index()} of ${page.total_count()} items, page ${page.number} of ${page.num_pages()}.</p>
	</div>
</%def>

<%def name="list_table_chooser(files, path, current_request_path)">
  ${_table(files, path, current_request_path, 'chooser')}
</%def>
<%def name="list_table_browser(files, path, current_request_path, cwd_set=True)">
  ${_table(files, path, current_request_path, 'view', cwd_set)}
</%def>
<%def name="_table(files, path, current_request_path, view, cwd_set=False)">
	<script src="/static/ext/js/fileuploader.js" type="text/javascript" charset="utf-8"></script>
	<script src="/static/ext/js/datatables-paging-0.1.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" href="/static/ext/css/fileuploader.css" type="text/css" media="screen" title="no title" charset="utf-8" />
	<style type="text/css">
    	.form-padding-fix{
	        display: inline;
	        padding: 0;
	        margin: 0;
	    }
		.pull-right {
			margin: 4px;
		}
		.sortable {
			cursor: pointer;
		}
	</style>

	<table class="table table-condensed table-striped datatables">
		<thead>
			<tr>
			% if cwd_set:
				<th class="sortable sorting" data-sort="name">Name</th>
			% else:
				<th class="sortable sorting" data-sort="name">Path</th>
			% endif
				<th class="sortable sorting" data-sort="size">Size</th>
				<th class="sortable sorting" data-sort="user">User</th>
				<th class="sortable sorting" data-sort="group">Group</th>
				<th>Permissions</th>
				<th class="sortable sorting" data-sort="atime">Date</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			% for file in files:
			<%
	          cls = ''
	          if (file_filter == 'dir' and file['type'] != 'dir') or (file_filter != 'dir' and file['type'] == 'dir'):
	            if (file_filter != 'any'):
	              cls = ' not-selectable'

	          if cwd_set:
	            display_name = file['name']
	          else:
	            display_name = file['path']
	          endif
	        %>

			<% path = file['path'] %>
			<tr class="file-row" data-search="${display_name}">
				<td>
					<h5><a href="${url('filebrowser.views.'+view, path=urlencode(path))}?file_filter=${file_filter}" data-row-selector="true">${display_name}</a></h5>
				</td>
				<td>
					% if "dir" == file['type']:
					<span>~</span>
					% else:
					<span>${file['stats']['size']|filesizeformat}</span>
					% endif
				</td>
				<td>${file['stats']['user']}</td>
				<td>${file['stats']['group']}</td>
				<td>${file['rwx']}</td>
				<td>${date(datetime.datetime.fromtimestamp(file['stats']['mtime']))} ${time(datetime.datetime.fromtimestamp(file['stats']['mtime'])).replace("p.m.","PM").replace("a.m.","AM")}</td>
				<td>
					% if ".." != file['name']:
					<%
					path_digest = urlencode(md5.md5(smart_str(path)).hexdigest())
					%>
					<div class="btn-group">
				    	<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
							Options
				    		<span class="caret"></span>
				    	</a>
				    	<ul class="dropdown-menu">
				    		% if "dir" == file['type']:
							<li><a class="delete" delete-type="rmdir" file-to-delete="${path}" data-backdrop="static" data-keyboard="true">Delete</a></li>
							<li><a class="delete" delete-type="rmtree" file-to-delete="${path}" data-backdrop="static" data-keyboard="true">Delete Recursively</a></li>
							% else:
							<li><a class="delete" delete-type="remove" file-to-delete="${path}" data-backdrop="static" data-keyboard="true">Delete</a></li>
							<li><a href="${url('filebrowser.views.view', path=urlencode(path))}">View File</a></li>
							<li><a href="${url('filebrowser.views.edit', path=urlencode(path))}">Edit File</a></li>
							<li><a href="${url('filebrowser.views.download', path=urlencode(path))}" target="_blank">Download File</a></li>
							% endif
							<li><a class="rename" file-to-rename="${path}">Rename</a></li>
							<li><a onclick="openChownWindow('${path}','${file['stats']['user']}','${file['stats']['group']}','${current_request_path}')">Change Owner / Group</a></li>
							<li><a onclick="openChmodWindow('${path}','${stringformat(file['stats']['mode'], "o")}','${current_request_path}')">Change Permissions</a></li>
							<li><a onclick="openMoveModal('${path}','${stringformat(file['stats']['mode'], "o")}', '${current_request_path}')">Move</a></li>
				    	</ul>
				    </div>
					% endif
				</td>
			</tr>
			% endfor
		</tbody>
	</table>

	${pagination(page)}

<!-- delete modal -->
<div id="deleteModal" class="modal hide fade">
	<div class="modal-header">
		<a href="#" class="close" data-dismiss="modal">&times;</a>
		<h3>Please Confirm</h3>
    </div>
    <div class="modal-body">
        <p>Are you sure you want to delete this file?</p>
    </div>
    <div class="modal-footer">
        <form id="deleteForm" action="" method="POST" enctype="multipart/form-data" class="form-stacked">
			<input type="submit" value="Yes" class="btn primary" />
			<a id="cancelDeleteBtn" class="btn">No</a>
        	<input id="fileToDeleteInput" type="hidden" name="path" />
        </form>
    </div>
</div>

<!-- rename modal -->
<div id="renameModal" class="modal hide fade">
    <form id="renameForm" action="/filebrowser/rename?next=${current_request_path}" method="POST" enctype="multipart/form-data" class="form-inline form-padding-fix">
    <div class="modal-header">
        <a href="#" class="close" data-dismiss="modal">&times;</a>
        <h3>Renaming: <span id="renameFileName">file name</span></h3>
    </div>
    <div class="modal-body">
		<label>New name <input id="newNameInput" name="dest_path" value="" type="text" class="input-xlarge"/></label>
    </div>
    <div class="modal-footer">
        <div id="renameNameRequiredAlert" class="hide" style="position: absolute; left: 10;">
			<span class="label label-important">Sorry, name is required.</span>
        </div>

        <input id="renameSrcPath" type="hidden" name="src_path" type="text">
        <input type="submit" value="Submit" class="btn primary" />
        <a id="cancelRenameBtn" class="btn">Cancel</a>
    </div>
    </form>
</div>

<!-- upload modal -->
<div id="uploadModal" class="modal hide fade">
    <form id="uploadForm" action="/filebrowser/rename?next=${current_request_path}" method="POST" enctype="multipart/form-data" class="form-stacked form-padding-fix">
    <div class="modal-header">
        <a href="#" class="close" data-dismiss="modal">&times;</a>
        <h3>Uploading to: <span id="uploadDirName">${current_dir_path}</span></h3>
    </div>
    <div class="modal-body">
        <form action="/filebrowser/upload?next=${current_dir_path}" method="POST" enctype="multipart/form-data" class="form-stacked">
			<div id="fileUploader">
		<noscript>
			<p>Please enable JavaScript to use file uploader.</p>
			<!-- or put a simple form for upload here -->
		</noscript>
	</div>
        </form>

    </div>
    <div class="modal-footer"></div>
    </form>
</div>

<!-- create directory modal -->
<div id="createDirectoryModal" class="modal hide fade">
    <form id="createDirectoryForm" action="/filebrowser/mkdir?next=${current_request_path}" method="POST" enctype="multipart/form-data" class="form-inline form-padding-fix">
    <div class="modal-header">
        <a href="#" class="close" data-dismiss="modal">&times;</a>
        <h3>Create Directory</h3>
    </div>
    <div class="modal-body">
		<label>Directory Name <input id="newDirectoryNameInput" name="name" value="" type="text" class="input-xlarge"/></label>
		<input type="hidden" name="path" type="text" value="${current_dir_path}"/>
    </div>
    <div class="modal-footer">
         <div id="directoryNameRequiredAlert" class="alert-message error hide" style="position: absolute; left: 10;">
            <p><strong>Sorry, directory name is required.</strong>
        </div>
        <input class="btn primary" type="submit" value="Submit" />
        <a id="cancelCreateDirectoryBtn" class="btn" href="#">Cancel</a>
    </div>
    </form>
</div>


<div id="changeOwnerModal" class="modal hide fade">
</div>

<div id="changePermissionModal" class="modal hide fade">
</div>

<div id="moveModal" class="modal hide fade">
</div>

<script type="text/javascript" charset="utf-8">
    // ajax modal windows
    function openChownWindow(path, user, group, next){
        $.ajax({
            url: "/filebrowser/chown",
            data: {"path":path, "user":user, "group" : group, "next" : next},
            beforeSend: function(xhr){
                xhr.setRequestHeader("X-Requested-With", "Hue");
            },
            dataType: "html",
            success: function(data){
                $("#changeOwnerModal").html(data);
                $("#changeOwnerModal").modal({
					backdrop: "static",
					keyboard: true,
					show: true
				});
            }
        });
    }

    function openChmodWindow(path, mode, next){
        $.ajax({
            url: "/filebrowser/chmod",
            data: {"path":path, "mode":mode, "next" : next},
            beforeSend: function(xhr){
                xhr.setRequestHeader("X-Requested-With", "Hue");
            },
            dataType: "html",
            success: function(data){
                $("#changePermissionModal").html(data);
                $("#changePermissionModal").modal({
					backdrop: "static",
					keyboard: true,
					show: true
				});
            }
        });
    }

    function openMoveModal(src_path, mode, next){
        $.ajax({
            url: "/filebrowser/move",
            data: {"src_path":src_path, "mode":mode, "next" : next},
            beforeSend: function(xhr){
                xhr.setRequestHeader("X-Requested-With", "Hue");
            },
            dataType: "html",
            success: function(data){
                $("#moveModal").html(data);
                $("#moveModal").modal({
					backdrop: "static",
					keyboard: true,
					show: true
				});
            }
        });
    }
    //uploader
    var num_of_pending_uploads = 0;
    function createUploader(){
        var uploader = new qq.FileUploader({
            element: document.getElementById("fileUploader"),
            action: "/filebrowser/upload",
            params:{
                dest: "${current_dir_path}",
                fileFieldLabel: "hdfs_file"
            },
            onComplete:function(id, fileName, responseJSON){
                num_of_pending_uploads--;
                if(num_of_pending_uploads == 0){
                    window.location = "/filebrowser/view${current_dir_path}";
                }
            },
            onSubmit:function(id, fileName, responseJSON){
                num_of_pending_uploads++;
            },
            debug: true
        });
    }

    // in your app create uploader as soon as the DOM is ready
    // don"t wait for the window to load
    window.onload = createUploader;

	function getQueryString(){
		var queryString = {};
		if (window.location.href.indexOf("?")>-1){
			window.location.href.split("?").pop().split("&").forEach(function (prop) {
				var item = prop.split("=");
				queryString[item.shift()] = item.shift();
			});
		}
		return queryString;
	}

	function setQueryString(queryString){
		var qs = "?"
		for (var key in queryString) {
		    qs += key + "=" + queryString[key] + "&";
		}
		return qs.substring(0,qs.length-1);
	}

	$(document).ready(function(){
		var qs = getQueryString();

		if (qs["sortby"] == null){
			qs["sortby"] = "name";
		}

		var el = $(".sortable[data-sort="+qs["sortby"]+"]");
		el.removeClass("sorting");
		if (qs["descending"] != null && qs["descending"] == "true"){
			el.addClass("sorting_desc");
		}
		else {
			el.addClass("sorting_asc");
		}


		$(".sortable").click(function(){
			qs["sortby"]=$(this).data("sort");
			if ($(this).hasClass("sorting_asc")){
				qs["descending"] = "true";
			}
			else {
				delete qs["descending"];
			}
			location.href = setQueryString(qs);
		});

		$("#pagesize").val("${pagesize}");
		$("#pagesize").change(function(){
			qs["pagenum"] = "1";
			qs["pagesize"] = $("#pagesize").val();
			location.href = setQueryString(qs);
		});

        //delete handlers
        $(".delete").live("click", function(e){
            $("#fileToDeleteInput").attr("value", $(e.target).attr("file-to-delete"));
            $("#deleteForm").attr("action", "/filebrowser/" + $(e.target).attr("delete-type") + "?next=" + encodeURI("${current_request_path}") + "&path=" + encodeURI("${path}"));
            $("#deleteModal").modal({
                backdrop: "static",
                keyboard: true,
                show: true
            });
        });

        $("#cancelDeleteBtn").click(function(){
            $("#deleteModal").modal("hide");
        });

        //rename handlers
        $(".rename").live("click",function(eventObject){
            $("#renameSrcPath").attr("value", $(eventObject.target).attr("file-to-rename"));
            $("#renameFileName").text($(eventObject.target).attr("file-to-rename"));
            $("#renameModal").modal({
                backdrop: "static",
                keyboard: true,
                show: true
            });
        });

        $("#cancelRenameBtn").click(function(){
            $("#renameModal").modal("hide");
        });

        $("#renameForm").submit(function(){
            if($("#newNameInput").val() == ""){
                $("#renameNameRequiredAlert").show();
                $("#newNameInput").addClass("fieldError");
                return false;
            }
        });

        $("#newNameInput").focus(function(){
            $("#renameNameRequiredAlert").hide();
            $("#newNameInput").removeClass("fieldError");
        });

        $("#moveForm").live("submit", function(){
            if ($.trim($("#moveForm").find("input[name='dest_path']").val()) == ""){
                $("#moveNameRequiredAlert").show();
                $("#moveForm").find("input[name='dest_path']").addClass("fieldError");
                return false;
            }
            return true;
        });

        $("#moveForm").find("input[name='dest_path']").live("focus", function(){
            $("#moveNameRequiredAlert").hide();
            $("#moveForm").find("input[name='dest_path']").removeClass("fieldError");
        });


        //upload handlers
        $(".upload-link").click(function(){
            $("#uploadModal").modal({
                backdrop: "static",
                keyboard: true,
                show: true
            });
        });

        //create directory handlers
        $(".create-directory-link").click(function(){
            $("#createDirectoryModal").modal({
                backdrop: "static",
                keyboard: true,
                show: true
            });
        });

        $("#cancelCreateDirectoryBtn").click(function(){
            $("#createDirectoryModal").modal("hide");
        });

        $("#createDirectoryForm").submit(function(){
            if ($.trim($("#newDirectoryNameInput").val())==""){
                $("#directoryNameRequiredAlert").show();
                $("#newDirectoryNameInput").addClass("fieldError");
                return false;
            }
            return true;
        });

        $("#newDirectoryNameInput").focus(function(){
            $("#newDirectoryNameInput").removeClass("fieldError");
            $("#directoryNameRequiredAlert").hide();
        });

        $(".pathChooser").click(function(){
            var self = this;
            $("#fileChooserRename").jHueFileChooser({
                onFileChoose: function(filePath) {
                    $(self).val(filePath);
                },
                onFolderChange: function(folderPath){
                    $(self).val(folderPath);
                },
                createFolder: false,
                uploadFile: false
            });
            $("#fileChooserRename").slideDown();
        });

        $("a[data-row-selector='true']").jHueRowSelector();
    });
</script>

</%def>
