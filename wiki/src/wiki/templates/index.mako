<%!from desktop.views import commonheader, commonfooter %>

${commonheader("Wiki", "wiki", "100px")}

## use double hashes for a mako template comment

## this id in the div below ("index") is stripped by Hue.JFrame
## and passed along as the "view" argument in its onLoad event

## the class 'jframe_padded' will give the contents of your window a standard padding
<div class="subnav subnav-fixed">
	<div class="container-fluid">
	<ul class="nav nav-pills">
		<li></li>
	</ul>
	</div>
</div>

<div class="container-fluid">
  <h2>Wiki app is successfully setup!</h2>
  <p>It's now ${date}.</p>
    % for app in apps:
    <p>Number of apps: <a href="/${app.display_name}">${app.nice_name}</a></p>

    %endfor
</div>

${commonfooter()}