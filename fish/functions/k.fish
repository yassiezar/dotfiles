####################################
# Kubernetes Aliases & Functions (Fish Shell)
#
# A collection of kubectl wrappers with:
#   - Safety guards for production contexts
#   - Auto-retry port-forwarding
#   - Pod shell access with bash/sh fallback
#   - Tab completion specifically built for fish
####################################

# --- Configuration ---
# Add your production/sensitive context names here
set -g UNSAFE_CONTEXTS "gke_fruitcast-web-development_europe-west2_pluto-prod"

####################################
# k_guard - Safety check before kubectl commands
####################################
function k_guard
    if set -q K_SKIP_GUARD; and test "$K_SKIP_GUARD" -eq 1
        return 0
    end

    set -l current_context (kubectl config current-context)
    
    for context in $UNSAFE_CONTEXTS
        if string match -q "*$context*" "$current_context"
            echo -e "Warning: You are about to execute a command in the unsafe context:\n "(set_color yellow)"'$current_context'"(set_color normal)
            
            read -l -P "Do you want to continue? (y/N) " response
            if not string match -q -i 'y' "$response"
                echo "Aborting command execution in unsafe context"
                return 1
            end
        end
    end

    echo -e "Executing command in context:\n "(set_color yellow)"'$current_context'"(set_color normal)
    echo -e "To skip these prompts, set the environment variable "(set_color yellow)"'K_SKIP_GUARD=1'"(set_color normal)
    echo "----------------------------------------"
    return 0
end

####################################
# k - kubectl wrapper with safety guard
####################################
function k
    if test (count $argv) -eq 0
        echo -e "Usage: "(set_color yellow)"k [kubectl_command]"(set_color normal)
        return 1
    end
    k_guard; or return 1
    kubectl $argv
end

####################################
# kc - Show current kubectl context
####################################
function kc
    set -l current_context (kubectl config current-context)
    echo -e "Current context: "(set_color yellow)"'$current_context'"(set_color normal)
end

####################################
# kpf - Port-forward with auto-retry
####################################
function kpf
    if test (count $argv) -lt 3
        echo -e "Usage: "(set_color yellow)"kpf NAMESPACE POD_SELECTOR LOCAL_PORT1:REMOTE_PORT1 [LOCAL_PORT2:REMOTE_PORT2...] [--context CONTEXT]"(set_color normal)
        echo -e "Example: "(set_color yellow)"kpf default services/minio 9200:9000 9201:9001"(set_color normal)
        return 1
    end

    # Only run guard if not explicitly specifying a different context
    if not contains -- "--context" $argv
        k_guard; or return 1
    end

    set -l namespace $argv[1]
    set -l pod_selector $argv[2]
    
    set -l port_mappings
    set -l other_args

    # Separate port mappings from other args
    for arg in $argv[3..-1]
        if string match -q "*:*" "$arg"
            set -a port_mappings "$arg"
        else
            set -a other_args "$arg"
        end
    end

    set -l attempt 1
    set -l max_delay 30

    if test (count $port_mappings) -eq 0
        echo -e "Error: "(set_color red)"No port mappings specified"(set_color normal)
        return 1
    end

    echo -e "Starting port-forward to "(set_color yellow)"$pod_selector"(set_color normal)" on ports "(set_color yellow)"$port_mappings"(set_color normal)" in namespace "(set_color yellow)"$namespace"(set_color normal)
    if test (count $other_args) -gt 0
        echo -e "Additional args: "(set_color yellow)"$other_args"(set_color normal)
    end
    echo "Press Ctrl+C to stop..."

    set -l cmd_str "kubectl port-forward -n $namespace $pod_selector $port_mappings $other_args"
    echo -e "Executing:\n"(set_color yellow)"$cmd_str"(set_color normal)"\n"

    while true
        echo "Attempt $attempt: connecting..."
        
        kubectl port-forward -n "$namespace" "$pod_selector" $port_mappings $other_args
        set -l exit_code $status
        set -l delay 2

        # Catch Ctrl+C cleanly (status 130)
        if test $exit_code -eq 130
            echo -e "\nPort-forward stopped."
            break
        end

        if test $exit_code -ne 0
            if test $attempt -lt 5
                set delay (math "2^$attempt")
            else
                set delay $max_delay
            end
            if test $delay -gt $max_delay; set delay $max_delay; end
            echo "Port-forward failed with exit code $exit_code. Retrying in $delay seconds..."
        else
            echo "Port-forward exited with code $exit_code. Restarting in $delay seconds..."
        end

        sleep $delay
        set attempt (math "$attempt + 1")
    end
end

####################################
# kbash - Exec into a pod with bash (falls back to sh)
####################################
function kbash
    set -l namespace ""
    set -l pod ""
    set -l container ""
    set -l argc (count $argv)

    if test $argc -eq 1
        set pod $argv[1]
        set namespace "default"
    else if test $argc -eq 2
        set namespace $argv[1]
        set pod $argv[2]
    else if test $argc -eq 3
        set namespace $argv[1]
        set pod $argv[2]
        set container $argv[3]
    else
        echo -e "Usage: "(set_color yellow)"kbash [namespace] pod_name [container_name]"(set_color normal)
        return 1
    end

    set -l cmd_arr kubectl exec -it
    if test -n "$namespace"
        set -a cmd_arr -n "$namespace"
    end
    
    set -a cmd_arr "$pod"
    
    if test -n "$container"
        set -a cmd_arr -c "$container"
    end

    set -l bash_cmd_arr $cmd_arr -- /bin/bash
    echo -e (set_color yellow)"Executing: $bash_cmd_arr"(set_color normal)

    if not command $bash_cmd_arr 2>/dev/null
        echo -e (set_color yellow)"bash not found, trying sh..."(set_color normal)
        set -l sh_cmd_arr $cmd_arr -- /bin/sh
        command $sh_cmd_arr
    end
end

####################################
# --- Register Completions ---
####################################

# 1. Inherit all kubectl completions for 'k'
complete -c k -w kubectl

# 2. kpf Completions
complete -c kpf -f
complete -c kpf -n "test (count (commandline -opc)) -eq 1" -a "(kubectl get namespaces -o custom-columns=NAME:.metadata.name --no-headers 2>/dev/null)"
complete -c kpf -n "test (count (commandline -opc)) -eq 2" -a "(set -l cmd (commandline -opc); kubectl -n \$cmd[2] get deployments,services,pods -o=name 2>/dev/null)"

# 3. kbash Completions
complete -c kbash -f
complete -c kbash -n "test (count (commandline -opc)) -eq 1" -a "(kubectl get namespaces -o=name 2>/dev/null | cut -d/ -f2; kubectl get pods -o=name 2>/dev/null | cut -d/ -f2)"
complete -c kbash -n "test (count (commandline -opc)) -eq 2" -a "(set -l cmd (commandline -opc); kubectl -n \$cmd[2] get pods -o=name 2>/dev/null | cut -d/ -f2)"
complete -c kbash -n "test (count (commandline -opc)) -eq 3" -a "(set -l cmd (commandline -opc); kubectl -n \$cmd[2] get pod \$cmd[3] -o jsonpath='{.spec.containers[*].name}' 2>/dev/null)"
