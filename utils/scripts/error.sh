#!/bin/bash

import_script utils/logger

die_with_error() {
    log_error ${1-"Blank message"}
    exit 1
}
