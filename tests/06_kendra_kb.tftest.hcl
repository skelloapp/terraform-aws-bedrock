run "kendra_kb_plan" {
  command = plan
  module {
    source = "./examples/kendra-kb"
  }
}

run "kendra_kb_apply" {
  command = apply
  module {
    source = "./examples/kendra-kb"
  }
}
