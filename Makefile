dependencies: nose django mock mox coverage django-nose

coverage:
	@python -c 'import coverage' 2>/dev/null || pip install coverage

mock:
	@python -c 'import mock' 2>/dev/null || pip install mock==1.0.1

mox:
	@python -c 'import mox' 2>/dev/null || pip install mox

django-nose:
	@python -c 'import django_nose' 2>/dev/null || pip install django-nose

nose:
	@python -c 'import nose' 2>/dev/null || pip install nose

django:
	@python -c 'import django' 2>/dev/null || pip install django

clean:
	@echo "Cleaning up build and *.pyc files..."
	@find . -name '*.pyc' -exec rm -rf {} \;
	@rm -rf build
	@echo "removing (.coverage)"
	@rm -f .coverage
	@echo "removing (test_data)"
	@rm -rf `pwd`/test_data
	@echo "Done!"

test: clean dependencies
	@echo "Running all tests..."
	@mkdir `pwd`/test_data
	@export PYTHONPATH=`pwd`:`pwd`/staticgenerator::$$PYTHONPATH && \
		nosetests -d -s --verbose --with-coverage --cover-inclusive --cover-package=staticgenerator \
			staticgenerator/tests

unit: clean dependencies
	@echo "Running unit tests..."
	@staticgenerator/tests/manage.py test \
			-d -s -v 2 --with-coverage --cover-inclusive --cover-package=staticgenerator \
			staticgenerator/tests/unit
