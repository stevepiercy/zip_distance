[
// Either load the file zip_distance.lasso during server or site startup,
// in server or site library, or include it.  Choose one method.
// I recommend site startup.
// include('zip_distance.lasso'); // optional loading method

// Configure your database connection variable for $cnxnzip.
// Used in the tag zip2latlong.
// You can configure it here or put it in a site/server startup/library item.
var('cnxnzip') = array(
    -host=array(
        -datasource='mysqlds',
        -name='localhost',
        -username='XXXXXXXX', // configure this
        -password='XXXXXXXX', // configure this
        -tableencoding='utf-8'),
    -database='XXXXXXXX'); // configure this

]<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>zip_distance by Steve Piercy</title>
</head>
<body>
    <h1>zip_distance by Steve Piercy</h1>
    <p>Calculate the distance between two United States ZIP Codes.</p>
    <form method="post" action="[response_filepath]">
        ZIP Code One: <input type="text" name="one" size="7" maxlength="5" value="[action_param('one')]"><br />
        ZIP Code Two: <input type="text" name="two" size="7" maxlength="5" value="[action_param('two')]"><br />
        <input type="submit" name="submit" value="Get Distance">
    </form>
[
// validate inputs
local('errors') = array;
if(action_param('submit') != '');
    // validate inputs
    if(action_param('submit') != 'Get Distance');
        #errors->insert('You must click the "Get Distance" button.');
    /if;

    if(string_findregexp(action_param('one'), -find='\\D')->size
        || action_param('one')->size != 5);
        #errors->insert('ZIP Code One must be exactly five digits.');
    /if;

    if(string_findregexp(action_param('two'), -find='\\D')->size
        || action_param('two')->size != 5);
        #errors->insert('ZIP Code Two must be exactly five digits.');
    /if;

    if(action_param('one') == action_param('two'));
        #errors->insert('ZIP Codes One and Two must be different.');
    /if;

    if(#errors->size == 0);
        // inputs are valid
        // let's find the latitudes and longitudes of two ZIP Codes
        // by looking them up in the database
        local('latlon1') = zip2latlong(action_param('one'));
        local('latlon2') = zip2latlong(action_param('two'));

        if(#latlon1->find('errors')->size == 0
            && #latlon2->find('errors')->size == 0);
            '<p>'
            + calculate_distance(
                #latlon1->find('lat'),
                #latlon1->find('lon'),
                #latlon2->find('lat'),
                #latlon2->find('lon'))
            + ' miles.</p>';
        else;
            '<p style="color:red; font-weight:bold;">';
            #latlon1->find('errors')->join('<br />');
            '</p>';
        /if;
    else;
        '<p style="color:red; font-weight:bold;">';
        #errors->join('<br />');
        '</p>';
    /if;
/if;
]
<p>
<a href="http://www.stevepiercy.com/zip_distance-calculate-the-distance-between-two-us-zip-codes-with-lasso-8.html">Read the article zip_distance</a>.
</p>
</body>
</html>
