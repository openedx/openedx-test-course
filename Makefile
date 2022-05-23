.PHONY: clean help tar untar import

REPO_NAME=openedx-test-course

COURSE=test-course
COURSE_TAR=$(COURSE).tar.gz
PROBLEM_BANK=test-problem-bank
PROBLEM_BANK_TAR=$(PROBLEM_BANK).tar.gz

TUTOR:=tutor
MOUNT_REPO=--mount='cms,cms-worker:.:/openedx/data/$(REPO_NAME)'

help: ## display this help message
	@echo "Please use \`make <target>' where <target> is one of"
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | sort | awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

clean: ## delete all course and library tarballs
	rm -f $(COURSE_TAR) $(PROBLEM_BANK_TAR)

tar: # create/overwrite tars for test course and for each test library
	cd $(COURSE) && tar czfv ../$(COURSE_TAR) ./course/
	cd $(PROBLEM_BANK) && tar czfv ../$(PROBLEM_BANK_TAR) ./library/

untar: ## unpack all existent tars of test course and libraries
	[ -f $(COURSE_TAR) ] && (cd $(COURSE) && tar xzfv ../$(COURSE_TAR))
	[ -f $(PROBLEM_BANK_TAR) ] && (cd $(PROBLEM_BANK) && tar xzfv ../$(PROBLEM_BANK_TAR))

import: tar ## import course and libraries into a locally-running Tutor instance. assumes admin user exists.
	yes | \
	$(TUTOR) local run $(MOUNT_REPO) cms \
		./manage.py cms import_content_library /openedx/data/$(REPO_NAME)/$(PROBLEM_BANK_TAR) admin
	$(TUTOR) local run $(MOUNT_REPO) cms \
		./manage.py cms import /openedx/data $(REPO_NAME)/$(COURSE)/course
	$(TUTOR) local run cms \
		./manage.py cms reindex_course --all --setup
