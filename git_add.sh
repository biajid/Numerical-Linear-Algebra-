#!/bin/bash
git add "$1";
git commit -m "$1 added";
git push origin main;
echo "done";