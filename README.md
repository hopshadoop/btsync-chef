Description
===========

Installs and configures btsync.

Requirements
============
Chef 0.10.10+.

Platform
-------- 
* Ubuntu, Debian 


Tested on:

* Ubuntu 10.04-12.04


Attributes
==========

Usage
=====

On a node that provides both a Management Server and a MySQL Server, use both the mgmd and mysqld recipes:

    { "run_list": ["recipe[btsync::install]", "recipe[btsync::ndb]" }

This will install btsync, and start an instance to share install files for ndb.
To install btsyn, and start an instance to share install files for java, run:

    { "run_list": ["recipe[btsync::install]", "recipe[btsync::java]" }

You can override attributes in your node or role.
The 'bootstrap' attribute must be set to either true or false: true for the node that will run the btsync 'server' (the Dashboard),
and false for the nodes that will install the software.

For example, on an Ubuntu system:

    {
      "btsync": {
        "bootstrap": "true",
        "ndb": { 
	         "seeder" : "ip-address",
	         "leechers" : ["ip1", "ipn"],
	         "seeder_secret" : "some_password",
	         "leecher_secret" : "some_password"
               },
        "java": { 
	         "seeder" : "ip-address",
	         "leechers" : ["ip1", "ipn"],
	         "seeder_secret" : "some_password",
	         "leecher_secret" : "some_password"
               }

      }
    }