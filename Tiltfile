#!/usr/bin/env python

update_settings(max_parallel_updates = 6)

local_resource('git', cmd='bash -c "install -m 0755 etc/post-commit .git/hooks/post-commit"', allow_parallel = True)
local_resource('proxy', cmd='bash -c "cd fly && make login start-docker proxy"', allow_parallel = True)
local_resource('ping', cmd='bash -c "cd fly && sleep 540 && make ping-docker"', allow_parallel = True)
local_resource('tunnel', cmd='bash -c "cd fly && make tunnel-docker"', allow_parallel = True)
local_resource('monitor', cmd='bash -c "make monitor"', allow_parallel = True)
local_resource('cicd', cmd='bash -c "time env DOCKER_HOST=localhost:2375 make ci"', deps=['.test'], allow_parallel = True)
