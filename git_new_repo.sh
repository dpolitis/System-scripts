#!/bin/bash

curl -u 'dpolitis' https://api.github.com/user/repos -d '{"name":"ad-hoc-net","description":"Self Organized Ad-Hoc Networks"}'
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/dpolitis/ad-hoc-net.git
git push -u origin master
