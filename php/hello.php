<?php
require __DIR__ . '/vendor/autoload.php';

$version = \Composer\InstalledVersions::getPrettyVersion('mongodb/mongodb');
echo "Ping from mongo-php-library {$version} ...\n";

$client = new MongoDB\Client('mongodb://localhost:27017');
$client->admin->command(['ping' => 1]);

echo "Ping from mongo-php-library {$version} ... OK\n";

// TODO: add your code here
