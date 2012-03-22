<%namespace name="wrappers" file="header_footer.mako" />
${wrappers.head("Beeswax: Database List", section='databases')}
  <!-- <div class="toolbar">
    <div class="bw-show_tables_subnav" data-filters="ArtButtonBar">
      <a href="${ url('beeswax.create_table.index') }" data-filters="ArtButton" class="bw-new_table" data-icon-styles="{'width': 16, 'height': 16, 'top': 1}">new database</a>
    </div>
  </div> -->

<div id="show_tables" class="view">
  <h2 class="jframe-hidden">Databases</h2>
  <div class="toolbar">
    <div class="bw-input-filter">
      <input type="text" class="jframe-hidden" data-filters="OverText, ArtInput, FilterInput" data-art-input-type="search"
        title="Filter by Name"
        data-filter-elements="td.bw-tables_table" data-filter-parents="tr" value=""/>
    </div>
  </div>
  <table data-filters="HtmlTable" class="selectable sortable" cellpadding="0" cellspacing="0">
    <thead>
      <tr>
        <th>Database Name</th>
      </tr>
    </thead>
    <tbody>
      % for database in databases:
        <tr data-dblclick-delegate="{'dblclick_loads':'.bw-tables_table a'}" class="jframe-no_select">
          <td class="bw-tables_table jframe-no_select">
            <a href="${ url("beeswax.views.show_tables", database=database) }">${ database }</a>
            <!-- <p class="jframe-inline" data-filters="HelpTip">TODO</p> -->
          </td>
        </tr>
      % endfor
    </tbody>
  </table>
</div>
${wrappers.foot()}