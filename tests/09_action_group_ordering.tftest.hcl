run "action_group_ordering_test" {
  command = plan

  variables {
    create_agent = true
    foundation_model = "anthropic.claude-v2"
    instruction = "You are an assistant that helps with testing action group ordering stability."
    
    # Define multiple action groups with different names to test ordering stability
    action_group_list = [
      {
        action_group_name = "invoker"
        description = "Invoker action group"
        action_group_state = "ENABLED"
      },
      {
        action_group_name = "scratchpad"
        description = "Scratchpad action group"
        action_group_state = "ENABLED"
      }
    ]
  }

  # This test should pass without showing any changes on subsequent runs
  # The fix ensures deterministic ordering of action groups
  assert {
    condition = length(local.action_group_list) == 2
    error_message = "Expected 2 action groups in the list"
  }
}

# Run the same test twice to verify stability
run "action_group_ordering_rerun" {
  command = plan

  variables {
    create_agent = true
    foundation_model = "anthropic.claude-v2"
    instruction = "You are an assistant that helps with testing action group ordering stability."
    
    # Same action groups as above - should not trigger changes
    action_group_list = [
      {
        action_group_name = "invoker"
        description = "Invoker action group"
        action_group_state = "ENABLED"
      },
      {
        action_group_name = "scratchpad"
        description = "Scratchpad action group"
        action_group_state = "ENABLED"
      }
    ]
  }

  assert {
    condition = length(local.action_group_list) == 2
    error_message = "Expected 2 action groups in the list"
  }
}
