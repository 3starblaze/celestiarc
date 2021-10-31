extends Node
# warning-ignore-all:unused_signal

signal retry
signal next_level # A request to switch to next level
# Shows whether level has been started and whether physics need to be applied
var level_running = false
const epsilon = 0.0001
