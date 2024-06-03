#!/bin/bash

DIR=/Users/$USER/.ssh

key=$(cat "$DIR/id_rsa")

echo "$key"