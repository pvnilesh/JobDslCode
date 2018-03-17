
# win_tomcat

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with win_tomcat](#setup)
    * [What win_tomcat affects](#what-win_tomcat-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with win_tomcat](#beginning-with-win_tomcat)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

Installs and configures [Apache Tomcat](https://tomcat.apache.org/) on Windows.  You can specify the major and minor versions in {module}/data/common.yaml (Major 7, 8, 9).  

Because this module uses Chocolatey to install Tomcat here are the supported versions.

| Version |
---
| Apache Tomcat 9.0.0-rc |
| Apache Tomcat 8.5.12 |
| Apache Tomcat 8.0.33 |
| Apache Tomcat 8.0.32 |
| Apache Tomcat 8.0.29 |
| Apache Tomcat 8.0.23 |
| Apache Tomcat 8.0.22 |
| Apache Tomcat 8.0.21 |
| Apache Tomcat 8.0.20 |
| Apache Tomcat 8.0.18 |
| Apache Tomcat 7.0.69 |
| Apache Tomcat 7.0.59 |
| More information here: | (https://chocolatey.org/packages/Tomcat/)


This module installs Tomcat to ``` c:\tools\apache-tomcat-{version} ``` and JDK8 to ``` C:\Program Files\Java\{version}\bin  ```

## Setup

### What win_tomcat affects **OPTIONAL**

This does install Java JDK onto the system.  If you have another version installed or need to run a separate instance please make sure that it does not interfere with your other applications.  


### Beginning with win_tomcat  

Basic setup is to include the module in your class.

```ruby
include win_tomcat
```

## Usage

More to come here...

## Reference

You should be and stay aware of the End-of-life (EOL) of Tomcat.  Check here for the status of their products. [Tomcat 8 EOL](https://tomcat.apache.org/tomcat-80-eol.html)

## Limitations

This has been tested on Windows 2012 R2 and Windows 2016 base installations.  

## Development

Fork it, develop it, push it.  Or just give feedback, you won't hurt my feelings."

## Release Notes/Contributors/Etc. **Optional**

 
