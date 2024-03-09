# Parent POM Repository Release Guidelines

_**To ensure smooth releases and maintain consistency, please adhere to the following guidelines.**_  

## Versioning

1. We follow a very simple versioning of our parent-pom releases. Versions are of the form `X.X.X`.
2. Incrementing is done automatically after a release; the developer does not need to touch the versioning in the POM.

## Release Process

_Deployment is automated as much as possible. The latest master is always released._  

1. **Update Release Notes in README.md.**  
_Include the version number as in the POM, the date, the size of the feature, the type of the feature and a very short description of the added feature or the fixed bug._
   
2. **Create a PR of your branch to master.**

3. **After approval and merge of the PR to master, the release is automatically deployed by the CI/CD.**

