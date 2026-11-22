#!/bin/sh
set -eu

pam_file=/etc/pam.d/login
auth_anchor='^[[:space:]]*auth[[:space:]]+include[[:space:]]+system-local-login[[:space:]]*$'
session_anchor='^[[:space:]]*session[[:space:]]+include[[:space:]]+system-local-login[[:space:]]*$'

if ! grep -Eq "$auth_anchor" "$pam_file" ||
   ! grep -Eq "$session_anchor" "$pam_file"; then
    printf 'Unexpected PAM login configuration: %s\n' "$pam_file" >&2
    exit 1
fi

if ! grep -Eq '^[[:space:]]*auth[[:space:]]+optional[[:space:]]+pam_oo7[.]so[[:space:]]*$' "$pam_file"; then
    sudo sed -E -i "/$auth_anchor/a auth optional pam_oo7.so" "$pam_file"
fi

if ! grep -Eq '^[[:space:]]*session[[:space:]]+optional[[:space:]]+pam_oo7[.]so[[:space:]]+auto_start[[:space:]]*$' "$pam_file"; then
    sudo sed -E -i "/$session_anchor/a session optional pam_oo7.so auto_start" "$pam_file"
fi

passwd_file=/etc/pam.d/passwd
password_anchor='^[[:space:]]*password[[:space:]]+include[[:space:]]+system-auth[[:space:]]*$'

if ! grep -Eq "$password_anchor" "$passwd_file"; then
    printf 'Unexpected PAM password configuration: %s\n' "$passwd_file" >&2
    exit 1
fi

if ! grep -Eq '^[[:space:]]*password[[:space:]]+optional[[:space:]]+pam_oo7[.]so[[:space:]]*$' "$passwd_file"; then
    sudo sed -E -i "/$password_anchor/a password optional pam_oo7.so" "$passwd_file"
fi
