#!/usr/bin/env zsh

# Enable prompt expansion
setopt PROMPT_SUBST

# Match powerlevel10k configuration
typeset -g BATTERY_LOW_THRESHOLD=30
typeset -g BATTERY_STAGES=(
  $'\UF008E' # 0%
  $'\UF007A' # 10%
  $'\UF007B' # 20%
  $'\UF007C' # 30%
  $'\UF007D' # 40%
  $'\UF007E' # 50%
  $'\UF007F' # 60%
  $'\UF0080' # 70%
  $'\UF0081' # 80%
  $'\UF0082' # 90%
  $'\UF0079' # 100%
)

# Define custom colors using ANSI escape codes
# typeset -gA colors=(
#   [charging]=$(printf '\e[38;2;133;153;0m')    
#   [charged]=$(printf '\e[38;2;133;153;0m')     
#   [disconnected]=$(printf '\e[38;2;220;50;47m')
#   [low]=$(printf '\e[38;2;181;136;0m')          
#   [bg]=$(printf '\e[48;2;21;22;30m')           
#   [reset]=$(printf '\e[0m')                    
# )

# Define custom colors using hexadecimal values for tmux
typeset -gA colors=(
  [charging]="fg=#859900"       # #859900 (green)
  [charged]="fg=#859900"        # #859900 (green)
  [disconnected]="fg=#dc322f"   # #dc322f (red)
  [low]="fg=#b58900"            # #b58900 (yellow)
  [bg]="bg=#073642"             # #15161e (background)
  [reset]="default"          # reset colors
)

function get_battery_info() {
  local bat_percent is_charging=0

  if [[ "$OSTYPE" == linux* && -d "/sys/class/power_supply" ]]; then
    # Try reading from /sys first (more reliable)
    for battery in /sys/class/power_supply/BAT*; do
      if [[ -d $battery ]]; then
        if [[ -f "$battery/capacity" ]]; then
          bat_percent=$(cat "$battery/capacity")
        fi
        if [[ -f "$battery/status" ]]; then
            local battery_status=$(cat "$battery/status")
            if [[ "$battery_status" == "Charging" ]]; then
                is_charging=1
            fi
        fi
        break
      fi
    done
  elif (( $+commands[acpi] )); then
    local raw_data=$(acpi -b 2>/dev/null)
    if [[ -n $raw_data ]]; then
      bat_percent=$(echo $raw_data | grep -o "[0-9]*%" | tr -d %)
      local state_raw=$(echo $raw_data | grep -o "Charging")
      if [[ -n $state_raw ]]; then  
          is_charging=1
      fi
    fi
  fi

  if [[ -n $bat_percent ]]; then
    echo "$bat_percent"
  fi
}

function get_battery_stage() {
  local bat_percent=$1
  local stage_index=$(( (bat_percent * $#BATTERY_STAGES) / 100 ))
  (( stage_index = stage_index < 1 ? 1 : stage_index ))
  (( stage_index = stage_index > $#BATTERY_STAGES ? $#BATTERY_STAGES : stage_index ))
  echo ${BATTERY_STAGES[stage_index]}
}

function battery_prompt_string() {
  local bat_percent=$(get_battery_info)
  
  if [[ -n $bat_percent ]]; then
    local color stage

    # Get the battery stage symbol
    stage=$(get_battery_stage $bat_percent)

    # Determine color based on percentage only (no state)
    if [[ -n $is_charging ]]; then
        color=$colors[charging]
    else
        if (( bat_percent == 100 )); then
            color=$colors[charged]
        elif (( bat_percent < 100 && bat_percent >= $BATTERY_LOW_THRESHOLD )); then
            color=$colors[low]
        else
            color=$colors[disconnected]
        fi
    fi

    # Output the prompt segment without state information
    echo "#[${color},${colors[bg]}]${bat_percent}% ${stage}"
  fi
}

battery_prompt_string
