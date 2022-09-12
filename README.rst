Open edX Test Course (and Test Libraries)
#########################################

Contents
********

This repository contains the raw Open Learning XML (OLX) of:

* A course named **"Open edX Test Course"** and the key ``course-v1:TestX+Course+1``.
* A library named **"Open edX Test Problem Bank"** and the key ``library-v1:TestX+ProblemBank``.

In the future, it will also contain:

* A library named **"Open edX Test Video Bank"** and the key ``library-v1:TestX+VideoBank``.
* A library named **"Open edX Test Text Bank"** and the key ``library-v1:TestX+TextBank``.
* A library named **"Open edX Test Mixed Library"** and the key ``library-v1:TestX+MixedLibrary``.
* A few v2 (Blockstore-backed) libraries, when they import/export of them is supported.

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

To use this course and its libraries, you will need to import them into an Open edX instance. As of June 2022, this has been tested with both Maple and Nutmeg.

First, generate the ``tar.gz`` archives for the test course and each test library::

  make tar

Then, if you are running Open edX via Tutor, you can import the test course and libraries with::

  make import TUTOR=... TUTOR_CONTEXT=... LIBRARY_IMPORT_USER=...
  
where:

* ``TUTOR`` should be the command that you use to run Tutor (defaults to simply ``tutor``).
* ``TUTOR_CONTEXT`` should be the mode in which you want to import the course (defaults to ``local``, other acceptable values are ``k8s`` and ``dev``).
* ``LIBRARY_IMPORT_USER`` is the username of an existing user in your Open edX instance that will be given ownership of the imported library (defaults to ``admin``).

For example::

  make import TUTOR='tutor --root=~/tutor-root' TUTOR_CONTEXT=dev LIBRARY_IMPORT_USER=alice

Otherwise, if you do not have command-line access to your instance or if it's not Tutor-managed, then you can always import the course manually via Studio:

1. Create a library in Studio with the org ``TestX`` and the slug ``ProblemBank``.
2. Import ``test-problem-bank.tar.gz`` into the library.
3. Create a course run in STudio with the org ``TestX``, name ``Course``, and run ``1``.
4. Import ``test-course.tar.gz`` into the course run.

Contributing
************

There are two ways you can make changes to this course.

OLX Editing
===========

If you are experienced with editing raw OLX, then you can make changes directly in this repository. Before opening a pull request, please test out your changes by building the ``.tar.gz`` archives, importing them into an Open edX Studio (as described above), and ensuring the course still works as expected, both in Studio and in LMS.

Studio Editing
==============

Once you've built the ``.tar.gz`` archives and importing them into an Open edX instance (as described above), you can edit the course and its libraries in Studio. Make sure to publish any changes you make and test them out in LMS.

When you're ready to contribute the changes back into this repository, simply:

1. Export the course and any library you changed.
2. Move to exported `.tar.gz` archives into this repository and name them to match the folders. For example, the course archive should be named ``test-course.tar.gz``, and the problem bank archive should be named ``test-problem-bank.tar.gz``.
3. Run ``make untar``, which will unpack the archives into your local repository.
4. Review your changes using ``git diff``.
5. Commit your changes and open a pull request.

Tag @openedx/openedx-test-course-maintainers in all pull requests. We'll do our best to take a look! All pull requests should pass the GitHub Actions suite, which ensures that the course and libraries can be imported into a freshly-provisioned Tutor instance.

License
*******

All content is made available under a `Creative Commons BY-NC-SA 3.0 US
License <http://creativecommons.org/licenses/by-nc-sa/3.0/us/>`_.

All code is made available under an `AGPLv3 License <./AGPL_LICENSE>`_
