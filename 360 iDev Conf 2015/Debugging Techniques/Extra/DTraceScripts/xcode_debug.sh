xcode-debug() {
  lldb -p `ps aux | grep Xcode | grep -v grep | awk '{print $2}'`
}