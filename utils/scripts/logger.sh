#!/bin/bash

msg() {
    # Redirect stdout to stderr
    echo >&2 -e "${1-}"
}

log_levels=(
    "info:blue"
    "error:red"
    "success:green"
    "warning:orange"
    "debug:light_grey"
)

for log in "${log_levels[@]}"; do
    log_name="${log%%:*}"
    log_color="${log##*:}"

    generate_logger=$(cat <<EOF
    log_${log_name}() {
        local name=$(echo ${log_name} | tr a-z A-Z)
        local color=$(echo ${log_color} | tr a-z A-Z)
        if [ -z "\${COLORS_DEFINED}" ] || [ \${COLORS_DEFINED} -eq 0 ]; then
            msg "[\${name}]: \${1-}"
        else
            local color_value=\$(eval echo \"\\$\$color\") 
            msg "[\${color_value}\${name}\${NOFORMAT}]: \${1-}"
            # msg "[\${!color}\${name}\${NOFORMAT}]: \${1-}"
        fi
    }
EOF
)
    eval "${generate_logger}"
done


