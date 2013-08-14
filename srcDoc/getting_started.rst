Getting Started
***************

haplorec is divided into two repositories:

#. **haplorec**: backend
#. **haplorec-wui**: web user interface

haplorec is referenced as a git submodule in haplorec-wui (under projects/haplorec).  So, when you 
checkout haplorec-wui, make sure to do:

.. code-block:: sh 

    git clone --recursive https://github.com/innovativemedicine/haplorec-wui.git 

Dependencies
============

You'll want to install the following dependencies before trying to do anything.

Python dependencies 
-------------------
First, install pip if you haven't already `pip <https://pypi.python.org/pypi/pip>`_. Now, to install 
the python dependencies simply do:

.. code-block:: sh 

    pip install -r python-deps.txt

If already have some of these libraries installed as some other version for another project, 
consider using `virtualenv <https://pypi.python.org/pypi/virtualenv>`_:

.. code-block:: sh 

    virtualenv dev                 # creates dev/bin/{python,pip}
    export PATH=$PWD/dev/bin:$PATH # use a local pip/python that installs/uses libraries locally 
    pip install -r python-deps.txt # installs libraries in dev/lib/python2.7

Groovy dependencies
-------------------

**haplorec**

If you're wanting to work on the haplorec repository using `GGTS <http://grails.org/products/ggts>`_, 
it's recommended you checkout the repository separately:

.. code-block:: sh 

    git clone https://github.com/innovativemedicine/haplorec.git 

Assuming you're going this route, you need to install the following dependencies:

* JUnit 4 - http://junit.org/ (hamcrest-core.jar and junit.jar)
* MySQL driver - http://dev.mysql.com/downloads/connector/j/ (mysql-connector-java-5.1.24-bin.jar) 

Stick the jars in a folder, then in Eclipse right-click the jars and add them to your build path.  
If it worked, you'll be able to right-click haplorec in the project view, and run all tests by 
clicking on "Run As > JUnit Test"

**haplorec-wui**

If you're wanting to work on haplorec-wui, all the dependencies for this project should be handled 
by grails' dependency management system when you first attempt to run the application in Eclipse.
This will also take care of the MySQL driver dependency that you needed to manually install for 
haplorec.

Database Setup
==============

The schema for the database is defined in projects/haplorec/src/sql/mysql/haplorec.sql.jinja. The 
templating language `jinja2 <http://jinja.pocoo.org/docs/>`_ is used to pre-process the file (to 
prevent copying and pasting).

To generate the schema, do:

.. code-block:: sh 

    cd projects/haplorec
    make

You can then load the generated schema:

.. code-block:: sh 

    mysql -u root -e 'create database haplorec'
    mysql -u root haplorec < src/sql/mysql/haplorec.sql

The files for loading the haplorec schema are generated from scraping the PharmGKB website.  However 
in case PharmGKB changes (which it has a few times as of writing this), you can simply grab the 
result of scraping PharmGKB (on June 3rd 2013) from the analysis server. 

**NOTE:** If you'd rather scrape PharmGKB to get the latest data, see :ref:`scraping_pharmgkb` (and skip 
this next part).

Download ``/data1/haplorec/scrapy.tar.gz`` from the analysis server, placing it in ``projects/haplorec/tmp`` 
(you'll need to make this directory). 
Then do:

.. code-block:: sh 

    cd projects/haplorec/tmp
    tar xf scrapy.tar.gz

To load the data files, do:

.. code-block:: sh 
    
    cd ../
    make load_haplorec

The following tables should now be loaded (with the following row counts):

* drug_recommendation: 5065
* gene_haplotype_variant: 27087
* genotype_phenotype: 2224
* genotype_drug_recommendation: 5065
* gene_phenotype_drug_recommendation: 0

