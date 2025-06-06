#!/bin/bash

while true; do
    echo "Starting tmate session..."
    tmate -S /tmp/tmate.sock new-session -d
    tmate -S /tmp/tmate.sock wait tmate-ready

    SSH_CMD=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}')
    WEB_CMD=$(tmate -S /tmp/tmate.sock display -p '#{tmate_web}')

    echo "-----------------------------------"
    echo "🔗 SSH: $SSH_CMD"
    echo "🌐 Web: $WEB_CMD"
    echo "-----------------------------------"

    while tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}' >/dev/null 2>&1; do
        sleep 5
    done

    echo "Disconnected. Reconnecting in 5s..."
    sleep 5
done
