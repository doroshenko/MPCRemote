# MPC project notes

## I. Server discovery

Search LAN or enter directly

Find valid hosts, default port 13579, scan others

## II. API

### 1. Perform command

* Regular command:
`/command.html?wm_command=[value]`

* Volume change:
`/command.html?wm_command=-2&volume=[percent]`

* Seek: `command.html?wm_command=-1&percent=[percent]`

wm_command defined in `resource.h` - see `wm_command.h`

### 2. Current snapshot

Check if web preview is enabled - can be enabled in MPC options: `/snapshot.jpg`

### 3. Status

Retrieve current server status in html form: `/variables.html`

## III. Check integration with native player controls