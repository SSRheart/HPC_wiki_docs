#!/bin/bash
mkdocs build
cp -r site/* /usr/local/apache2/htdocs/docs
 
