#!/bin/bash

set -e

sudo=/usr/bin/sudo
test -x $sudo || sudo=

$sudo apt-get update
$sudo apt-get install -qq puppet
$sudo apt-get update

test -r /etc/puppet/modules/etckeeper || $sudo puppet module install thomasvandoren-etckeeper
test -r /etc/puppet/modules/stdlib || $sudo puppet module install puppetlabs-stdlib
test -r /etc/puppet/modules/docker|| $sudo puppet module install garethr-docker

$sudo puppet apply /vagrant/puppet/manifests/debian.pp
