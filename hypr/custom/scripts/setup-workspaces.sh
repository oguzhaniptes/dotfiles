#!/bin/bash
# Dinamik workspace binding: HDMI takılıysa iki gruba böl, yoksa hepsini eDP'ye koy

# Monitor sayısını kontrol et
MONITOR_COUNT=$(hyprctl monitors | grep "Monitor" | wc -l)

if [ $MONITOR_COUNT -ge 2 ]; then
    # HDMI takılı: Workspaces 1-10 → eDP-1, 11-20 → HDMI-A-1
    echo "Multi-monitor detected. Setting up workspace groups..."
    
    # Group 1 (1-10) → eDP-1
    for i in {1..10}; do
        hyprctl keyword workspace "$i,monitor:eDP-1,default:true"
    done
    
    # Group 2 (11-20) → HDMI-A-1
    for i in {11..20}; do
        hyprctl keyword workspace "$i,monitor:HDMI-A-1,default:true"
    done
else
    # Tek monitor: Hepsi eDP-1'e
    echo "Single monitor detected. All workspaces on eDP-1..."
    
    for i in {1..20}; do
        hyprctl keyword workspace "$i,monitor:eDP-1,default:true"
    done
fi
