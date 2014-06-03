[
// deg2rad function
define_tag('deg2rad', -required='degrees', -description='Converts degrees to radians.');
    return(#degrees/57.295779513082);
/define_tag;

// Function to calculate the distance of the zip codes
// using the latitude and longitude of each
define_tag('calculate_distance',
    -required='lat_a',
    -required='long_a',
    -required='lat_b',
    -required='long_b',
    -description='Calculates the distance in miles between two points on a sphere from their latitude and longitude using the Haversine formula.');

    local('radius') = 3956.54877395;
    local('delta_lat') = deg2rad(#lat_b) - deg2rad(#lat_a);
    local('delta_long') = deg2rad(#long_b) - deg2rad(#long_a);

    local('alpha') = math_pow(math_sin(#delta_lat/2.000000), 2)
        + math_cos(deg2rad(#lat_a))
        * math_cos(deg2rad(#lat_b))
        * math_pow(math_sin(#delta_long/2.000000), 2);

    local('distance') = #radius * 2.00000 * math_asin(math_sqrt(#alpha));
    #distance->setformat(-precision=20);
    return(#distance);
/define_tag;

define_tag('zip2latlong', -required='zipcode', -description='Accepts a United States ZIP code. Returns a map of keys and values. "lat" corresponds to the ZIP code latitude, "lon" to its longitude, and "errors" for errors that may occur.');
    fail_if(!var_defined('cnxnzip'), -10001, '$cnxnzip variable not defined for inline.');
    local('r') = map;
    local('e') = array;
    inline($cnxnzip,
        -sql="
            SELECT latitude, longitude
            FROM `zip_codes`
            WHERE zip = '" + encode_sql(#zipcode) + "'
            LIMIT 1;");
        if(error_code != 0);
            #e->insert(error_code = error_currenterror);
        /if;
        if(found_count != 1);
            #e->insert(-1 = 'Zip code not found in the database.');
        else;
            #r->insert('lat' = decimal(field('latitude')));
            #r->insert('lon' = decimal(field('longitude')));
        /if;
        #r->insert('errors'=#e);
    /inline;
    return(#r);
/define_tag;
]
