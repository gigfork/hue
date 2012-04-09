Welcome to the repository for Hue
=================================

.. note::
    This is the development-oriented readme. If you want to write notes for
    end users, please put them in ``dist/README``.

Hue is both a web UI for Hadoop and a framework to create interactive web
applications.  It features a FileBrowser for accessing HDFS, JobSub and
JobBrowser applications for submitting and viewing MapReduce jobs, a Beeswax
application for interacting with Hive.  On top of that, the web frontend
is mostly built from declarative widgets that require no JavaScript and are
easy to learn.


File Layout
===========
The "core" stuff is in ``desktop/core/``, whereas installable apps live in
``apps/``.  Please place third-party dependencies in the app's ext-py/
directory.

The typical directory structure for inside an application includes:

  src/
    for Python code

  conf/
    for configuration (``.ini``) files to be installed

  static/
    for static HTML and js resources

  templates/
    for data to be put through a template engine

  docs/
    for helpful notes

The python code is structured simply as
``module/package.py``,
where module may be "filebrowser" or "jobsub".  Because it is unlikely that
there are going to be huge conflicts, we're going without a deep nested
hierarchy.


URL Layout
==========
``core/src/desktop/urls.py`` contains the current layout for top-level URLs.
For the URLs within your application, you should make your own ``urls.py``
which will be automatically rooted at ``/yourappname/`` in the global
namespace.  See ``apps/hello/src/hello/urls.py`` for an example.


Development Prerequisites
===========================
You'll need these library development packages and tools installed on
your system:

    Debian:
      * ant
      * asciidoc
      * gcc
      * g++
      * libkrb5-dev
      * libmysqlclient-dev
      * libsasl2-dev
      * libsqlite3-dev
      * libxml2-dev
      * libxslt-dev
      * mvn (from ``maven2`` package or tarball)
      * openldap-dev
      * python-dev
      * python-simplejson

    CentOS:
      * ant
      * asciidoc
      * cyrus-sasl-devel
      * gcc
      * gcc-c++
      * krb5-devel
      * libxml2-devel
      * libxslt-devel
      * mvn (from ``maven2`` package or tarball)
      * mysql
      * mysql-devel
      * openldap-devel
      * python-devel
      * python-simplejson
      * sqlite-devel

    MacOS (mac port):
      * liblxml
      * libxml2
      * libxslt
      * mysql5-devel
      * simplejson (easy_install)
      * sqlite3


Getting Started
===============
To build and get the core server running::

    $ export HADOOP_HOME=<path-to-hadoop-home>
    $ git clone http://github.com/cloudera/hue.git
    $ cd hue
    $ make apps
    $ build/env/bin/hue runserver_plus

To start the helper daemons::

    $ build/env/bin/hue beeswax_server
    $ build/env/bin/hue jobsubd

Now Hue should be running on http://localhost:8000.


FAQ
===
1: What does "Exception: no app!" mean?
    Your template has an error in it.  Check for messages from the server that
    look like::

        INFO:root:Processing exception: Unclosed tag 'if'. Looking for one of: else, endif

2: What do I do if I get "There was an error launching ..."?
    Turn on debugging by issuing ``dbug.cookie()`` in a Firebug console.


Django Conventions
==================
If you need to name your urls
(http://docs.djangoproject.com/en/dev/topics/http/urls/#naming-url-patterns)
because there's ambiguity in the view, be sure to prefix the name
with the application name.  The url name namespace is global.  So
``jobsub.list`` is fine, but ``list`` is not.

Hue is using Django 1.2, which supports the notion of URL namespaces:
http://docs.djangoproject.com/en/dev/topics/http/urls/#url-namespaces.
We have yet to move over our URLs to this construct. Brownie points for the
developer who takes this on.


Using and Installing Thrift
===========================
Right now, we check in the generated thrift code.
To generate the code, you'll need the thrift binary version 0.7.0.
Please download from http://thrift.apache.org/.

When preparing ``.thrift`` files, you can use she-bangs to generate
the python bindings like so::

    #!/usr/bin/env thrift -r --gen py:new_style -o ../../../


Profiling Hue Apps
==================
Hue has a profiling system built in, which can be used to analyze server-side
performance of applications.  To enable profiling::

    $ build/env/bin/hue runprofileserver

Then, access the page that you want to profile.  This will create files like
/tmp/useradmin.users.000072ms.2011-02-21T13:03:39.745851.prof.  The format for
the file names is /tmp/<app_module>.<page_url>.<time_taken>.<timestamp>.prof.

Hue uses the hotshot profiling library for instrumentation.  The documentation
for this library is located at: http://docs.python.org/library/hotshot.html.

To make use of the profiling data quickly, you can create a script that does
the following::

    #!/usr/bin/python
    import hotshot.stats
    import sys

    stats = hotshot.stats.load(sys.argv[1])
    stats.sort_stats('cumulative', 'calls')
    stats.print_stats(100)

This script takes in a .prof file, and orders function calls by the cumulative
time spent in that function, followed by the number of times the function was
called, and then prints out the top 100 time-wasters.  For information on the
other stats available, take a look at this website:
http://docs.python.org/library/profile.html#pstats.Stats

