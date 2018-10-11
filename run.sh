#!/bin/bash

#robot redmine-set.robot
xvfb-run --auto-servernum --server-num=1 --server-args="screen 0 1540x1380x24" robot redmine-set.robot
