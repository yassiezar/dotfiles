# Load Mathworks environment config
if test -e /local-ssd
  bass source /mathworks/hub/share/sbtools/bash_setup.bash
  # Set Mathworks perforce editor to NVim
  set -gx P4EDITOR nvim
  set -gx SBTOOLS_VNC_WINDOW_MGR cinnamon-session
  set -gx PATH /home/jlock/.local/bin $PATH
  set -gx PATH /home/jlock/.cargo/bin $PATH

  # Add Mathworks Node to path
  set nodePath (dirname (mw -using Bautosar shell whereis npm | awk '{print $4}'))
  set -gx PATH $nodePath $PATH
end

# ROS2
if test -e ~/ros_workspaces
  bass source ~/ros_workspaces/ros2_humble/install/local_setup.bash
  register-python-argcomplete --shell fish ros2 | source
end

# Enable the z command
zoxide init fish | source

set -gx EDITOR nvim
set -gx VISUAL nvim

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

#bobthefish theme
#set -g theme_display_git no
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
#set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine no
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv no
set -g theme_display_nix no
set -g theme_display_ruby no
set -g theme_display_node yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_date_timezone America/Los_Angeles
set -g theme_avoid_ambiguous_glyphs yes
#set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

# Start a TMUX session
if status is-interactive
and not set -q TMUX
    exec tmux
end
