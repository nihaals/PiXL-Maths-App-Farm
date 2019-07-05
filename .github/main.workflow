workflow "Test and upload on tag" {
  resolves = [
    "Twine upload",
  ]
  on = "push"
}

action "Filter tag" {
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "Test 2.7" {
  uses = "orangutangaming/actions/pytest-install-27@master"
  needs = ["Filter tag"]
}

action "Test 3.5" {
  uses = "orangutangaming/actions/pytest-install-35@master"
  needs = ["Filter tag"]
}

action "Test 3.6" {
  uses = "orangutangaming/actions/pytest-install-36@master"
  needs = ["Filter tag"]
}

action "Test 3.7" {
  uses = "orangutangaming/actions/pytest-install-37@master"
  needs = ["Filter tag"]
}

action "Twine upload" {
  uses = "orangutangaming/actions/twine-upload@master"
  secrets = ["TWINE_PASSWORD", "TWINE_USERNAME"]
  needs = ["Test 2.7", "Test 3.5", "Test 3.6", "Test 3.7"]
}