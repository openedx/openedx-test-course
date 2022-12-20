Open edX Test Course (and Test Libraries)
#########################################

Contents
********

This repository contains a course and some libraries that you can import into your Open edX instance to test out platform features. For convenience, we include both:

* The ``.tar.gz`` files for you to import into Studio, located in the ``./dist/`` folder.
* The source code (a.k.a. "OLX") in the other top-level folders.

.. list-table::
   :header-rows: 1

   * - Name
     - Key
     - Download
     - Source OLX
   * - *Open edX Test Course*
     - ``course-v1:TestX+Course+1``
     - `<./dist/test-course.tar.gz>`_
     - `<./test-course>`_
   * - *Open edX Test Problem Bank*
     - ``library-v1:TestX+ProblemBank``
     - `<./dist/test-problem-bank.tar.gz>`_
     - `<./test-problem-bank>`_

In the future we hope to add more libraries, including a video bank, text bank, mixed library, and blockstore-based libraries.

Rationale
*********

In order to make testing Open edX easier,
this course and its associated libraries aim to expose as many Open edX Studio & courseware features as possible.
It does so by providing example usages of various block types and by enabling various features through Advanced Settings. 

This course serves as a supplement to the simpler & more curated 
`Open edX Demo Course <https://github.com/openedx/openedx-demo-course>`_,
which is useful for basic testing, but also needs to remain a suitable first experience for Open edX learners.

Status
******

This course is new as of the Nutmeg (June 2022) release.
It is pretty barebones and rough around the edges.
As we continue to use it to test releases, it will likely become more comprehensive and more polished. 

Currently, the test course contains at least one usage of all advanced block types that come pre-installed in edx-platform.
Some of the block usages aren't yet configured in a useful way;
for example, the LTI Consumer block usage exists, but it isn't set up to consume an LTI tool yet.

Desired test content
====================

Looking to contribute? Here a few areas where we could use more content:

* Actual tool launches for various configurations of ``lti`` and ``lti_consumer`` blocks.
* Use of content groups for units and sequences. Currently, content groups are only tested at the component (sub-unit) level.
* Use of custom Python in Advanced LONCAPA problems.
* Examples usages of start/end dates, beta-released content, etc.
* Handouts, static tabs, and other advanced uses of the Course Home.

Usage
*****

To use this course and its libraries, you will need to import them into an Open edX instance. As of Dec 2022, this has been tested with Maple, Nutmeg, and Olive.

Manual import
=============

In Studio:

1. Create a library with the org ``TestX`` and the slug ``ProblemBank``.
2. Import ``dist/test-problem-bank.tar.gz`` into the library.
3. Create a course run with the org ``TestX``, name ``Course``, and run ``1``.
4. Import ``dist/test-course.tar.gz`` into the course run.

Scripted import (for Tutor users)
=================================

In the same environment that use to run tutor, execute the command::

  make import TUTOR=... TUTOR_CONTEXT=... LIBRARY_IMPORT_USER=...
  
where:

* ``TUTOR`` should be the command that you use to run Tutor (defaults to simply ``tutor``).
* ``TUTOR_CONTEXT`` should be the mode in which you want to import the course (defaults to ``local``, other acceptable values are ``k8s`` and ``dev``).
* ``LIBRARY_IMPORT_USER`` is the username of an existing user in your Open edX instance that will be given ownership of the imported library (defaults to ``admin``).

For example::

  # Import in developer mode using a custom tutor root, and make alice the library admin.
  make import TUTOR='tutor --root=~/tutor-root' TUTOR_CONTEXT=dev LIBRARY_IMPORT_USER=alice

Or::

  # Import in kubernetes mode, and make bob the library admin.
  make import TUTOR_CONTEXT=k8s LIBRARY_IMPORT_USER=bob

Re-generating the importable content
====================================

If you make changes to the course or library OLX and want to re-generate the importable ``.tar.gz`` files, simply run::

  make dist

This will package the OLX into the ``dist`` directory.

Contributing
************

There are two ways you can make changes to this course.

OLX Editing
===========

If you are experienced with editing raw OLX, then you can make changes directly to the XML and asset files this repository. Before opening a pull request, please:

* Run ``make dist``, which will generate the ``dist/*.tar.gz`` archives. Include these changes in your commit.
* Import the updated ``dist/*.tar.gz`` archives into an Open edX Studio (as described above) and ensure the test course still works as expected, both in Studio and LMS.

Studio Editing
==============

Once you've imported the test course and libraries into an Open edX instance (as described above), you can edit the course and its libraries in Studio. Make sure to Publish any changes you make from Studio so that you can test them out in LMS.

When you're ready to contribute the changes back into this repository, simply:

1. Export the course and any libraries you changed.
2. Move to exported ``.tar.gz`` archives into this repository's ``dist/`` folder, and name them to match the top-level OLX folders. For example, the course archive should be named ``dist/test-course.tar.gz``, and the problem bank archive should be named ``dist/test-problem-bank.tar.gz``.
3. Run ``make unpack``, which will unpack the archives into OLX.
4. Review your OLX changes using ``git diff``.
5. Commit your changes and open a pull request.

Tag @openedx/openedx-test-course-maintainers in all pull requests. We'll do our best to take a look! All pull requests should pass the GitHub Actions suite, which ensures that the course and libraries can be imported into a freshly-provisioned Tutor instance.

License
*******

All content is made available under a `Creative Commons BY-NC-SA 3.0 US
License <http://creativecommons.org/licenses/by-nc-sa/3.0/us/>`_.

All code is made available under an `AGPLv3 License <./AGPL_LICENSE>`_
