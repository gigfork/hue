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
  import urllib

  from desktop.views import commonheader, commonfooter
  from django.utils.translation import ugettext, ungettext, get_language, activate
  from desktop.lib.django_util import extract_field_data

  _ = ugettext
%>

<%namespace name="layout" file="layout.mako" />

${commonheader("Job Designer", "jobsub", "100px")}
${layout.menubar(section='designs')}



<link rel="stylesheet" href="/static/ext/css/jquery-ui-autocomplete-1.8.18.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="/static/ext/js/knockout-2.0.0.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/ext/js/jquery/plugins/jquery-ui-autocomplete-1.8.18.min.js" type="text/javascript" charset="utf-8"></script>


<%def name="render_field(field)">
  %if not field.is_hidden:
    <% group_class = len(field.errors) and "error" or "" %>
    <div class="control-group ${group_class}">
      <label class="control-label">${field.label | n}</label>
      <div class="controls">
        <input name="${field.html_name | n}"
            class="span5 ${field.field.widget.attrs.get('class', '')}"
            value="${extract_field_data(field) or ''}" />
        % if len(field.errors):
          <span class="help-inline">${unicode(field.errors) | n}</span>
        % endif
      </div>
    </div>
  %endif
</%def>

<div class="container-fluid">
  <h1>Job Design (${_(action_type)} type)</h1>

  <form class="form-horizontal" id="workflowForm" action="${urllib.quote(action)}" method="POST">
    <fieldset>

        % for field in form.wf:
          ${render_field(field)}
        % endfor

        <hr/>
        <div class="control-group">
          <p class="alert alert-info">
              You can parameterize the values, using <code>$myVar</code> or
              <code>${"${"}myVar}</code>. When the design is submitted, you will be
              prompted for the actual value of <code>myVar</code>.
          </p>
        </div>
        % for field in form.action:
          ${render_field(field)}
        % endfor

        <div class="control-group">
            <label class="control-label">Job Properties</label>
            <div class="controls">
                ## Data bind for job properties
                <table class="table-condensed designTable" data-bind="visible: properties().length > 0">
                  <thead>
                    <tr>
                      <th>Property name</th>
                      <th>Value</th>
                      <th />
                    </tr>
                  </thead>
                  <tbody data-bind="foreach: properties">
                    <tr>
                      <td><input class="span3 required propKey" data-bind="value: name, uniqueName: false" /></td>
                      <td><input class="span4 required pathChooserKo" data-bind="fileChooser: $data, value: value, uniqueName: false" /></td>
                      <td><a class="btn btn-small" href="#" data-bind="click: $root.removeProp">Delete</a></td>
                    </tr>
                  </tbody>
                </table>
                % if len(form.action["job_properties"].errors):
                  <div class="row">
                    <div class="alert alert-error">
                      ${unicode(form.action["job_properties"].errors) | n}
                    </div>
                  </div>
                % endif

                <button class="btn" data-bind="click: addProp">Add Property</button>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">Files</label>
            <div class="controls">
                ## Data bind for files (distributed cache)
                <table class="table-condensed designTable" data-bind="visible: files().length > 0">
                  <tbody data-bind="foreach: files">
                    <tr>
                      <td><input class="input span5 required pathChooserKo"
                                data-bind="fileChooser: $data, value: name, uniqueName: false" /></td>
                      <td><a class="btn" href="#" data-bind="click: $root.removeFile">Delete</a></td>
                    </tr>
                  </tbody>
                </table>
                % if len(form.action["files"].errors):
                    <div class="alert alert-error">
                      ${unicode(form.action["files"].errors) | n}
                    </div>
                % endif

                <button class="btn" data-bind="click: addFile">Add File</button>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">Archives</label>
            <div class="controls">
                ## Data bind for archives (distributed cache)
                <table class="table-condensed designTable" data-bind="visible: archives().length > 0">
                  <tbody data-bind="foreach: archives">
                    <tr>
                      <td><input class="input span5 required pathChooserKo"
                                data-bind="fileChooser: $data, value: name, uniqueName: false" /></td>
                      <td><a class="btn" href="#" data-bind="click: $root.removeArchive">Delete</a></td>
                    </tr>
                  </tbody>
                </table>
                % if len(form.action["archives"].errors):
                    <div class="alert alert-error">
                      ${unicode(form.action["archives"].errors) | n}
                    </div>
                % endif

                <button class="btn" data-bind="click: addArchive">Add Archive</button>
            </div>
        </div>
    </fieldset>

    ## Submit
    <div class="form-actions">
      <button data-bind="click: submit" class="btn btn-primary">Save</button>
      <a href="/jobsub" class="btn">Cancel</a>
    </div>
  </form>

</div>


<div id="chooseFile" class="modal hide fade">
    <div class="modal-header">
        <a href="#" class="close" data-dismiss="modal">&times;</a>
        <h3>Choose a file</h3>
    </div>
    <div class="modal-body">
        <div id="fileChooserModal">
        </div>
    </div>
    <div class="modal-footer">
    </div>
</div>


<style>
	.pathChooser, .pathChooserKo {
		border-radius: 3px 0 0 3px;
		border-right:0;
	}
	.fileChooserBtn {
		border-radius: 0 3px 3px 0;
	}

    #fileChooserModal {
        padding:14px;
        height:270px;
    }

    #fileChooserModal > ul {
        height:230px;
        overflow-y:auto;
    }

	.designTable {
		margin-left:0;
	}
	.designTable th, .designTable td {
	    padding-left: 0;
	}
	.designTable th {
		text-align:left;
	}
</style>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function(){
        var propertiesHint = ${properties_hint};

        // The files and archives are dictionaries in the model, because we
        // can add and remove it the same way we add/remove properties.
        // But the server expects them to be arrays. So we transform the
        // two representations back and forth.
        var arrayToDictArray = function(arr) {
            var res = [ ];
            for (var i in arr) {
                res.push( { name: arr[i], dummy: "" } );
            }
            return res;
        };

        var dictArrayToArray = function(dictArray) {
            var res = [ ];
            for (var i in dictArray) {
                res.push(dictArray[i]["name"]);
            }
            return res;
        };

        // Handles adding autocomplete to job properties.
        // We need to propagate the selected value to knockoutjs.
        var addAutoComplete = function(i, elem) {
            $(elem).autocomplete({
                source: propertiesHint,
                select: function(event, ui) {
                    var context = ko.contextFor(this);
                    context.$data.name = ui.item.value;

                }
            });
        };

        var ViewModel = function(properties, files, archives) {
            var self = this;

            self.properties = ko.observableArray(properties);
            self.files = ko.observableArray(files);
            self.archives = ko.observableArray(archives);
            self.myVar = ko.observable();

            self.addProp = function() {
                self.properties.push({ name: "", value: "" });
                $(".propKey:last").each(addAutoComplete);
            };

            self.removeProp = function(val) {
                self.properties.remove(val);
            };

            self.addFile = function() {
                self.files.push({ name: "", dummy: "" });
            };

            self.removeFile = function(val) {
                self.files.remove(val);
            };

            self.addArchive = function() {
                self.archives.push({ name: "", dummy: "" });
            };

            self.removeArchive = function(val) {
                self.archives.remove(val);
            };

            self.submit = function(form) {
                var form = $("#workflowForm");
                var files_arr = dictArrayToArray(ko.toJS(self.files));
                var archives_arr = dictArrayToArray(ko.toJS(self.archives));

                $("<input>").attr("type", "hidden")
                    .attr("name", "action-job_properties")
                    .attr("value", ko.utils.stringifyJson(self.properties))
                    .appendTo(form);
                $("<input>").attr("type", "hidden")
                    .attr("name", "action-files")
                    .attr("value", JSON.stringify(files_arr))
                    .appendTo(form);
                $("<input>").attr("type", "hidden")
                    .attr("name", "action-archives")
                    .attr("value", JSON.stringify(archives_arr))
                    .appendTo(form);
                form.submit();
            };
        };

        var viewModel = new ViewModel(${properties},
                arrayToDictArray(${files}),
                arrayToDictArray(${archives}));

        ko.bindingHandlers.fileChooser = {
            init: function(element, valueAccessor, allBindings, model) {
				var self = $(element);
				self.after(getFileBrowseButton(self));
            }
        };

        ko.applyBindings(viewModel);

		$(".pathChooser").each(function(){
			var self = $(this);
			self.after(getFileBrowseButton(self));
		});

		function getFileBrowseButton(inputElement) {
			return $("<button>").addClass("btn").addClass("fileChooserBtn").text("..").click(function(e){
				e.preventDefault();
				$("#fileChooserModal").jHueFileChooser({
	                onFileChoose: function(filePath) {
	                    inputElement.val(filePath);
	                    $("#chooseFile").modal("hide");
	                },
	                createFolder: false
	            });
	            $("#chooseFile").modal("show");
			})
		}


        $(".propKey").each(addAutoComplete);
    });
</script>


${commonfooter()}
