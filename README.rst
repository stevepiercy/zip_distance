zip_distance - Calculate the distance between two US ZIP codes with Lasso 8
###########################################################################

Read the article `zip_distance - Calculate the distance between two US ZIP
codes with Lasso 8
<http://www.stevepiercy.com/articles/zip_distance-calculate-the-distance-between-two-us-zip-codes-with-lasso-8/>`_.

Description
===========

``zip_distance`` calculates the distance between two US ZIP codes using Lasso
Professional 8 and MySQL using the Haversine formula.

Demo
====

`Demo <http://www.stevepiercy.com/lasso/zip_distance_demo/>`_.

Usage
=====
``zip_distance`` is a collection of methods.

``[deg2rad]`` converts degrees to radians. Used by ``[calculate_distance]``.

``[calculate_distance]`` calculates the distance in miles between two points on
a sphere from their latitude and longitude using the Haversine formula.

``[zip2latlong]`` accepts a United States ZIP code. Returns a map of keys and
values. "lat" corresponds to the ZIP code latitude, "lon" to its longitude,
and "errors" for errors that may occur.

Inputs are not validated because postal code databases from around the world
have widely different formats and precision with geolocation. Validation
should be added by the developer. Examples for US ZIP codes are provided in
the source of the demo.

Examples
========

.. code-block:: lasso

    local('latlon1') = zip2latlong('95073');
    local('latlon2') = zip2latlong('94103');

    calculate_distance(
        #latlon1->find('lat'),
        #latlon1->find('lon'),
        #latlon2->find('lat'),
        #latlon2->find('lon'));

.. code-block:: text

    => 58.68406933211648635051

Installation and Requirements
=============================

The repository contains collection of methods in the file
``zip_distance.lasso``, an SQL file to build the table, and a directory
``zip_distance_demo`` containing the demo file ``index.lasso``.

Install the file ``zip_distance.lasso`` where you think is best. Either place
it in your Lasso Server's or Site's ``LassoStartup`` or ``LassoLibraries``
directory, restarting the appropriate scope as needed, or include it in the
page that calls the methods. I recommend Lasso Site ``LassoStartup``.

Create a MySQL database or reuse an existing one, setting up Lasso Security as
necessary. In my opinion, it is better to avoid mucking around with Lasso
Security and use the inline ``-host`` connection method for improved speed and
less Lasso SiteAdmin configuration.

Load the file ``zip_codes.sql`` into your MySQL database. This will build the
required table.

Copy the directory ``zip_distance_demo``, and edit the file ``index.lasso`` to
configure the necessary loading method and database connection variables. Save
the file, then place it on your web server and load it in a web browser. Any
configuration errors should be returned.

Notes and Acknowledgments
=========================

All ZIP code information was taken from the `US Census Bureau's Gazetteer
files <http://www.census.gov/geo/maps-data/data/gazetteer.html>`_.

You can use any other data file. There are numerous commercial and educational
providers.  Reference this discussion thread, `Calculate Driving Distance
<http://lasso.2283332.n4.nabble.com/Calculate-Driving-Distance-tp3099745.html>`_.
This thread includes a discussion about methods used to calculate distance.
I am using the Haversine formula because it is less prone to error at short
distances.

The `Zip Code Database Project <http://sourceforge.net/projects/zips>`_
provided the data source.

Bil Corry suggested the Haversine formula (replacing the Law of Cosines in
spherical geometry formula).

Jason Huck corrected my decimal precision syntax.

Updates, suggestions and comments regarding this article may be sent to Steve
Piercy, `web@stevepiercy.com <web@stevepiercy.com>`_ or comment using Disqus.

