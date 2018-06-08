# install_mongo

TODO: Enter the cookbook description here.
1. Prerequisites/assumptions for Mongo Installation Cookbook:
- Target node is Centos 7
- Target node has access to the interwebs
- Chef server is Hosted Chef instance
- root access on target node - understood that sudo would be more likely in production

2. Workshop summary & overview
- Minimum viable product - cookbook works and can be executed multiple times without error
- For production version, the following approach would be added:
  - additional template files
  - incorporate other recipes for MongoDB deployment (for example)
  - less use of bash and execute

3. Recipe takes the following approach:
- Lays down the yum repository file for MongoDB with appropriate file permissions & ownership
- installs the policycoreutils-python package to support use of semanage command (not loaded on Centos 7 by default)
- installs the MongoDB yum packages
- ensure the MongoDB default port is open - a better approach here would be to leverage either Chef Marketplace MongoDB cookbook to configure specific parameters for Mongo.
- For port management, a better approach would be to check if the port is already open rather than using returns [0,1]
- enables the MongoDB services and ensures it starts
