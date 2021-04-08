#!/bin/bash
phddns start
phddns status > /phddns.log
tail -f phddns.log
